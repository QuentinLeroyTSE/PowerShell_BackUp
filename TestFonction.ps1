# Test functions
function add{
    param($a,$b)
    $c = $a + $b
    return $c
}

#call the function
#add -a 5 -b 6
# = 11


$tabulation = ""
$end = 0
For($i = 0 ; $i –lt 3 ; $i ++){
    $tabulation = $tabulation.Insert($end,"|   ")
    $end = $tabulation.Length
}

$tabulation