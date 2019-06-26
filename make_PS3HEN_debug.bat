@echo off
cls
set PS3SDK=/c/PSDK3v2
set WIN_PS3SDK=C:/PSDK3v2
set PS3DEV=%PS3SDK%/ps3dev2
set PATH=%WIN_PS3SDK%/mingw/msys/1.0/bin;%WIN_PS3SDK%/mingw/bin;%PS3DEV%/ppu/bin;
set CYGWIN=C:\PSDK3v2\MinGW\msys\1.0\bin

mv  *CEX_482 *CEX_484  PS3HEN_GEN
cd henplugin
%CYGWIN%\bash -i -c 'make debug; rm -r objs; rm henplugin.prx; rm henplugin.sym; mv henplugin.sprx ../PS3HEN_GEN;'
cd ../stage0_file
rm -f *.o *.elf *.self *.bin *.map ../lv1/src/*.o ../debug/src/*.o ../lv2/src/*.o
make -f Makefile all
rm -f *.o *.elf *.self ../lv1/src/*.o ../debug/src/*.o ../lv2/src/*.o
cd ../payload
rm -f *.o *.elf *.self *.bin *.map ../lv1/src/*.o ../debug/src/*.o ../lv2/src/*.o
make -f Makefile debug
rm -f *.o *.elf *.self ../lv1/src/*.o ../debug/src/*.o ../lv2/src/*.o
cd ..
mv  *482C *484C PS3HEN_GEN
cd PS3HEN_GEN
gcc main.c  -o HEN_GEN
HEN_GEN PS3HEN.BIN_CEX_482 stage2.bin_debug_482C stage0.bin_482C HENplugin.sprx
HEN_GEN PS3HEN.BIN_CEX_484 stage2.bin_debug_484C stage0.bin_484C HENplugin.sprx
rm stage* *.sprx *.exe
mv PS3HEN* ../
pause