copy /Y release.lua+modinfo.lua publish\modinfo.lua
copy /Y modmain.lua publish\
copy /Y LICENSE publish\
copy /Y README.md publish\
xcopy /Y /E scripts\ publish\scripts\
pause