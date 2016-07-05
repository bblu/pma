rem by bblu @ xiamen
set REPOS=%1
set REV=%2
set TXN_NAME=%3
rem change pwd for svnlook to find formate
E:
cd E:\Repositories\sggis
rem 修改系统短日期格式为 yyyy-MM-dd
rem set YMD=%date% 却不一定靠谱
set YMD=%date:~0,4%-%date:~5,2%-%date:~8,2%
set INFO_LOG=E:\Repositories\%YMD%.log
set HOOK_DIR=%REPOS%\hooks
set SVNLOOK=svnlook
set PYTHON=C:\Python27\python
rem echo "repo=%REPOS%,rev=%REV%,txn=%TXN_NAME%" >> %INFO_LOG% 
%PYTHON% %HOOK_DIR%\getuserinfo.py %SVNLOOK% %REPOS% %REV% %INFO_LOG%
	
