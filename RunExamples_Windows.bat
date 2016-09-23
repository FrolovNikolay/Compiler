for %%i in ("%~dp0\Examples\*.java") do (
	%~dp0\Windows\Debug\WindowsCompiler.exe < %%i
)