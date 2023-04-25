python linkcopy.py release.lua modinfo.lua publish/modinfo.lua
copy /Y modmain.lua publish\
copy /Y LICENSE publish\
copy /Y README.md publish\
xcopy /Y /E scripts\ publish\scripts\
del DoNotEatTooMuch.zip
7z a DoNotEatTooMuch.zip .\publish\*
pause