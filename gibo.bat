@rem #!/dos/rocks!
@setlocal EnableDelayedExpansion
@echo off

rem Script for easily accessing gitignore boilerplates from
rem https://github.com/github/gitignore
rem
rem Change log
rem v1.0    1-May-2012  First public release
rem v1.0.01 16-Aug-2014 Added batch file for DOS by Kody Brown ^<thewizard@wasatchwizard.com^>
rem v2.0.00 11-Jun-2018 Updated to v2; subcommand model by Simon Whitaker ^<sw@netcetera.org^>
rem v2.0.01 13-Jun-2018 Added optional parameter for list subcommand, added search subcommand, added support for GIBO_BOILERPLATES by Kody Brown ^<thewizard@wasatchwizard.com^>

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
    echo     list [expr]   List available boilerplates
    echo     search expr   Search inside boilerplates for expr
    echo     update        Update list of available boilerplates
    echo     help          Display this help text
    echo     version       Display current script version

    goto :eof


:setup
    set "basename=%~n0"
    set "baseext=%~x0"
    set "basepath=%~dp0"

    set "__cloned="

    set "dumping="

    set "remote_repo=https://github.com/github/gitignore.git"

    rem Allow using the `GIBO_BOILERPLATES` system envar
    rem for specifying the boilerplates directory.
    if defined GIBO_BOILERPLATES set "local_repo=%GIBO_BOILERPLATES%"
    if not defined GIBO_BOILERPLATES set "local_repo=%AppData%\.gitignore-boilerplates"

    rem No args passed in, so show usage.
    if "%~1"=="" call :usage && goto :end

:parse
    rem Parse comand-line options.

    if "%~1"=="" goto :end

    set a=%~1

    rem The batch file's equivalent 'Sanity check' is that any
    rem options (-, --, and / for Windows) are executed then
    rem the batch file exits, ignoring any other commands, such
    rem as Python, etc.

    if /i "%a%"=="help"     call :usage         & goto :end
    if /i "%a%"=="/?"       call :usage         & goto :end
    if /i "%a%"=="version"  call :version       & goto :end
    if /i "%a%"=="/v"       call :version       & goto :end
    if /i "%a%"=="list"     call :list "%~2"    & goto :end
    if /i "%a%"=="search"   call :search "%~2"  & goto :end
    if /i "%a%"=="update"   call :update        & goto :end

    if /i "%a%"=="dump"     set "dumping=1"     & shift & goto :parse

    if defined dumping      call :dump "%a%"    & shift & goto :parse

    goto :invalid_argument "%a%"

:end
    @endlocal && exit /B 0


:invalid_argument "arg"
    echo Invalid argument: %~1
    echo Did you mean:

    rem Is there a .gitignore file?
    set "_foundfile="
    if exist "%local_repo%\%~1.gitignore" set "_foundfile=yes"
    if exist "%local_repo%\Global\%~1.gitignore" set "_foundfile=yes"
    if defined _foundfile (
        echo     `%basename% dump %*`
        echo     `%basename% list %*`
    )

    rem Did the user mean to search within .gitignore files?
    echo     `%basename% search %*`

    endlocal && exit /B 1

:clone [--silently]
    if "%~1"=="--silently" ( set "opt=-q" ) else ( set "opt=" )
    git clone %opt% "%remote_repo%" "%local_repo%"
    goto :eof


:init [--silently]
    if not exist "%local_repo%\.git" set "__cloned=yes" && call :clone "%~1"
    goto :eof


:list
    call :init

    echo === Languages ===
    echo.
    for /f %%G in ('dir /b /on "%local_repo%\*%~1*.gitignore"') do (
        echo %%~nG
    )

    echo.
    echo === Global ===
    echo.
    for /f %%G in ('dir /b /on "%local_repo%\Global\*%~1*.gitignore"') do (
        echo %%~nG
    )

    goto :eof

:search
    if "%~1"=="" echo %basename%: missing search expr.. && goto :eof

    call :init

    rem `findstr` options:
    rem   /R         Uses search strings as regular expressions.
    rem   /S         Searches for matching files in the current directory and all
    rem              subdirectories.
    rem   /I         Specifies that the search is not to be case-sensitive.
    rem   /N         Prints the line number before each line that matches.
    rem   /P         Skip files with non-printable characters.
    rem   /A:attr    Specifies color attribute with two hex digits. See "color /?"
    rem   strings    Text to be searched for.
    rem   [drive:][path]filename
    rem              Specifies a file or files to search.

    pushd "%local_repo%"
    findstr /S /R /I /N /P /A:03 "%~1" *.gitignore
    popd

    goto :eof

:update
    call :init

    rem If the repo was just cloned, don't perform a `pull`
    if not defined __cloned (
        echo updating..
        pushd "%local_repo%"
        git pull -q --autostash --ff origin master
        popd
    )

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
