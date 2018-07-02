<#
Test de l'algorithme DFS: Depth First Search
Parcours d'arbre en profondeur préfixe

Graphe:
Noeud = Chemin vers un dossier
Relation = Accès d'une dossier à l'autre en un déplacement dans l'arborescence
Pour chaque noeud il faut avoir la liste des noeuds descendants.
Tant qu'il y a des noeuds descendants, on rappelle la fonction.
On appelle la fonction pour chacun des noeuds descendants présents.
#>

Write-Host "Affichage d'arborescence"
$Racine = Read-Host -Prompt 'Indiquer le chemin absolu du dossier'
#$Racine = "C:\Users\win\DataSafe\Programme\PowerShell\Script_Back_Up"
set-location $Racine
$Etage = 0

function GetLastFolder{
    # récupérer le dossier courant/en fin de chemin
    param($LocalPath)
    $LastSlash = ([string]$LocalPath).LastIndexOfAny("\")
    return $LocalPath.Substring($LastSlash + 1)
}

# Define exploration function
function DFS{
    param($CurrentFolder, $Etage)
    
    #Variable Etage compte la profondeur d'imbrication = profondeur de la branche
    $Etage += 1
    #Elaboration des branches verticales
    $tabulation = ""
    $end = 0
    For($i = 0 ; $i –lt $Etage ; $i ++){
        $tabulation = $tabulation.Insert($end,"|   ")
        $end = $tabulation.Length
    }
    #Elaboration des branches horizontales
    $underscore = ""
    $end = 0
    For($i = 0 ; $i –lt ($Etage-1) ; $i ++){
        $underscore = $underscore.Insert($end,"\___")
        $end = $underscore.Length
    }

    #L'affichage se fait ici
    $PathLastFolder = GetLastFolder -LocalPath $CurrentFolder #à modifier pour le décalge des sous-dossiers
    write-host $underscore$PathLastFolder
    Set-Location $CurrentFolder
    #Afficher les fichiers (tester si le dossier est vide)
    if((Get-ChildItem -file) -ne $null){
        $display = ([string](Get-ChildItem -name -file)).Split(" ")
        For ($j = 0 ; $j –lt $display.length ; $j ++){
            Write-host $tabulation $display[$j]
        }
    }
    write-host $tabulation
    #get every sub node in $SubNodeTab
    $SubNodeTab = (Get-ChildItem -Directory).FullName
    
    # Si il y n'y a plus de dossier enfant, on arrête
    if( $SubNodeTab -eq $null){
        #rien ?
    }
    else{
        foreach($folder in $SubNodeTab){
            DFS -CurrentFolder $folder -Etage $Etage
        }
    }
}

#Appel de la fonction
DFS -CurrentFolder $Racine -Etage 0

#Retour au dossier racine
set-location $Racine
<#
Questions/

Comment ajouter des éléments à un tableau array ?
$fruits = @($fruits, "cerise")

#>


