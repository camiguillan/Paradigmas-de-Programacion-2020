import wollok.game.*
import players.*
import movimientos.*
import disparos.*
import pantallaInicio.*

class Feind{ //enemigo aber auf Deutsch
    var property position
    var direccion = izquierda
    var impactos
    
    method direccion() = direccion
    
    method nuevaDireccion(nuevaD){
        direccion=nuevaD
    }
       
    method ataque()=0
    
    method move(nuevaPosicion){
        position = nuevaPosicion
    }
	
	
	//RESPONSABILIDAD DEL ELEVATOR
    method enElElevator(){
        return (self.position().x().between(10,13))
    }
    method encuentro(jugador){
        game.onTick(800, "perder vida", {jugador.perderVida(self.ataque())}) 
        self.evaluador()
    }

    method evaluador(){
        game.onTick(800,"misma pos", {if(self.position() != personajeSeleccionado.personaje().position()) self.sacartick()})
    }

    method sacartick(){
        game.removeTickEvent("perder vida") 
        game.removeTickEvent("misma pos")
    }

    method impactos() = impactos

    method encuentra(enemigo,tiro){
        if(enemigo.impactos() == 0){
            	game.removeVisual(enemigo)

                if(enemigos.listaEnemigos().size()==1)
                    game.removeTickEvent("perseguir player")
                enemigos.listaEnemigos().remove(enemigo)
       			enemigo.lista().remove(enemigo)
                if(enemigos.listaEnemigosDisparo().contains(enemigo)){
                  		if(enemigos.listaEnemigosDisparo().size()==1)
                    		game.removeTickEvent("disparo enemigo")
                  	 	enemigos.listaEnemigosDisparo().remove(enemigo)
                }

        }else{
            enemigo.restarImp()
        }
    }
    method recibeDisparo(disparo){
    }

    method restarImp(){
        impactos-=1
    }
    
    method disparar(){
        if(self.position().y() == personajeSeleccionado.personaje().position().y()){
        	tirosEnemigo.disparar(self)
        }
    }
    
    method lista()
}

class FeindSimple inherits Feind{
	override method lista() = enemigos.eSimple()

    method image() {
        return "pinieiro.png"
    }
    override method ataque() = 5
    override method disparar(){}
}

class FeindDispara inherits Feind{
	override method lista() = enemigos.eDisparaSimple()

    method image() {
        return "vanos.png"
    }
    override method ataque() = 10

    /*override method disparar(){
        if(self.position().y() == personajeSeleccionado.personaje().position().y()){
        	tirosEnemigo.disparar(self)
        }
    }*/
}

class FeindPapota inherits FeindDispara{	
	override method lista() = enemigos.eDisparaPapota()
	
    override method image() {
        return "enemyyy.png"
    }
    override method ataque() = 15

   /*  override method disparar(){
        if(self.position().y() == personajeSeleccionado.personaje().position().y()){
        	tirosEnemigo.disparar(self)
        }
    }*/
}

///////////////////////////////////////////////////////////////////

object enemigos{
    const property listaEnemigos=[]
    const property listaEnemigosDisparo=[]
    const property eSimple = []
    const property eDisparaSimple = []
    const property eDisparaPapota = []
    const puertas = [2,6,16,20]
    var pos
	
	method cantEnemigos() = listaEnemigos.size()
	method cantDeUnTipo(listaTipo) = listaTipo.size()
	
    method aparecerEnemigos(){
        game.onTick(8000,"nuevo enemigo que dispara",{
        	if(self.cantDeUnTipo(eDisparaSimple) <= 4){
        		var enemigo=new FeindDispara(impactos = 1,position= game.at(self.generarPuerta(), 4), direccion = derecha)
            	self.nuevoEnemigo(enemigo,eDisparaSimple)                 												
            	self.nuevoEnemigoDispara(enemigo)                                	
            	//self.activarPersecusion()	
        	}
        }) 
        
        game.onTick(5000,"nuevo enemigo simple",{
        	if(self.cantDeUnTipo(eSimple) <= 4){
        		var enemigo=new FeindSimple(impactos = 0,position= game.at(self.generarPuerta(), 0))
            	self.nuevoEnemigo(enemigo,eSimple)
            	//self.activarPersecusion()	
        	}
        })
        
        game.onTick(10000,"nuevo enemigo papota",{
        	if(self.cantDeUnTipo(eDisparaPapota) <= 2){
        		var enemigo = new FeindPapota(impactos = 5, position = game.at(self.generarPuerta(),8))
        		self.nuevoEnemigo(enemigo,eDisparaPapota)
        		self.nuevoEnemigoDispara(enemigo) 
        		//listaEnemigosDisparo.add(enemigo)                                                	
	            //self.activarDisparo()
            	//self.activarPersecusion()
        	}
        })
    }
   // method enemigo()= enemigo
    
    method generarPuerta(){
    	pos = 0.randomUpTo(4)
        return puertas.get(pos)
    }
    
    method nuevoEnemigo(enemigo,listaTipo){
        game.addVisual(enemigo)
        listaEnemigos.add(enemigo)
        listaTipo.add(enemigo)
        self.activarPersecusion()
    }
    
    method nuevoEnemigoDispara(enemigo){
        listaEnemigosDisparo.add(enemigo)    
        self.activarDisparo()
    }
    
    method activarPersecusion(){
    	if (listaEnemigos.size()==1)		
            activador.perseguirAPlayer()
    }
    
    method activarDisparo(){
    	if (listaEnemigosDisparo.size() == 1)
                activador.ontick() 
    }
}

