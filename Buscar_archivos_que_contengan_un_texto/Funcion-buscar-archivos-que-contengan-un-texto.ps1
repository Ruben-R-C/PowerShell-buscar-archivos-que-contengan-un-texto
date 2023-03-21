#Funcion Segundaria para realzar la palabra buscada en amarillo
function Resaltar-Texto {
   param(
   [Parameter(Mandatory, ValueFromPipeline)]
   [string]$texto,
   [string]$resaltar)
   $lenTextoResalta = $resaltar.Length 
   
   $primerIndice = 0
   $ultimoIndice = $texto.Length  
   $indicesInicioResaltado = ($texto | Select-String $resaltar -AllMatches).Matches.Index
   $indicesFinalResaltado = $indicesInicioResaltado | ForEach-Object {$PSItem + $lenTextoResalta}

   #indices entre el texto resaltado y el normal
   $indicesTodo = @($ultimoIndice,$primerIndice) 
   $indicesTodo += $indicesInicioResaltado
   $indicesTodo += $indicesFinalResaltado
   $indicesTodo = $indicesTodo | Sort-Object

   #Write-Host "indicesTodo"
   #Write-Host $indicesTodo 
   for ( $index = 0; $index -lt ($indicesTodo.count - 1); $index++ )
   {
       $long = $indicesTodo[$index+1]-$indicesTodo[$index]
	   $imprimir = $texto.Substring($indicesTodo[$index],$long)
       #Write-Host $indicesTodo[$index] $long $texto.Substring($indicesTodo[$index],$long)
	   if($index%2 -eq 0) {
          Write-Host  $imprimir -NoNewline; 
       } 
	   else {
          Write-Host -ForegroundColor yellow $imprimir -NoNewline;
	   }
   }
   Write-Host  ''; 
}

#Funcion Segundaria para buscar archivos evitando nombres en la ruta o en el archivo predeterminado.
function Buscar-Archivos {
    param([string[]]$evitarDirectorio,[string[]]$evitarArchivo)
  
	$evitarDirs = @('*.gradle*','*\classes\*','*\.metadata\*','*\.git\*')
	$evitarDirs += $evitarDirectorio
    $evitarFiles = @('*.class','*.bin','*.ear','*.war','*.exe')
	$evitarFiles += $evitarArchivo
	   
	$dir = Get-ChildItem -Recurse
	Foreach($evitar in $evitarDirs) {
		 $dir = $dir | ? {$_.FullName -notlike $evitar} 
	}
	Foreach($evitar in $evitarFiles) {
		$dir = $dir | ? {$_.Name -notlike $evitar} 
	}
	return $dir
}
#Test
#$algo = Buscar-Archivos -evitarDirectorio "*WebContent*"
#Write-output $algo

#Funcion Segundaria para formatear la salido de las lineas de los archivos a mostrar
function Mostrar-Lineas {
    param([Object[]]$lineas,[String]$textoBuscado)
    Foreach($linea in $lineas) {
	     #Acortar la ruta del archivo, mostrar la ruta relativa de la posicion donde estamos, y no la ruta absoluta
		  $miPathLongitud = (Get-Location  | Select-Object -ExpandProperty 'Path').Length
		  $rutarelativa = $linea.Path.substring($miPathLongitud ,  $linea.Path.Length-$miPathLongitud)
     	 Add-Member -InputObject $linea  -NotePropertyName "ruta" -NotePropertyValue $rutarelativa -erroraction 'silentlycontinue'
		 #En el texto que buscamos se usan las tabulaciones, pero al mostrarlo en la consola se descoloca todo, cambiamos las tabulaciones por espacios
		 $lineasSinTabulaciones = $linea.Line.trim().Replace("`t", " ")
		 
		 Add-Member -InputObject $linea  -NotePropertyName "LineaSinEspacios" -NotePropertyValue $lineasSinTabulaciones
    }
	 # Mostramos estas tres columnas y con wrap hacemos que el contenido no salte a otras columnas cuando no entra en el ancho.
	 
	 Write-Host ""
	 Write-Host "" 
	 Write-Host ""
	 Write-Host "                                              ******* $textoBuscado *******"  -ForegroundColor Cyan
	 Write-output $lineas | Select ruta,LineNumber,LineaSinEspacios | Format-Table -Wrap | out-string | resaltar-texto -resalta $textoBuscado
	 #resaltar-texto Write-host $mostrar -resalta "we" 
}

#Funcion Principal para buscar todos los archivos que contengan un texto
function Buscar-Texto {
   param([string[]]$texto)
   Foreach($buscar in $texto) {
	   $dir = Buscar-Archivos
	   $lineas = $dir | Select-String $buscar 
	   Mostrar-Lineas -Lineas $lineas -TextoBuscado $buscar
   }
}

#Buscar-Texto -Texto "CONSULTA","import","javax"