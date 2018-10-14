# Tree creationfor test purpose

set-location "C:\Users\Quentin\Dev\PowerShell_BackUp\Test\"

# According to the test plan describe in the file "test_strategy.txt"

###########################
# Part A: File comparison #
###########################

#config_A	Deux arborescences de dossiers parfaitement identiques
#config_Aa      -Meme nombre de fichier
New-Item .\test_config_Aa1 -type directory

#config_Ab		-Fichier manquant
New-Item .\test_config_Ab1 -type directory

#config_Ac		-Fichier supplementaire
New-Item .\test_config_Ac1 -type directory

## Arbre Temoins A
New-Item .\test_config_Aa1\A\d1 -type directory
New-Item .\test_config_Aa1\A\d1\d11 -type directory
New-Item .\test_config_Aa1\A\d1\d12 -type directory
New-Item .\test_config_Aa1\A\d2 -type directory
New-Item .\test_config_Aa1\A\d2\d21 -type directory
New-Item .\test_config_Aa1\A\d2\d22 -type directory

## Fichiers Temoins A
New-Item .\test_config_Aa1\A\d1\f1.txt -type File -Value "Fichier Temoins f1"
New-Item .\test_config_Aa1\A\d1\d11\f11.txt -type File -Value "Fichier Temoins f11"
New-Item .\test_config_Aa1\A\d1\d12\f12.txt -type File -Value "Fichier Temoins f12"
New-Item .\test_config_Aa1\A\d2\f2.txt -type File -Value "Fichier Temoins f2"
New-Item .\test_config_Aa1\A\d2\d21\f21.txt -type File -Value "Fichier Temoins f21"
New-Item .\test_config_Aa1\A\d2\d22\f22.txt -type File -Value "Fichier Temoins f22"

#Test 1: test_config_Aa1
Copy-Item "C:\Users\Quentin\Dev\PowerShell_BackUp\Test\test_config_Aa1\A" -Destination "C:\Users\Quentin\Dev\PowerShell_BackUp\Test\test_config_Aa1\B" -Recurse
Copy-Item "C:\Users\Quentin\Dev\PowerShell_BackUp\Test\test_config_Aa1" -Destination "C:\Users\Quentin\Dev\PowerShell_BackUp\Test\test_config_Ab1" -Recurse
Copy-Item "C:\Users\Quentin\Dev\PowerShell_BackUp\Test\test_config_Aa1" -Destination "C:\Users\Quentin\Dev\PowerShell_BackUp\Test\test_config_Ac1" -Recurse

#Loop
For ($i = 2 ; $i -le 8 ; $i ++){
    $s = $i.ToString()
    Copy-Item "C:\Users\Quentin\Dev\PowerShell_BackUp\Test\test_config_Aa1\" -Destination "C:\Users\Quentin\Dev\PowerShell_BackUp\Test\test_config_Aa$s\" -Recurse
    Copy-Item "C:\Users\Quentin\Dev\PowerShell_BackUp\Test\test_config_Aa1\" -Destination "C:\Users\Quentin\Dev\PowerShell_BackUp\Test\test_config_Ab$s\" -Recurse
    Copy-Item "C:\Users\Quentin\Dev\PowerShell_BackUp\Test\test_config_Aa1\" -Destination "C:\Users\Quentin\Dev\PowerShell_BackUp\Test\test_config_Ac$s\" -Recurse

}


#################################
# Part B: Repository comparison #
#################################


#config_B	Deux arborescences de dossiers différents:
#config_Ba		-même longueur:
New-Item .\test_config_Ba1 -type directory
New-Item .\test_config_Ba2 -type directory
New-Item .\test_config_Ba3 -type directory

# config_Bb		-longueur différentes:
New-Item .\test_config_Bb1 -type directory
New-Item .\test_config_Bb2 -type directory

#config_Bb3			-répertoire manquant, pour le reste:
New-Item .\test_config_Bb31 -type directory
New-Item .\test_config_Bb32 -type directory
New-Item .\test_config_Bb33 -type directory

#config_Bb4			-répertoire supplémentaire, pour le reste:
New-Item .\test_config_Bb41 -type directory
New-Item .\test_config_Bb42 -type directory
New-Item .\test_config_Bb43 -type directory

#reset:
#rm d1 -Recurse
#rm d2 -Recurse