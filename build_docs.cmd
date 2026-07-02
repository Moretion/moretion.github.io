@echo off
chcp 65001 >nul
REM Wrapper: run build_docs.sh via Git Bash from PowerShell or cmd.
REM Locates bash.exe explicitly (Git for Windows does NOT put bash on PATH
REM by default, only git). Usage:
REM   .\build_docs.cmd --dry-run
REM   .\build_docs.cmd --only dev_z1,softw_sp
REM   .\build_docs.cmd --all

set "SH=%~dp0build_docs.sh"
set "BASH="

REM 1) bash already on PATH?
where bash >nul 2>&1 && set "BASH=bash"

REM 2) Fallback: common Git for Windows install locations
if not defined BASH if exist "%ProgramFiles%\Git\bin\bash.exe" set "BASH=%ProgramFiles%\Git\bin\bash.exe"
if not defined BASH if exist "%ProgramFiles%\Git\usr\bin\bash.exe" set "BASH=%ProgramFiles%\Git\usr\bin\bash.exe"
if not defined BASH if exist "%LOCALAPPDATA%\Programs\Git\bin\bash.exe" set "BASH=%LOCALAPPDATA%\Programs\Git\bin\bash.exe"
if not defined BASH if exist "%ProgramFiles(x86)%\Git\bin\bash.exe" set "BASH=%ProgramFiles(x86)%\Git\bin\bash.exe"

if not defined BASH (
  echo [build_docs] bash.exe not found. Install Git for Windows or add it to PATH. 1>&2
  exit /b 1
)

"%BASH%" "%SH%" %*
exit /b %errorlevel%
