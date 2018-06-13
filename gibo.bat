@rem #!/dos/rocks!
@setlocal EnableDelayedExpansion
@echo off

rem Script for easily accessing gitignore boilerplates from
rem https://github.com/github/gitignore
rem
rem Change log
rem v1.0    1-May-2012  First public release
rem v1.0.01 16-Aug-2014 Added batch file for DOS by Kody Brown ^<thewizard@wasatchwizard.com^>

goto :setup


:version
    echo %basename% 2.0.0 by Simon Whitaker ^<sw@netcetera.org^>
    echo https://github.com/simonwhitaker/gitignore-boilerplates
    goto :eof

:usage
    call :version
    echo.
    echo Fetches gitignore boilerplates from github.com/github/gitignore
    echo.
    echo Usage:
    echo     %basename% [options]
    echo     %basename% [boilerplate boilerplate...]
    echo.
    echo Example:
    echo     %basename% Python TextMate ^>^> .gitignore
    echo.
    echo Options:
    echo     list          List available boilerplates
    echo     update        Update list of available boilerplates
    echo     help          Display this help text
    echo     version       Display current script version

    goto :eof


:setup
    set "basename=%~n0"
    set "baseext=%~x0"
    set "basepath=%~dp0"
    set dumping=0

    set "remote_repo=https://github.com/github/gitignore.git"
    rem set "local_repo=%UserProfile%\.gitignore-boilerplates"
    set "local_repo=%AppData%\.gitignore-boilerplates"

    rem No args passed in, so show usage.
    if "%~1"=="" call :usage && exit /B 0

:parse
    rem Parse comand-line options.

    if "%~1"=="" exit /B 0

    set a=%~1

    rem The batch file's equivalent 'Sanity check' is that any
    rem options (-, --, and / for Windows) are executed then
    rem the batch file exits, ignoring any other commands, such
    rem as Python

    if "%a%"=="help" call :usage && exit /B 0
    if "%a%"=="version" call :version && exit /B 0
    if "%a%"=="list" call :list && exit /B 0
    if "%a%"=="update" call :update && exit /B 0
    if "%a%"=="dump" set dumping=1 && shift && goto :parse

    if %dumping% equ 1 call :dump "%a%" && shift && goto :parse

:end
    @endlocal && exit /B 0


:clone
    if not "%~1"=="--silently" (
        set "opt=-q"
        if not defined __quiet (
            echo Cloning %remote_repo% to %local_repo%
        )
    )

    git clone %opt% "%remote_repo%" "%local_repo%"

    goto :eof


:init
    if not exist "%local_repo%\.git" call :clone "%~1"
    goto :eof


:list
    call :init

    echo === Languages ===
    echo.
    for /f %%G in ('dir /b /on "%local_repo%\*.gitignore"') do (
        echo %%~nG
    )

    echo.
    echo === Global ===
    echo.
    for /f %%G in ('dir /b /on "%local_repo%\Global\*.gitignore"') do (
        echo %%~nG
    )

    goto :eof


:update
    if not exist "%local_repo%\.git" call :clone && goto :eof

    pushd "%local_repo%"
    git pull --ff origin master
    popd

    goto :eof


:dump
    call :init --silently

    set "language_file=%local_repo%\%~1.gitignore"
    set "global_file=%local_repo%\Global\%~1.gitignore"

    if exist "%language_file%" (
        echo ### %~1
        echo.
        type "%language_file%"
        echo.
        echo.
    ) else if exist "%global_file%" (
        echo ### %~1
        echo.
        type "%global_file%"
        echo.
        echo.
    ) else (
        echo Unknown argument: %~1
    )

    goto :eof
