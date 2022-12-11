@echo on
md %PREFIX%\Scripts
gcc -DPIKCHR_SHELL=1 -lm -o "%PREFIX%\Scripts\pikchr.exe" "extsrc\pikchr.c"
