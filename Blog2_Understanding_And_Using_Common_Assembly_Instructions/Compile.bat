::ml64.exe Main.asm /link /ENTRY:Main /SUBSYSTEM:CONSOLE /MACHINE:x64 /OUT:Output.exe 

:: Outputs the pdb file for debugging using WinDbg 
ml64.exe /Zi Main.asm /link /ENTRY:Main /SUBSYSTEM:CONSOLE /MACHINE:x64 /OUT:Output.exe /PDB:Output.pdb
