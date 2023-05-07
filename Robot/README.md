# Mover raton

```
Add-Type -AssemblyName System.Windows.Forms
$POSITION = [Windows.Forms.Cursor]::Position
$POSITION.x += 1  //abajo
$POSITION.x += 1  //arriba 
$POSITION.y += 1  //derecha
$POSITION.y -= 1  //izquierda
[Windows.Forms.Cursor]::Position = $POSITION
```


# Hacer click
```
#importamos W.U32 para hacer click con el raton
Add-Type -MemberDefinition '[DllImport("user32.dll")] public static extern void mouse_event(int flags, int dx, int dy, int cButtons, int info);' -Name U32 -Namespace W;

[W.U32]::mouse_event(6,0,0,0,0); #pulsar boton izquierdo
[W.U32]::mouse_event(24,0,0,0,0);  #pulsar boton derecho
```