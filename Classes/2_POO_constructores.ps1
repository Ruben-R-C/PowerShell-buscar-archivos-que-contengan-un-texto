
#Definimos clase
class estudiante {
    [string]$FirstName #class properties
    [string]$LastName
    [string]GetName() {
        return "$($this.FirstName) $($this.LastName)" #Return es obligatorio porque la funcion devuelve [string]
    }
    [void]SetName([string]$Name) {  #No devuelve nada [void]
        $this.FirstName = ($Name -split ' ')[0]
        $this.LastName = ($Name -split ' ')[1]
    }
    [void]SetName([string]$FirstName,[string]$LastName) {
        $this.FirstName = $FirstName
        $this.LastName = $LastName
    }
}

#Ponemos propiedades
$student1 = [estudiante]::new() #accelerator [estudiante] that create a new instance
$student1.FirstName = 'Natalia'
$student1.LastName = 'Fernandez'

#Mostrar clase
$student1

#LLamamos a la funcion
$student2 = [estudiante]::new() 
$student2.SetName('Raul Rodriguez')
$student2

#FirstName LastName
#--------- --------
#Raul      Rodriguez    

# Vemos las propiedades y metodos de la clase
$student1 | Get-Member 

#   TypeName: estudiante
#
#Name        MemberType Definition                    
#----        ---------- ----------                    
#Equals      Method     bool Equals(System.Object obj)
#GetHashCode Method     int GetHashCode()   
#GetName     Method     string GetName()             
#GetType     Method     type GetType()                
#ToString    Method     string ToString()             
#FirstName   Property   string FirstName {get;set;}   
#LastName    Property   string LastName {get;set;}  


#Definimos clase
class profesor {
    [string]$Nombre

    profesor([string]$nombre) {  #constructor
         $this.Nombre = $nombre
    }


}


#LLamamos a la funcion
$profesor1 = [profesor]::new('Ramon') 
$profesor1


#Nombre
#------
#Ramon 

#Vemos el constructor por defecto
[estudiante]::New 

#OverloadDefinitions
#-------------------
#estudiante new()   

#Vemos el constructor que hemos sobrecargado
[profesor]::New

#OverloadDefinitions          
#-------------------          
#profesor new(string nombre)  