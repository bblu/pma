rem edit_by_bblu_@_2016-07-05 
@echo off     
setlocal
set REPOS=%1
set TXN=%2
 
rem check log length 
svnlook log %REPOS% -t %TXN% | findstr "............" > nul
if %errorlevel% gtr 0 goto tooShort

rem check log header [B|T]
svnlook log %REPOS% -t %TXN% | findstr "^[TB][0-9]..........." > nul
if %errorlevel% gtr 0 goto wrongHeader

exit 0

:tooShort
echo "The input log is too short!(len > 12)">&2
exit 1

:wrongHeader
echo "The input log header is illegal!('B'or'T' ahead append Task or Bug ID)">&2
exit 1

:multiLine
echo "The log need to be a single line!">&2
exit 1
