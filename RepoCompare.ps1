
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
                write-host "Difference at index"$i
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

    #(Get-ItemProperty .\DFS.ps1).LastWriteTime

    [bool]$isSame = 1
    [bool]$isSameSize = 1
    [bool]$isSameLWT = 1
    $diff_counter = 0
    if($Tree1.Length -eq $Tree2.Length){
        #Compare Tree1 and Tree2
        For ($i = 0 ; $i –lt $Tree1.length ; $i ++){
            #Name comparison: if the names are the same, size and last write time can be compared
            if($Tree1[$i] -eq $Tree2[$i]){

                #Lengh (Size in Bytes)
                $Size1 = (Get-ItemProperty $Tree1[$i]).Length
                $Size1 = (Get-ItemProperty $Tree2[$i]).Length
                if($Size1 -ne $Size2){
                    write-host "File size is different at index"$i
                    write-host "Tree1 : "$Tree1[$i]" Size = "$LWT1 "Bytes"
                    write-host "Tree2 : "$Tree2[$i]" Size = "$LWT2 "Bytes"
                    $isSame = 0
                    $isSameSize = 0
                }
                #Last Write Time
                $LWT1 = (Get-ItemProperty $Tree1[$i]).LastWriteTime
                $LWT2 = (Get-ItemProperty $Tree2[$i]).LastWriteTime
                if($LWT1.ToString() -ne $LWT2.ToString()){
                    write-host "Last Write Time is different at index"$i
                    write-host "Tree1 : "$Tree1[$i]" Last Write Time = "$LWT1 
                    write-host "Tree2 : "$Tree2[$i]" Last Write Time = "$LWT2
                    $isSame = 0
                    $isSameLWT = 0
                }
                if(($isSameSize -eq 0) -or ($isSameLWT -eq 0)){
                    $isSameSize = 1
                    $isSameLWT = 1
                    $diff_counter++
                }
            }#If File Name
            else{ #File names are different
                write-host "Name difference at index"$i
                write-host "Tree1 has"$Tree1[$i] 
                write-host "Tree2 has"$Tree2[$i]
                $isSame = 0
                $diff_counter++
            }
        }#For Loop
    }#If Lengh 
    else{ 
        $isSame = 0
        write-host "Les deux arbres ne sont pas de meme longueur"
    }

    if($isSame -eq 1){
        write-host "Les deux arbres sont identiques"
    }
    else{
        Write-Host "Arbres non-identiques."
        Write-Host "Nombre de difference:"$diff_counter
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
                write-host "Difference at index"$i
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

