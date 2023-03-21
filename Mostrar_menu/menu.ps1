function mostrarMenu {
    Clear-Host
    Write-Host "============= Util Tool ============="
    Write-Host "1: eliminar"
    Write-Host "2: buscar"
    Write-Host "3: modificar"
    switch (Read-Host "--> ")
    {	'1' {eliminar} 
		'2' {buscar} 
		'3' {modificar} 
    }
}

function eliminar {
    Clear-Host
    Write-Host "ejecucion... funcion eliminar"
	exit
}

function buscar {
    Clear-Host
    Write-Host "ejecucion... funcion buscar"
	exit
}

function modificar {
    Clear-Host
    Write-Host "ejecucion... funcion modificar"
	exit
}

mostrarMenu
