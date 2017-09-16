;Lineage 2 authorization port changer, version 1.2b
;Copyleft (?) GoldFinch, 2008
;
;You may freely use, modify and distribute this code.
;
;Compile this file with fasm (http://flatassembler.net)
;===================== SETUPS ===========================
;pattern
virtual
   use32
   ;- begin -
   pushd 2106
   ;- end ---
   load PATTERN dword from $$
end virtual
;================ MACRO DEFINITIONS =====================
;High-level-like imported api calls macro.
;Lite version with procedure calls and string constants with "\n" support.
macro IMPORTS [dll,funclist] {
common	data import
forward dd 0,0,0,rva a#dll, rva v#dll
common	dd 0,0,0,0,0
	end data
forward v#dll: irp func,funclist \{
	    p\#func dd rva a\#func
	    macro func [line*] \\{common
		  match (arglist)tail,line* \\\{ push_r arglist \\\}
		  call [p\#func] \\} \}
	dd 0
forward a#dll db `dll#".dll",0
	irp func,funclist \{a\#func db 0,0,\`func,0\} }
macro push_r [arg] { reverse
      if arg eqtype ""
	 call @f
	 local str
	 str db arg,0
 @@:	 fix_str str,$-str
      else
	 pushd arg
      end if }
macro fix_str pStr,nLen {
      repeat nLen-1
	     load w word from pStr+%-1
	     if w="\n"
		store word 0x0D0A at pStr+%-1
	     end if
      end repeat }
;==============================================
;Some console output macro (print and println)
macro __print text {
      local size,str
      push_r size,0,0
      call @f
      str db text
 @@:  size = $-str
      fix_str str,size
      WriteFile([stdout]) }
macro __printf format,[arglist] {
common	wsprintfA(gMsgBuf,format,arglist)
	local ..argcount
	..argcount=0
forward ..argcount=..argcount+1
common	add esp,8+..argcount*4
	WriteFile([stdout],gMsgBuf,eax,0,0) }
macro print format,[arg] {common
      if arg eq
	 __print format
      else
	 __printf format,arg
      end if }
macro println format,[arglist] {common print format#"\n",arglist}
;********************* PROGPAM CODE **************************************************
format PE console
section 'O_o' code readable executable writeable
IMPORTS KERNEL32, < GetStdHandle,WriteFile,ReadFile,CreateFileA,SetFilePointer,GetLastError,CopyFileA,LoadLibraryA,CloseHandle,\
		    FreeLibrary,DeleteFileA,ExitProcess>,\
	USER32,<wsprintfA>
    entry $
    GetStdHandle(-11) ;STD_OUTPUT_HANDLE
    mov [stdout],eax
    GetStdHandle(-10) ;STD_INPUT_HANDLE
    mov [stdin],eax
    print "L2 authorization port changer version 1.2b\nCopyleft (?) GoldFinch, 2008\n\n"#\
	  "This program changes auth port number in engine.dll\nIt must be placed in lineage2\system folder\n"#\
	  "Enter '1' to proceed or nothing to terminate program: "
    ReadFile([stdin],gMsgBuf,1024,nRead,0)
	cmp byte[gMsgBuf],"1"
	jne exit_err
    ;------------------------------------------------
    ;[1] Analyse file
    print "Opening engine.dll ... "
    CreateFileA("engine.dll",0xC0000000,1,0,3,0,0)
    cmp eax,-1
	jnz open_ok
	GetLastError()
	println "failed with error code = %#x",eax
	jmp exit_err
open_ok:
	mov [hFile],eax
	println "OK"
    ;Get PE header offset
    SetFilePointer([hFile],0x3C,0,0)
    ReadFile([hFile],dwPE,4,nRead,0)
    ;Get entrypoint
    mov eax,[dwPE]
    add eax,0x28
    SetFilePointer([hFile],eax,0,0)
    ReadFile([hFile],Entrypoint,4,nRead,0)
    ;Check if file was patched
    cmp [Entrypoint],4
	jnz not_patched
    ;_______________________________________________
    ;File is already patched
    println "WARNING: File is already patched";
    ;Get port value
    SetFilePointer([hFile],port_value-__patch_data,0,0)
    ReadFile([hFile],port_value,4,nRead,0)
    println "Current port number is %d",[port_value]
    ;Ask new port value
    call InputPortNumber
    ;Write new port value
    SetFilePointer([hFile],port_value-__patch_data,0,0)
    WriteFile([hFile],port_value,4,nWritten,0)
    CloseHandle([hFile])
    ;Exit
    println "Port number was changed.\n\nPress [Enter] to close log."
    ReadFile([stdin],gMsgBuf,1,nRead,0) ;OR die ()
    ExitProcess(0)
    ;_______________________________________________
    ;File is not patched
not_patched:
    ;Make a copy of file to load it
    print "Creating temporary file engine.tmp ... "
    CopyFileA("engine.dll","engine.tmp",0)
	test eax,eax
	jnz copy_ok
	GetLastError()
	println "failed with error code = %#x",eax
	jmp exit_err
copy_ok:
	println "OK"
    ;Load dll
    print "Loading engine.tmp ... "
    LoadLibraryA("engine.tmp")
	test eax,eax
	jnz load_ok
	GetLastError()
	println "failed with error code = %#x",eax
	DeleteFileA("engine.tmp")
	jmp exit_err
load_ok:
	mov [hEngine],eax
	println "OK"
    ;Get image size
    mov eax,[hEngine]
    add eax,[dwPE]
    pushd [eax+0x50] ;SizeOfImage
    popd [SizeOfImage]
    ;Find pattern
    print "Looking for the pattern %#08x ... ",PATTERN
    mov edi,[hEngine]
    mov ecx,[SizeOfImage]
    mov eax,PATTERN
    cld
@@: repne scasb
	test ecx,ecx
	jz @f
	cmp dword[edi-1],eax
	jne @r
	jmp _found
@@:	println "not found. \n   Base=%x, Size=%x",[hEngine],[SizeOfImage]
	jmp exit_err
_found:
    sub edi,[hEngine] ;get rva
    println "OK, found at rva %#x",edi
    add [port_delta],edi
    ;Ask port number
    call InputPortNumber
    ;Change entrypoint
    mov eax,[Entrypoint]
    add [oep_rel],eax
    mov [Entrypoint],4
    mov eax,[dwPE]
    add eax,0x28 ;Entrypoint
    SetFilePointer([hFile],eax,0,0)
    WriteFile([hFile],Entrypoint,4,nWritten,0)
    ;Write patch code
    SetFilePointer([hFile],0,0,0)
    WriteFile([hFile],__patch_data,__patch_size,nWritten,0)
    println "%#x bytes was written.\nEngine.dll was patched with new auth port number.",[nWritten]
    CloseHandle([hFile])
    ;Exit
    println "\nNow this program will be terminated.\nYou can use it to change port number again.\n"#\
	    "Warning: probably, this program will crash now, it's normal for this version.\n\n"#\
	    "Press [Enter] to close log."
    ReadFile([stdin],gMsgBuf,1,nRead,0)
    FreeLibrary([hEngine])
    DeleteFileA("engine.tmp")
    ExitProcess(0)
    ;---------------------------
exit_err:
    println "\nPress [Enter] to close log."
    ReadFile([stdin],gMsgBuf,1,nRead,0)
    ExitProcess(0)
;------------------
InputPortNumber: ;Asking a port number
    print "Input new port number to patch or nothing to abort patching:\n-> "
    ReadFile([stdin],gMsgBuf,10,nRead,0)
    xor eax,eax ;for digits
    xor edx,edx ;for a number
    cld
    mov esi,gMsgBuf
    mov ecx,[nRead]
    sub cl,2 ;strip CR,lF
    jz	exit_err ;lmp if empty line
str2dw_loo:
	lodsb
	imul edx,10
	sub al,"0"
	cmp al,9
	ja exit_err ;jmp if not a number
	add edx,eax
    loop str2dw_loo
    mov [port_value],edx
    ret
;_____________________________________________
;Patch body
align 16
__patch_data:
	   dd "MZ"
	   ;new entrypoint will be here
	   pushd [esp+0x0C] ;copy Dllmain arguments
	   pushd [esp+0x0C]
	   pushd [esp+0x0C]
	   ;call themida "original" entry point
	   db 0xE8 ;"call rel32"
	   ;Relative offset. Must be equal to (OEP RVA) - (ret_addr RVA)
oep_rel:   dd -(ret_addr-__patch_data) ;= negative ret_addr RVA, add (OEP RVA) here
ret_addr:  call __base
__base:    pop edx  ;get __base virtual address, rva=4
	   ;in-memory patch
	   db 0xC7,0x82 ;mov dword[edx+imm32],imm32
	   ;Patch place delta offset. Must be equal to (PortValue RVA) - (__base RVA)
port_delta dd -(__base-__patch_data) ;= negative __base RVA, add (PortValue RVA) here
port_value dd 0 ;rva 0x0C ;write desired port value here
	   ret 0x0C ;return to OS
__patch_size=$-__patch_data
;_____________________________________________
;Uninitialized data. Must be at end of section
dwPE dd ?
Entrypoint dd ?
SizeOfImage dd ?
;---------------
hFile dd ?
hEngine dd ?
;---------------
nRead dd ?
org $-4
nWritten dd ?
stdout dd ?
stdin dd ?
gMsgBuf db 1024 dup (?)
