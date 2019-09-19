@echo off
cd %~dp0
powershell -ExecutionPolicy RemoteSigned -file %~dp0\SDelete.ps1 %1