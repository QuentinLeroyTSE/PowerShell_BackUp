
#Repository comparison

#Takes two repository path in input, tell if they contain the exact same content (subfolder tree and files, based on names)
#And further, based on names, last modification date and size.

Write-Host ""
Write-Host "            ##############################"
Write-host "            # Repository comparison tool #"
Write-Host "            ##############################"
Write-Host ""

#Test de comparaison de deux arborescences
$Choice = Read-Host -Prompt 'Comparer Dossiers uniquement "1", fichiers uniquement "2", dossiers et fichiers "3"'

#Folder only
if($Choice -eq "1"){
    $TreePath1 = Read-Host -Prompt 'Indiquer le chemin du dossier 1'
    $TreePath2 = Read-Host -Prompt 'Indiquer le chemin du dossier 2'

    #Récupération des éléments de l'arbre
    $Tree1 = Get-ChildItem -Path $TreePath1 -Name -Recurse -Directory
    $Tree2 = Get-ChildItem -Path $TreePath2 -Name -Recurse -Directory

    [bool]$isSame = 1
    if($Tree1.Length -eq $Tree2.Length){
        #Compare Tree1 and Tree2
        For ($i = 0 ; $i –lt $Tree1.length ; $i ++){
    
            if($Tree1[$i] -ne $Tree2[$i]){
                write-host "Error at index"$i
                write-host "Tree1 has"$Tree1[$i] 
                write-host "Tree2 has"$Tree2[$i]
                $isSame = 0
            }
        }
    }
    else{ 
        $isSame = 0
        write-host "Les deux arbres ne sont pas de meme longueur"
    }

    if($isSame -eq 1){
        write-host "Les deux arbres sont identiques"
    }
}
#Files only
elseif($Choice -eq "2"){
    $TreePath1 = Read-Host -Prompt 'Indiquer le chemin du dossier 1'
    $TreePath2 = Read-Host -Prompt 'Indiquer le chemin du dossier 2'

    #Récupération des éléments de l'arbre
    $Tree1 = Get-ChildItem -Path $TreePath1 -Name -Recurse -File
    $Tree2 = Get-ChildItem -Path $TreePath2 -Name -Recurse -File

    [bool]$isSame = 1
    if($Tree1.Length -eq $Tree2.Length){
        #Compare Tree1 and Tree2
        For ($i = 0 ; $i –lt $Tree1.length ; $i ++){
    
            if($Tree1[$i] -ne $Tree2[$i]){
                write-host "Error at index"$i
                write-host "Tree1 has"$Tree1[$i] 
                write-host "Tree2 has"$Tree2[$i]
                $isSame = 0
            }
        }
    }
    else{ 
        $isSame = 0
        write-host "Les deux arbres ne sont pas de meme longueur"
    }

    if($isSame -eq 1){
        write-host "Les deux arbres sont identiques"
    }
}
#Both folders and files
elseif($Choice -eq "3"){
    $TreePath1 = Read-Host -Prompt 'Indiquer le chemin du dossier 1'
    $TreePath2 = Read-Host -Prompt 'Indiquer le chemin du dossier 2'

    #Récupération des éléments de l'arbre
    $Tree1 = Get-ChildItem -Path $TreePath1 -Name -Recurse
    $Tree2 = Get-ChildItem -Path $TreePath2 -Name -Recurse

    [bool]$isSame = 1
    if($Tree1.Length -eq $Tree2.Length){
        #Compare Tree1 and Tree2
        For ($i = 0 ; $i –lt $Tree1.length ; $i ++){
    
            if($Tree1[$i] -ne $Tree2[$i]){
                write-host "Error at index"$i
                write-host "Tree1 has"$Tree1[$i] 
                write-host "Tree2 has"$Tree2[$i]
                $isSame = 0
            }
        }
    }
    else{ 
        $isSame = 0
        write-host "Les deux arbres ne sont pas de meme longueur"
    }

    if($isSame -eq 1){
        write-host "Les deux arbres sont identiques"
    }
}
else{
    write-host "Incorrect choice"
    $ChoiceCorrect = 0
}

