@echo off  

set path=%~dp0

if not exist %path%png (
   echo 源图片文件夹"png"不存在
   md %path%png
   echo 创建源图片文件夹"png"
   pause
   exit
) 

if not exist %path%atf (
   md %path%atf
   echo 创建目标文件夹"atf"
) 

setlocal enabledelayedexpansion
pushd %path%png

for /f "tokens=* delims=" %%j in ('dir/b/a-d *.png') do (      
       
       set name=%%~nj
       echo 转换 %%j

       %path%tool\png2atf.exe -c -i %%j -o  %path%atf\!name!.atf
)

for /f "tokens=*"  %%i in ('dir/b/ad') do (
   pushd %path%\png\%%i
   
   if not exist %path%\atf\%%i (
           md %path%\atf\%%i
   ) 
   
    for /f "tokens=* delims=" %%j in ('dir/b/a-d *.png') do (      
       
       set name=%%~nj
       echo 转换 %%i\%%j

       %path%tool\png2atf.exe -c -i %%j -o  %path%atf\%%i\!name!.atf
    )
)  







echo 转换结束

pause
