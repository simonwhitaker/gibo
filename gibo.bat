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
    echo %basename% 1.0.4 by Simon Whitaker ^<sw@netcetera.org^>
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
    echo     -l, --list          List available boilerplates
    echo     -u, --upgrade       Upgrade list of available boilerplates
    echo     -h, --help          Display this help text
    echo     -v, --version       Display current script version

    goto :eof


:setup
    set "basename=%~n0"
    set "baseext=%~x0"
    set "basepath=%~dp0"

    set "__quiet="
    set "__verbose="
    set "__pause="

    set "remote_repo=https://github.com/github/gitignore.git"
    rem set "local_repo=%UserProfile%\.gitignore-boilerplates"
    set "local_repo=%AppData%\.gitignore-boilerplates"

    rem No args passed in, so show usage.
    if "%~1"=="" call :usage && exit /B 0

:parse
    rem Parse comand-line options.

    if "%~1"=="" goto :main

    if not defined __quiet (
        if defined __verbose echo parse^('%~1'^)
    )

    set a=%~1
    :: Replace all '--' with '-' (for options)
    set a=%a:--=-%
    :: Get the first 2 characters of `a`
    set a2=%a:~0,2%

    rem The batch file's equivalent 'Sanity check' is that any
    rem options (-, --, and / for Windows) are executed then
    rem the batch file exits, ignoring any other commands, such
    rem as Python

    if /i "%a%"=="/?" call :usage && endlocal && exit /B 0
    if /i "%a2%"=="-h" call :usage && endlocal && exit /B 0

    if /i "%a2%"=="-q" set "__quiet=1" && shift && goto :parse
    if /i "%a2%"=="/q" set "__quiet=1" && shift && goto :parse

    if /i "%a%"=="-verbose" set "__verbose=1" && shift && goto :parse
    if /i "%a%"=="/verbose" set "__verbose=1" && shift && goto :parse

    if /i "%a2%"=="-p" set "__pause=1" && shift && goto :parse
    if /i "%a2%"=="/p" set "__pause=1" && shift && goto :parse

    rem rem Takes the next argument also (calls shift twice)..
    rem if /i "%a2%"=="-repo" set "remote_repo=%~2" && shift && shift && goto :parse
    rem if /i "%a2%"=="/repo" set "remote_repo=%~2" && shift && shift && goto :parse

    if /i "%a2%"=="-v" call :version && exit /B 0
    if /i "%a2%"=="/v" call :version && exit /B 0

    if /i "%a2%"=="-l" call :list && exit /B 0
    if /i "%a2%"=="/l" call :list && exit /B 0

    if /i "%a2%"=="-u" call :upgrade && exit /B 0
    if /i "%a2%"=="/u" call :upgrade && exit /B 0

    call :dump "%a%"

    shift
    goto :parse

:main
    if not defined __quiet (
        if defined __verbose echo main^(^)
    )
    if defined __pause pause

:end
    @endlocal && exit /B 0


:clone
    if not defined __quiet (
        if defined __verbose echo clone^(^)
    )

    if not "%~1"=="--silently" (
        set "opt=-q"
        if not defined __quiet (
            echo Cloning %remote_repo% to %local_repo%
        )
    )

    git clone %opt% "%remote_repo%" "%local_repo%"

    goto :eof


:init
    if not defined __quiet (
        if defined __verbose echo init^(^)
    )

    if not exist "%local_repo%\.git" call :clone "%~1"
    goto :eof


:list
    if not defined __quiet (
        if defined __verbose echo list^(^)
    )

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


:upgrade
    if not defined __quiet (
        if defined __verbose echo upgrade^(^)
    )

    if not exist "%local_repo%\.git" call :clone && goto :eof

    pushd "%local_repo%"
    git pull origin master
    popd

    goto :eof


:dump
    if not defined __quiet (
        if defined __verbose echo dump^('%~1'^)
    )

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
