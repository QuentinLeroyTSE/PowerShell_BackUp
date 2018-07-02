# Premier Objectif: Afficher l'arborescence descendante compl�te du dossier sp�cifi�, de mani�re jolie et comphr�hensible.
<#
C:\[...]\dossier_racine
|dossier_racine
|   fichier1
|   fichier2
|   ...
|   
\___sous-dossier1
|   |   f1
|   |   f2
|   |   ...
|   |
|   \___sous-sous-dossier1
|       |  ...
|       |
|       \___s-s-s-dossier1
|              ...
|
\___sous-dossier2
        f1
        f2
        ...
#>
Write-Output "Bienvenue dans le Script BackUp N�1"
Write-Output "Affichage de l'arborescence descendante du dossier sp�cifi�."
$Dossier1 = "C:\Users\win\DataSafe\Programme\PowerShell\Script_Back_Up" # just for developping
#$Dossier1 = Read-Host -Prompt 'Indiquer le chemin du dossier'
Write-Output "Le dossier spc�cifi� est '$Dossier1'"
Write-Output "Acc�s au dossier et affichage de l'arborescence descendante:"
# Se placer dans $Dossier1
set-location $Dossier1
# Afficher le contenu de l'arborescence descendante du $Dossier1
get-childitem -recurse -Name
Write-host "Affichage styl� :"
Write-host " "
Write-host $Dossier1
# R�cup�rer le nom du dossier courrant
$tabFP = ([string]$Dossier1).Split("\")
Write-Host "|"$tabFP[$tabFP.Length - 1]
# R�cup�rer l'arborescence dans une variable
[string]$folder = Get-ChildItem -Directory -Name -recurse
[string]$file = Get-ChildItem -File -Name
$tabFolder = $folder.Split(" ")
$tabFile = $file.Split(" ")

# Boucle qui parcourt les dossiers
For ($i = 0 ; $i �lt $tabFolder.length ; $i ++){
    set-location $tabFolder[$i]
    
    #affichage dossier courant
    $CheminDC_PathInfo = Get-Location
    $tabCheminDC_String = ([string]$CheminDC_PathInfo).Split("\")
    Write-Host "|"$tabCheminDC_String[$tabCheminDC_String.Length - 1]

    $display = ([string](Get-ChildItem -name -file)).Split(" ")
    For ($j = 0 ; $j �lt $display.length ; $j ++){
        Write-host "|   "$display[$j]
    }
    
    set-location $Dossier1
}

# File Loop
For ($i = 0 ; $i �lt $tabFile.length ; $i ++){
    Write-host "|   "$tabFile[$i]
}

# Folder Loop
For ($i = 0 ; $i �lt $tabFolder.length ; $i ++){
    Write-host "\___"$tabFolder[$i]
    Write-host "|"
}

<#
[string]$B = Get-Childitem -File -Name -recurse
$tabB = $B.Split(" ")
#>

<#Notes:
 set-location C:\Users\win\DataSafe\Programme\PowerShell\Script_Back_Up
    -recurse = dans toute l'arborescence descendante

 Supprimer une variable:
    remove-variable -Name var
 Attention si la varible contient un chemin, clear-variable first. 
 Sinon on supprime �galement le chemin (dossiers et fichiers)

 Cr�er un fichier:
    new-item "c:\temp\essai.txt" �type file

 Besoins:
 Faire la distinction entre fichier et dossier
    Get-ChildItem -File Get-ChildItem -Directory
 R�cup�rer toute l'arborescence dans un array simple de string
 
 Id�e pour la comparaison de deux arborescences: utiliser des couleurs diff�rentes pour mettre en �vidence les diff�rences

 Nouvelle strat�gie: arborescence = graphe; parcours en profondeur pr�fixe ou Depth First Search
#>