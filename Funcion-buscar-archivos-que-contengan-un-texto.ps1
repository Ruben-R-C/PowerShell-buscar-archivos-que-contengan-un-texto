#Funcion Segundaria para buscar archivos evitando ciertas carpetas y nombres de archivo
function Buscar-Archivos {
    param([string[]]$evitarDirectorio,[string[]]$evitarArchivo)
  
	$evitarDirs = @('*.gradle*','*\classes\*','*\.metadata\*','*\.git\*')
	$evitarDirs += $evitarDirectorio
    $evitarFiles = @('*.class','*.bin')
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
    param([Object[]]$lineas,[String[]]$textoBuscado)
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
	 
	 Write-output ""
	 Write-output "                                              ******* $textoBuscado *******"
	 Write-output $lineas | Select ruta,LineNumber,LineaSinEspacios | Format-Table -Wrap
	
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

#Ejemplo que buscar textos en todos los archivos de esta carpeta recursivamente
#Buscar-Texto -Texto "URL_NAS","java.net.URL"