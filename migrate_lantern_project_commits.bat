@echo off
setlocal
set REPO=%USERPROFILE%\Documents\Lantern_Project
set ZIP=%USERPROFILE%\Downloads\Lantern_Project_GitHub_Migration_Package.zip
set TEMP=%TEMP%\Lantern_Migration_Package

if not exist "%REPO%\.git" (
  echo ERROR: Git repo not found at %REPO%
  echo Put your repo at Documents\Lantern_Project or edit this script.
  pause
  exit /b 1
)

if not exist "%ZIP%" (
  echo ERROR: Migration ZIP not found at %ZIP%
  echo Download Lantern_Project_GitHub_Migration_Package.zip into your Downloads folder first.
  pause
  exit /b 1
)

rmdir /s /q "%TEMP%" 2>nul
mkdir "%TEMP%"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Expand-Archive -Force '%ZIP%' '%TEMP%'"

cd /d "%REPO%"

xcopy "%TEMP%\Lantern_Project_GitHub_Migration_Package\Lantern_Bootstrap_v7_GitHub_Source_Of_Truth.md" "%REPO%\" /Y
git add Lantern_Bootstrap_v7_GitHub_Source_Of_Truth.md LIVE_CANON_INDEX.md README.md .gitignore
git commit -m "Add GitHub source of truth bootstrap"

xcopy "%TEMP%\Lantern_Project_GitHub_Migration_Package\Canon_Core" "%REPO%\Canon_Core\" /E /I /Y
git add Canon_Core
git commit -m "Migrate canon core documents"

xcopy "%TEMP%\Lantern_Project_GitHub_Migration_Package\Metadata" "%REPO%\Metadata\" /E /I /Y
git add Metadata
git commit -m "Migrate Lantern metadata documents"

xcopy "%TEMP%\Lantern_Project_GitHub_Migration_Package\Bestiary" "%REPO%\Bestiary\" /E /I /Y
git add Bestiary
git commit -m "Migrate Lantern Forest bestiary reference"

xcopy "%TEMP%\Lantern_Project_GitHub_Migration_Package\Visual_References" "%REPO%\Visual_References\" /E /I /Y
git add Visual_References
git commit -m "Migrate visual reference archive"

xcopy "%TEMP%\Lantern_Project_GitHub_Migration_Package\Novels" "%REPO%\Novels\" /E /I /Y
xcopy "%TEMP%\Lantern_Project_GitHub_Migration_Package\Exports" "%REPO%\Exports\" /E /I /Y
xcopy "%TEMP%\Lantern_Project_GitHub_Migration_Package\Games" "%REPO%\Games\" /E /I /Y
git add Novels Exports Games
git commit -m "Add project workspace placeholders"

git status

echo.
echo If everything looks good, pushing to GitHub now...
git push origin main

echo.
echo Done. Refresh GitHub to confirm the files are there.
pause
