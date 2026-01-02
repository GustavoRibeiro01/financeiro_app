@echo off
echo ========================================
echo   Removedor de Java - Financeiro App
echo ========================================
echo.

echo [1/4] Encerrando processos Java...
taskkill /F /IM java.exe /T 2>nul
taskkill /F /IM javaw.exe /T 2>nul
timeout /t 2 /nobreak >nul
echo      ✓ Processos encerrados

echo.
echo [2/4] Removendo pastas do Java...
rd /s /q "C:\Program Files\Java" 2>nul
rd /s /q "C:\Program Files (x86)\Java" 2>nul
echo      ✓ Pastas removidas

echo.
echo [3/4] Removendo cache do Gradle...
rd /s /q "%USERPROFILE%\.gradle" 2>nul
echo      ✓ Cache removido

echo.
echo [4/4] Limpando projeto Flutter...
cd /d "d:\Desenvolvimento de projetos\App Financeiro\financeiro_app"
call flutter clean
rd /s /q "android\.gradle" 2>nul
rd /s /q "android\build" 2>nul
rd /s /q "android\app\build" 2>nul
echo      ✓ Projeto limpo

echo.
echo ========================================
echo   ✓ Java completamente removido!
echo ========================================
echo.
echo Próximos passos:
echo 1. Baixe Java 17 de:
echo    https://www.oracle.com/java/technologies/downloads/#jdk17-windows
echo.
echo 2. Instale o Java 17 (use instalação padrão)
echo.
echo 3. Configure no Flutter:
echo    flutter config --jdk-dir="C:\Program Files\Java\jdk-17"
echo.
echo 4. Execute o app:
echo    flutter run
echo.
pause
