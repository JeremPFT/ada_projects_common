@echo off

REM trying to print updated and todo projects at the end ... no luck yet, it's not bash :(

echo. > ..\todo_list.txt

set toDate=()
set toDo=()

set directories=(org.opentoken-6.0b ^
    code_generator ^
    common ^
    code_generator_input ^
    code_generator_model ^
    code_generator_output ^
    utils_assertions ^
    utils_files_services ^
    utils_strings_services ^
    utils_templates ^
    )

pushd ..

for %%d in %directories% do (
    if "%%d" NEQ "" (
        call :gitStatus %%d
    )
)

echo.
echo.Results in todo_list.txt
echo.(if no output, nothing to do)

popd

REM ===== gitStatus ====
:gitStatus
set directory=%~1
if "%directory%"=="" goto :EOF
if not exist "%directory%" (
   echo directory not found: "%directory%"
) else (
  echo.==========
  echo.Checking %directory%
  echo.==========
  pushd %directory%
  FOR /F "tokens=*" %%g IN ('git status --porcelain') do (
      echo.%directory%\%%g >> ..\todo_list.txt
  )
  popd
)
goto :EOF
REM ===== gitStatus ====
