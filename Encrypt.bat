
echo off
cls
REM BORRA PANTALLA
echo -------------------------------------
echo -- BACKUP DE BASE DE DATOS baselab --
echo -------------------------------------
set DATABASENAME=Inalambrik_Sync
REM VARIABLE DE NOMBRE DE BASE

echo %DATABASENAME%

:: filename format Name-Date (eg MyDatabase-2009.5.19.bak)
REM NOMBRE DE FORMATO DE SALIDA

for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"

set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "datestamp=%DD%%MM%%YYYY%" & set "timestamp=%HH%%Min%%Sec%"


set DATESTAMP=%datestamp%_%timestamp%
REM ESTAMPA DE FECHA

echo %DATESTAMP%

set BACKUPFILENAME=C:\Respaldos\%DATABASENAME%_%DATESTAMP%.bak
set TEMPDIR=C:\Respaldos\basetemp
REM DIRECTORIO DE SALIDA

echo %BACKUPFILENAME%

set SERVERNAME=SERVIDORP
REM NOMBRE DE SERVIDOR

echo %SERVERNAME%


echo.

sqlcmd -E -S %SERVERNAME% -d master -Q "BACKUP DATABASE [%DATABASENAME%] TO DISK = N'%BACKUPFILENAME%' WITH INIT , NOUNLOAD , NAME = N'%DATABASENAME% backup', NOSKIP , STATS = 10, NOFORMAT"
REM EJECUCION DE SQLCMD CON VARIABLES DEFINIDAS


echo -- SENTENCIA UTILIZADA --
echo sqlcmd -E -S %SERVERNAME% -d master -Q "BACKUP DATABASE [%DATABASENAME%] TO DISK = N'%BACKUPFILENAME%' WITH INIT , NOUNLOAD , NAME = N'%DATABASENAME% backup', NOSKIP , STATS = 10, NOFORMAT"
echo.

echo -- Verificacion de backup
sqlcmd -E -S %SERVERNAME% -d master -Q "RESTORE VERIFYONLY FROM  DISK = N'%BACKUPFILENAME%'" -o C:\respaldos\LogVerify\Log_verify_Inalambrik.txt
echo sqlcmd -E -S %SERVERNAME% -d master -Q "RESTORE VERIFYONLY FROM  DISK = N'%BACKUPFILENAME%'"

REM COPIA A CARPETA TEMPORAL
copy /y %BACKUPFILENAME% %TEMPDIR%\%DATABASENAME%_%DATESTAMP%.bak


REM COMPROBACION DE ZIPEO EN UBUNTU
echo --Copia a unidad en red Ubuntu--


pushd \\192.168.1.144\Respaldos\BVera\bk\1s\2s\2p\
REM Variables de entorno para 7z
set PATH=%PATH%;C:\Archivos de programa\7-Zip\
echo %PATH%
echo off
REM Encriptacion y compresion de archivo BACKUP
echo %TEMPDIR%\%DATABASENAME%_%DATESTAMP%.bak

7z d Inalambrik_Sync.7z
echo "Elmininacion de 7z"

7z u Inalambrik_Sync.7z %TEMPDIR%\%DATABASENAME%_%DATESTAMP%.bak -pPASSWORD

echo -------------------------------
echo --Encriptacion finalizada 1/2--
echo -------------------------------
REM Encriptacion y compresion de archivo BACKUP
echo -- COPIA ULTIMO BAK de baselab A UNIDAD G Respaldos --
copy /y Inalambrik_Sync.7z %BACKUPFILENAME%
echo.
popd
echo -------------------------------
echo --Encriptacion finalizada 2/2--
echo -------------------------------

echo ------------------------------------------
echo -- BACKUP DE Inalambrik_Sync FINALIZADO --
echo ------------------------------------------
echo.
echo -------------------------------------------
echo -- BACKUP DE BASE DE DATOS baselab --------
echo -------------------------------------------
echo.

del %TEMPDIR%\%DATABASENAME%_%DATESTAMP%.bak

set DATABASENAME=baselab
REM VARIABLE DE NOMBRE DE BASE

for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"

set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "datestamp=%DD%%MM%%YYYY%" & set "timestamp=%HH%%Min%%Sec%"


set DATESTAMP=%datestamp%_%timestamp%
REM ESTAMPA DE FECHA

echo %DATESTAMP%

set BACKUPFILENAME=C:\Respaldos\%DATABASENAME%_%DATESTAMP%.bak
REM DIRECTORIO DE SALIDA

echo %BACKUPFILENAME%

echo %SERVERNAME%

echo.
sqlcmd -E -S %SERVERNAME% -d master -Q "BACKUP DATABASE [%DATABASENAME%] TO DISK =N'%BACKUPFILENAME%' WITH INIT , NOUNLOAD , NAME = N'%DATABASENAME% backup', NOSKIP , STATS = 10, NOFORMAT"
REM EJECUCION DE SQLCMD CON VARIABLES DEFINIDAS
echo.
echo -- SENTENCIA UTILIZADA --
echo sqlcmd -E -S %SERVERNAME% -d master -Q "BACKUP DATABASE [%DATABASENAME%] TO DISK =N'%BACKUPFILENAME%' WITH INIT , NOUNLOAD , NAME = N'%DATABASENAME% backup', NOSKIP , STATS = 10, NOFORMAT"
echo -- Verificacion de backup
sqlcmd -E -S %SERVERNAME% -d master -Q "RESTORE VERIFYONLY FROM  DISK = N'%BACKUPFILENAME%'" -o C:\respaldos\LogVerify\Log_verify_baselab.txt
echo sqlcmd -E -S %SERVERNAME% -d master -Q "RESTORE VERIFYONLY FROM  DISK = N'%BACKUPFILENAME%'"

pushd \\192.168.1.144\Respaldos\BVera\bk\1s\2s\2p\
REM Variables de entorno para 7z
set PATH=%PATH%;C:\Archivos de programa\7-Zip\
echo %PATH%
echo off
7z d baselab.7z
echo "Elmininacion de 7z"
REM Encriptacion y compresion de archivo BACKUP
7z a baselab.7z C:\Respaldos\%DATABASENAME%_%DATESTAMP%.bak -pSoporteLabovida7
echo -------------------------------
echo --Encriptacion finalizada 1/2--
echo -------------------------------
REM Encriptacion y compresion de archivo BACKUP
copy /y baselab.7z C:\Respaldos\baselab.7z
echo.
popd
echo -------------------------------
echo --Encriptacion finalizada 2/2--
echo -------------------------------
echo.