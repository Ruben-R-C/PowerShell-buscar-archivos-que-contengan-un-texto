# Mover raton

```
$MOVEMENTSIZE = 50
Add-Type -AssemblyName System.Windows.Forms
$POSITION = [Windows.Forms.Cursor]::Position
$POSITION.x += $MOVEMENTSIZE  //abajo
$POSITION.x += $MOVEMENTSIZE  //arriba 
$POSITION.y += $MOVEMENTSIZE  //derecha
$POSITION.y -= $MOVEMENTSIZE  //izquierda
[Windows.Forms.Cursor]::Position = $POSITION
```