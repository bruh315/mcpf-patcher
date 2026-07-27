@echo off
title MCFP - Patching Minecraft JARs
setlocal enabledelayedexpansion
for %%f in ("*.mcp") do (
	echo [LOADING PATCHFILE %%f]
	for /f "tokens=1,2,* delims==" %%a in ('type "%%f"') do (
		if "%%a"=="version" (
			echo [DOWNLOADING ORIGINAL JAR]
			curl -L -s -o original.jar "%%b" > nul
			if "!errorlevel!" neq "0" (
				echo Downloading original JAR failed.
				pause > nul
				exit
			)
			if exist "src" (
				rmdir /S /Q "src" > nul 2>&1
			)
			mkdir src > nul 2>&1
			cd src
			jar xf "..\original.jar"
			if "!errorlevel!" NEQ "0" (
				echo Extracting JAR failed.
				pause > nul
				exit /b 1
			)
		)
		if "%%a"=="del" (
			echo [DELETING FILE %%b]
			del /Q /F "%%b" 2>nul 1>&2
		)
		if "%%a"=="rem" (
			echo [REMOVING DIRE %%b]
			rmdir /S /Q "%%b" 2>nul 1>&2
		)
		if "%%a"=="patch" (
			echo [PATCHING FILE %%b]
			curl -L -s -o "%%b" "%%c" > nul 2>&1
			if "!errorlevel!" neq "0" (
				echo Downloading assets failed!
				pause > nul
				exit /b 1
			)
		)
		if "%%a"=="output" (
			echo [OUTPUTTING FINAL VERSION]
			mkdir "%appdata%\.minecraft\versions\%%b"
			set "errorlevel=0"
			curl -L -s -o "%appdata%\.minecraft\versions\%%b\%%b.json" "%%c" > nul
			if "!errorlevel!" NEQ "0" (
				echo Downloading JSON version manifest failed...
				pause > nul
				exit /b 1
			)
			echo [REZIPPING JAR]
			jar cMf "%appdata%\.minecraft\versions\%%b\%%b.jar" "."
			echo Done!
			echo The profile will be called %%b!
		)
		rmdir /S /Q src
	)
)