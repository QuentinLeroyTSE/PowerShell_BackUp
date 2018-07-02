<# Outil d'unification d'arbre

Objectif: Unifier Arbre1 et Arbre2
    -Créer les dossiers manquants de chaque arbre par rapport à l'autre, au dernier noeud commun
    -Copier les fichiers manquants de chaque arbre par rapport à l'autre

#>

#############################################
#-----------------Functions-----------------#
#############################################

#Decomposition du chemin en un tableau de string de chaque dossier (sans les \)

#Test de l'existence du dossier, si false: creation du dossier, si true: cd dossier

#do it again

#############################################
#-----------------Main|Script---------------#
#############################################

Write-Host "Tree Merging Tool"

#Récupération des chemins des racines des arbres
$TreePath1 = Read-Host -Prompt 'Indiquer le chemin absolu du dossier 1'
$TreePath2 = Read-Host -Prompt 'Indiquer le chemin absolu du dossier 2'

#Test de la validité des chemins
if((Test-Path $TreePath1) -eq 0){
    write-host "Chemin dossier 1 incorrect"
}
elseif((Test-Path $TreePath2) -eq 0){
    write-host "Chemin dossier 2 incorrect"
}else{

    #Récupération des éléments de l'arbre
    $Tree1 = Get-ChildItem -Path $TreePath1 -name -Recurse -Directory
    $Tree2 = Get-ChildItem -Path $TreePath2 -name -Recurse -Directory

    #Copie des dossiers manquants de chaque arbre par rapport à l'autre

    #Arbre 1
    write-host "Mise à jour de l'Arbre 1"
    [bool]$modifFlag = 0
    For ($i = 0 ; $i –lt $Tree2.length ; $i ++){
        #Si l'arbre 1 ne contient pas l'élément i de l'arbre 2
        if($Tree1.Contains($Tree2[$i]) -ne 1){
            $TreeTab = $Tree2[$i].split("\")
            set-location $TreePath1
            foreach($t in $TreeTab){
                #test existence in tree 1
                if((Test-Path $t) -ne 1){
                    #si le dossier n'existe pas, on le créer
                    New-Item -Path .\ -Name $t -ItemType "directory"
                    write-host $Tree2[$i]" --> "$TreePath1"\"
                    $modifFlag = 1
                }
                set-location $t
            }
            #set-location ($TreePath1 + "\" + $Tree2[$i])
            #copier le dossier de l'arbre 2 dans l'arbre 1 (à la racine)
            #Copy-Item -Path ($TreePath2 + "\" + $Tree2[$i]) -Destination .\ 
        }
    }
    if($modifFlag -eq 0){ Write-Host "Arbre 1 déjà à jour sur l'Arbre 2"}

    #Arbre 2
    write-host "Mise à jour de l'Arbre 2"
    $modifFlag = 0
    For ($i = 0 ; $i –lt $Tree1.length ; $i ++){
        #Si l'arbre 2 ne contient pas l'élément i de l'arbre 1
        if($Tree2.Contains($Tree1[$i]) -ne 1){
            $TreeTab = $Tree1[$i].split("\")
            set-location $TreePath2
            foreach($t in $TreeTab){
                #test existence in tree 2
                if((Test-Path $t) -ne 1){
                    #si le dossier n'existe pas, on le créer
                    New-Item -Path .\ -Name $t -ItemType "directory"
                    write-host $Tree1[$i]" --> "$TreePath2"\"
                    $modifFlag = 1
                }
                set-location $t
            }
        }
    }
    if($modifFlag -eq 0){ Write-Host "Arbre 2 déjà à jour sur l'Arbre 1"}

    #Control des longueurs de chaque arbre (qui doivent être égales)
    $Tree1 = Get-ChildItem -Path $TreePath1 -name -Recurse -Directory
    $Tree2 = Get-ChildItem -Path $TreePath2 -name -Recurse -Directory
    if($Tree1.Length -eq $Tree2.Length){
        Write-Host "Les arbres comportent le même nombre de dossier"
    }
    else{
        Write-Host "Erreur: les deux arbres ne possèdent pas le même nombre de dossier"
    }

}


<# Issues:

-Que se passe-t-il si d2 contient des sous-dossiers ?
-Que se passe-t-il si, une fois d2 fusionné à d1, on change des sous-dossiers de d2 et que l'on relance le script ?

Les sous dossiers sont copiés à la racine au lieu de l'emplacement correspondant à l'arbre d'origine

Test générique:
- Deux arbres identiques de profondeur 3, avec 2 dossiers et 2 fichiers à chaque étage
- Deux arbres de même structure, avec des noms de dossier et fichier différents
- Deux arbres totalement différent, profondeur différentes, aucun nom en commun, pas même nombre de fichier
- Deux arbres identiques de profondeur 3, avec 2 dossiers et 2 fichiers à chaque étage, avec une sous-branche manquante dans l'un des arbres
- Deux arbres identiques de profondeur 3, avec 2 dossiers et 2 fichiers à chaque étage, avec une sous-branche supplémentaire dans l'un des arbres
- Deux arbres identiques de profondeur 3, avec 2 dossiers et 2 fichiers à chaque étage, avec une sous-branche différente dans l'un des arbres (nom dossier et fichier différent)
- Avec des dossiers vides
#>

#Decomposer chaque chemin
#tester l'existence du premier dossier
#le creer s'il n'existe pas
#aller dans ce dossier
#tester le deuxieme dossier du chemin
#etc