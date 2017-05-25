@echo off
cls
echo	Machine Building
echo	==================================================v0.0.0.1
set bin=..\bin\machine.bin
set code=..\src\machine\mbr\code.asm
echo %code% initalize...
tools\win\nasm.exe %code% -f bin -o %bin%
echo %bin% done.
echo	==================================================
echo	Build progress complated
echo	--------------------------------------------------
@echo on