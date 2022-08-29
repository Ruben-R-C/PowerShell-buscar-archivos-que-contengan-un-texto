# PowerShell-buscar-archivos-que-contengan-un-texto

El archivo funcion-buscar-archivos-que-contengan-un-texto.ps1
contiene una funcion para buscar recursivamente en el 
directorio en el que estoy todos los archivos que contentan 
un texto o textos.

1. Abrimos el CMD y ejecutamos `Powershell` para abrirla

2. Ejecutamos el archivo para cargar la funcion
``
.\Funcion-buscar-archivos-que-contengan-un-texto.ps1
``

3. Usar la funcion

Por ejemplo, en un proyecto java quiero buscar
la variable URL_FILE y los archivos que importan 
el paquete "java.net.URL"
Ejecutamos:
```
Buscar-Texto -Texto "URL_FILE","java.net.URL"
```
Esto me muestra algo parecido a lo siguiente:
Donde se ve el archivo, la linea donde esta y el contenido de la linea
```
                                  ******* URL_NAS *******

ruta                                           LineNumber LineaSinEspacios
----                                           ---------- ----------------
\WebContent\WEB-INF\web.x                         126 <res-ref-name>APP_Web/URL_NAS</res-ref-name>
\WebContent\WEB-INF\web.xml                       130 <lookup-name>url/APP_Web/URL_NAS</lookup-name>





                             ******* java.net.URL *******

ruta                                                   LineNumber LineaSinEspacios
----                                                   ---------- ----------------
\src\org\casa\app\config\ChequeoValores.java              8 import java.net.URLConnection;
\src\org\casa\app\thread\Fichero.java                     9 import java.net.URL;
\src\org\casa\app\thread\ThreadProcesador.java            9 import java.net.URL;
```
