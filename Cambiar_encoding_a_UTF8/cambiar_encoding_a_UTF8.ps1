#Cambiar encoding

IMPORTANTE
Revisar las variables $rutaAbsoluta y $filtro 

Funciona bien con Powershell 5.1
Para saber la version de powershell, ejecuta "Get-Host | Select-Object Version"
Por defecto, los script estan deshabilitados en Windows
Para saber si estan deshabilitados, ejecutar"Get-ExecutionPolicy"
y nos dice "Restricted"
Para habilitar la ejecucion de los scripts, abrir la powershell como administrador
y ejecutar "Set-ExecutionPolicy Unrestricted"

#Poner ruta absoluta del directorio para buscar los archivos para cambiar a UTF8
$rutaAbsoluta = "C:\ruta\absoluta\de\la\carpeta"
#Ponemos el fitro de archivos que seleccionamos
#En caso de no querer ningun filtro poner "*"
$filtro = "*.java"

```
function ChangeEncodeToUTF8 {
  param (
        $MyPath
  )
  $MyRawString = Get-Content -Raw $MyPath
  $Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
  [System.IO.File]::WriteAllLines($MyPath, $MyRawString, $Utf8NoBomEncoding)
}

#Bucle sobre todos los archivos de la carpeta
#-Force -Recurse es para que sea recursivo y busque en los subdirectorios
#"$_" es una variable que recoge la salida de la tuberia del comando Get-ChildItem 
Get-ChildItem $rutaAbsoluta -Filter $filtro -Force -Recurse |
Foreach-Object {
    Write-Output "Archivo: $_"
    ChangeEncodeToUTF8 -MyPath $_.FullName
}
pause
```
