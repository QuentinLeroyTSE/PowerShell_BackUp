# Tree creationfor test purpose

#set-location "C:\Users\Quentin\Dev\PowerShell_BackUp\Test\"

New-Item .\d1 -type directory
New-Item .\d1\f1.txt -type File

New-Item .\d1\d11 -type directory 
New-Item .\d1\d11\f11.txt -type File

New-Item .\d1\d12 -type directory 
New-Item .\d1\d12\f12.txt -type File

New-Item .\d2 -type directory
New-Item .\d2\f2.txt -type File

New-Item .\d2\d21 -type directory
New-Item .\d2\d21\f21.txt -type File

New-Item .\d2\d22 -type directory 
New-Item .\d2\d22\f22.txt -type File

#reset:
#rm d1 -Recurse
#rm d2 -Recurse