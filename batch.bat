@echo off
IF NOT EXIST D: GOTO DriveE
D:
GOTO MakeDir

:DriveE 
echo %CD% 
IF NOT EXIST E: GOTO DriveF
E:
echo %CD%
GOTO MakeDir

:DriveF 
echo %CD% 
IF NOT EXIST F: GOTO DriveG
F:
echo %CD%
GOTO MakeDir

:DriveG
echo %CD% 
IF NOT EXIST G: GOTO NoDrive
echo %CD%
GOTO MakeDir

:NoDrive
echo "Unable to Find Any Drive to Install"
set /p anykey = Press Enter to Exit;
exit


:MakeDir
md CF
echo %CD%
cd %CD%\CF

bitsadmin /transfer my /download "http://stahlworks.com/dev/unzip.exe" "%CD%\unzip.exe"
bitsadmin /transfer mycf /download "https://cli.run.pivotal.io/stable?release=windows64-exe&source=github" "%CD%\cf.zip"
unzip.exe cf.zip
cf logout

set /p user= Enter your Bluemix Username:
set /p pwd= Enter your Bluemix Password:


::cf api https://api.ng.bluemix.net

cf login -u %user% -p %pwd% -a https://api.ng.bluemix.net

cf uninstall-plugin IBM-Containers

cf install-plugin https://static-ice.ng.bluemix.net/ibm-containers-windows_x64.exe -f


:: create random name for namespace 
Setlocal EnableDelayedExpansion
Set _RNDLength=10
Set _Alphanumeric=abcdefghijklmnopqrstuvwxyz_
Set _Str=%_Alphanumeric%987654321
:_LenLoop
IF NOT "%_Str:~18%"=="" SET _Str=%_Str:~9%& SET /A _Len+=9& GOTO :_LenLoop
SET _tmp=%_Str:~9,1%
SET /A _Len=_Len+_tmp
Set _count=0
SET _RndAlphaNum=
:_loop
Set /a _count+=1
SET _RND=%Random%
Set /A _RND=_RND%%%_Len%
SET _RndAlphaNum=!_RndAlphaNum!!_Alphanumeric:~%_RND%,1!
If !_count! lss %_RNDLength% goto _loop
Echo Random string is !_RndAlphaNum!
SET _INC=_1 
SET _RndAlphaNum=!_RndAlphaNum!!_INC!
echo %_RndAlphaNum%

cf ic namespace set %_RndAlphaNum%

start "" https://hub.jazz.net/deploy/index.html?repository=https://github.com/zabihchaudhry/SIT715.git
set /p anykey = Press Enter to Exit;
