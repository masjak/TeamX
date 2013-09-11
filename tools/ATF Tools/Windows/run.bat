@echo off  

set path=%~dp0

if not exist %path%png (
   echo ԴͼƬ�ļ���"png"������
   md %path%png
   echo ����ԴͼƬ�ļ���"png"
   pause
   exit
) 

if not exist %path%atf (
   md %path%atf
   echo ����Ŀ���ļ���"atf"
) 

setlocal enabledelayedexpansion
pushd %path%png

for /f "tokens=* delims=" %%j in ('dir/b/a-d *.png') do (      
       
       set name=%%~nj
       echo ת�� %%j

       %path%tool\png2atf.exe -c -i %%j -o  %path%atf\!name!.atf
)

for /f "tokens=*"  %%i in ('dir/b/ad') do (
   pushd %path%\png\%%i
   
   if not exist %path%\atf\%%i (
           md %path%\atf\%%i
   ) 
   
    for /f "tokens=* delims=" %%j in ('dir/b/a-d *.png') do (      
       
       set name=%%~nj
       echo ת�� %%i\%%j

       %path%tool\png2atf.exe -c -i %%j -o  %path%atf\%%i\!name!.atf
    )
)  







echo ת������

pause
