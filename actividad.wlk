class BarcoPirata{
  var property mision
  const property capacidadMaxima
  const tripulacion = []
  method agregarATripulacion(unPirata){
    if(self.tripulanteEsUtil(unPirata) && self.hayLugarParaPiratas()){
      tripulacion.add(unPirata)
    }
  }
  method hayLugarParaPiratas(){
    return (capacidadMaxima - tripulacion.size()) > 0
  }
  method tripulanteEsUtil(unPirata) = mision.tripulanteEsUtil(unPirata)
  method cantidadTripulantes() = tripulacion.size()
  method hayTripulanteConItem(unItem){
    return tripulacion.any({pirata => pirata.tieneItem(unItem)})
  }
  method todosLosTripulantesTienenItem(unItem){
    return tripulacion.all({pirata => pirata.tieneItem(unItem)})
  }
  method cambiarDeMision(unaMision){
    mision = unaMision
    self.sacarTripulantesNoUtiles()
  }
  method sacarTripulantesNoUtiles(){
    const tripulantesNoUtiles = tripulacion.filter({pirata => !self.tripulanteEsUtil(pirata)})
    tripulacion.removeAll(tripulantesNoUtiles)
  }
}

class Mision{
  method puedeSerCompletada(unBarco){
    return (unBarco.cantidadTripulantes()/unBarco.capacidadMaxima()) >= 0.9
  }

  method tripulanteEsUtil(unTripulante)
}

class BusquedaDelTesoro inherits Mision{
  override method puedeSerCompletada(unBarco) = super(unBarco) && unBarco.hayTripulanteConItem("llaveDeCofre")
  
  override method tripulanteEsUtil(unTripulante){
    return (unTripulante.tieneItem("brujula") || unTripulante.tieneItem("mapa") || unTripulante.tieneItem("grog")) && unTripulante.monedas() <= 5
  }
}

class ConvertirseEnLeyenda inherits Mision{
  const itemObligatorio
  override method tripulanteEsUtil(unTripulante){
    return (unTripulante.cantidadDeItems() >= 10) && unTripulante.tieneItem(itemObligatorio)
  }
}

class Pirata{
  var property ebriedad = 0
  var monedas = 0
  const items = []
  method estaPasadoEnGrog() = ebriedad >= 90
  method monedas() = monedas
  method tieneItem(unItem){
    return items.contains(unItem)
  }
  method cantidadDeItems(){
    return items.size()
  }
  
}

class EspiaDeLaCorona inherits Pirata{
  override method estaPasadoEnGrog() = false
}