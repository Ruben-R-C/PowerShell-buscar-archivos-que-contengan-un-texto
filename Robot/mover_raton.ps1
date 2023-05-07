
# Funcion que mueve el raton derecho/izquierta 50px hasta que se pulsa el espacio
function main
{
	importarFuncionGetAsyncKeyState
	importar-System-Windows-Forms
	$contador = 0

	do
	{
        Start-Sleep -Milliseconds 20
				
        if (  ($contador -gt 0) -and ($contador -lt 80) )
		{
			mover-raton-abajo-derecha
		}
		
		if ( $contador -eq 80 )
		{
			Start-Sleep -Milliseconds 150
		}
		
		if (  ($contador -gt 80) -and ($contador -lt 160) )
		{
			mover-raton-arriba-izquierda
		}
		
		if (  $contador -eq 160 )
		{
			Start-Sleep -Milliseconds 150
			$contador = -1
		}
		
		$contador += 1
	} while(no-se-ha-pulsado-la-tecla-espacio)
	 
}


# Funcion que devuelve true, mientras no se pulse el espacio
function no-se-ha-pulsado-la-tecla-espacio
{
	return ![bool]([PsOneApi.Keyboard]::GetAsyncKeyState([ConsoleKey]::Spacebar) -eq -32767)
}


# Funcion para leer el teclado
function importar-System-Windows-Forms
{
	Add-Type -AssemblyName System.Windows.Forms 
}


# Funcionn que trae de .NET la funcion GetAsyncKeyState para leer el teclado
function importarFuncionGetAsyncKeyState
{
	$detectarTecla = @'
	[DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)] 
	public static extern short GetAsyncKeyState(int virtualKeyCode); 
'@
    
	Add-Type -MemberDefinition $detectarTecla -Name Keyboard -Namespace PsOneApi
}


function mover-raton-abajo-derecha
{
    
    $POSITION = [Windows.Forms.Cursor]::Position
    $POSITION.x += 1  #abajo
    $POSITION.y += 1  #derecha
    [Windows.Forms.Cursor]::Position = $POSITION
}

function mover-raton-arriba-izquierda
{
    
    $POSITION = [Windows.Forms.Cursor]::Position
    $POSITION.x -= 1  #arriba
    $POSITION.y -= 1  #izquierda
    [Windows.Forms.Cursor]::Position = $POSITION
}

main




