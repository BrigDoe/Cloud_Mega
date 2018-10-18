REM CONEXION A CLOUD SERVICE DE MEGA
::Desconexion de Usuario
echo off
set email=bvera@grupolabovida.com
set SAVESTAMP=%DATE:/=%
set pwd=Blue018.
pushd \\192.168.1.144\Respaldos\BVera\bk\1s\2s\2p\
set filename1=Inalambrik_Sync.7z
set filename2=baselab.7z
set outputfilename=Respaldos_%SAVESTAMP%
set dirTemp=C:\Respaldos_bases\
echo email=%email%
echo pwd=%pwd%
echo filename_1 =%filename1%
echo filename_2 =%filename2%
echo outputfilename=%outputfilename%
echo.
pushd \\192.168.1.144\Respaldos\BVera\bk\1s\2s\2p\
COPY /Y %filename1%  %dirTemp%
COPY /Y %filename2%  %dirTemp%
popd

call C:\Users\BVera\AppData\Local\MEGAcmd\mega-login.bat -v %email% %pwd%
echo -----------------------------------------------
echo -- Usuario %email% conectado --
echo -----------------------------------------------
echo.
call C:\Users\BVera\AppData\Local\MEGAcmd\mega-mkdir.bat -v %outputfilename%
echo -----------------------------------------------
echo -- Creacion de directorio %outputfilename% ----
echo -----------------------------------------------
echo.
call C:\Users\BVera\AppData\Local\MEGAcmd\mega-put.bat -vv %dirTemp%%filename1% %outputfilename%
echo -------------------------------
echo -------Archivo subido 1/2------
echo -------------------------------
call C:\Users\BVera\AppData\Local\MEGAcmd\mega-put.bat -vv %dirTemp%%filename2% %outputfilename%
echo -------------------------------
echo -------Archivo subido 2/2------
echo -------------------------------
::Desconexion de Usuario
echo.
::Desconexion de unidad de virtual

call C:\Users\BVera\AppData\Local\MEGAcmd\mega-logout.bat -v
echo -----------------------------------------------
echo -- Usuario %email% desconectado --
echo -----------------------------------------------
echo.

