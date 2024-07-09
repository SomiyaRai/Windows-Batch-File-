@echo off
cls
TITLE Somiya Rai 
:menu
echo ===========================================
echo Welcome to the Directory Management System
echo ===========================================
echo 1. Create a directory structure
echo 2. Rename a directory or file
echo 3. Create a new folder
echo 4. Create a new file
echo 5. Delete an existing folder
echo 6. Delete an existing file
echo 7. Rename an existing folder
echo 8. Rename an existing file
echo 9. Go inside a directory
echo 10. Go to previous directory
echo 11. Display tree structure
echo q. Exit the program
echo ===========================================
set /p choice=Enter your choice: 

if "%choice%"=="1" goto create_structure
if "%choice%"=="2" goto rename
if "%choice%"=="3" goto create_directory
if "%choice%"=="4" goto create_file
if "%choice%"=="5" goto delete_directory
if "%choice%"=="6" goto delete_file
if "%choice%"=="7" goto rename_directory
if "%choice%"=="8" goto rename_file
if "%choice%"=="9" goto change_directory
if "%choice%"=="10" goto previous_directory
if "%choice%"=="11" goto show_tree
if /i "%choice%"=="q" exit
echo Invalid choice. Please enter a valid option.
pause
goto menu

:create_structure
set /p root_dir=Enter the name of the root directory: 
set /p path=Enter the path to create the root directory: 
if "%root_dir%"=="" (
    echo Directory name cannot be empty.
    pause
    goto create_structure
)
if "%path%"=="" (
    echo Path cannot be empty.
    pause
    goto create_structure
)
if not exist "%path%" mkdir "%path%"
cd /d "%path%"
mkdir "%root_dir%"
cd "%root_dir%"

:sub_dir_loop
set /p sub_dir=Enter name of the subdirectory (or type 'done' to finish): 
if "%sub_dir%"=="done" goto menu
if "%sub_dir%"=="" (
    echo Subdirectory name cannot be empty.
    pause
    goto sub_dir_loop
)
mkdir "%sub_dir%"
cd "%sub_dir%"

:file_loop
set /p file_name=Enter name of the file (or type 'done' to finish): 
if "%file_name%"=="done" cd .. & goto sub_dir_loop
if "%file_name%"=="" (
    echo File name cannot be empty.
    pause
    goto file_loop
)
set /p content=Enter the content of the file: 
echo %content% > "%file_name%.txt"
goto file_loop

:rename
set /p path=Enter the path of the file or directory: 
set /p oldname=Enter the name of the directory or file: 
set /p newname=Enter the new name of the directory or file: 
cd /d "%path%"
ren "%oldname%" "%newname%"
pause
goto menu


:create_directory
set /p folder=Enter the name of the folder you want to create: 
mkdir "%folder%"
goto menu

:create_file
set /p folder_path=Enter the path of the folder where you want to create the file: 
set /p file_name=Enter the name of the file you want to create: 
if not exist "%folder_path%" (
    mkdir "%folder_path%"
)
set /p file_content=Enter the content of the file: 
echo %file_content% > "%folder_path%\%file_name%.txt"
goto menu

:delete_directory
set /p folder=Enter the name of the folder you want to delete: 
rmdir /s /q "%folder%"
goto menu

:delete_file
set /p file=Enter the name of the file you want to delete: 
del "%file%"
goto menu

:rename_directory
set /p oldname=Enter the name of the folder you want to rename: 
set /p newname=Enter a new name for this folder: 
ren "%oldname%" "%newname%"
goto menu

:rename_file
set /p oldname=Enter the name of the file you want to rename: 
set /p newname=Enter a new name for this file: 
ren "%oldname%" "%newname%"
goto menu

:change_directory
set /p folder=Enter the name of the folder you want to go to: 
if exist "%folder%" (
    cd "%folder%"
    echo Now inside %folder%.
) else (
    echo "%folder%" does not exist.
)
goto menu

:previous_directory
cd ..
echo Now in previous directory.
goto menu

:show_tree
tree /f
goto menu



