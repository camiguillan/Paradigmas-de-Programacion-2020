import wollok.game.*
import players.*
import movimientos.*
import enemys.*

class Tirito{
    var property direccionPlayer
    var position
    method image() {
        return "cami-der.png"
    }
    method nuevaPosition() = game.onTick(100,"disparo tirito",{direccionPlayer.mover(self)  })
    method position()=position
    method move(nuevaPosicion){
    }
    method encuentro(player){
    }

    method recibeDisparo(param1){}
}

class TiroPLayer inherits Tirito{
	var encontro= false
	override method image() {
        return "flor.png"
    }
    override method move(nuevaPosicion){
		if(self.position().x()>20 || self.position().x()<=0 or  encontro){
    		if(tirosPlayer.listaDeDisparos()==1)
        		game.removeTickEvent("disparo tirito")
    		tirosPlayer.desaparecer(self)
    	    
    	}
    	else
        	position=nuevaPosicion
	}
	method encuentra(enemigo,tiro){
		encontro= true 
        enemigo.encuentra(enemigo,tiro)
    }
}

class TiroEnemigo inherits Tirito{
	override method image() {
        return "fran-der.png"
    }
	override method move(nuevaPosicion){
		
        	position=nuevaPosicion
	}
	method encuentra(enemigo,tiro){}
}

object tirosPlayer{
    var tirito
    const property tiros=[]
    method disparar(){
        tirito=new TiroPLayer(direccionPlayer=caro.direccion(), position=caro.position()) 
        	game.addVisual(tirito)
            tiros.add(tirito)
            if(tiros.size()==1)
            	 tirito.nuevaPosition()
            config.colisionDisparoPersonaje()
            // if(tiros.size()==1)
           // desaparecedorDeTirosPlayer.existencia()
    }
    method listaDeDisparos()=tiros
    method remove(tiro){tiros.remove(tiro)}
	method desaparecer(disparo){
    	game.removeVisual(disparo)
        tiros.remove(disparo)
    }
}

object tirosEnemigo{
	var tirito
    const property tirosEnemigo=[]
	method disparar(enemigo){
        tirito=new TiroEnemigo(direccionPlayer=enemigo.direccion(), position=enemigo.position()) 
        	game.addVisual(tirito)
            tirito.nuevaPosition()
            tirosEnemigo.add(tirito)
            config.colisionDisparoEnemigo(tirito)
            if(tirosEnemigo.size()==1)
            desaparecedorDeTirosEnemigos.existencia()
    }
    method listaDeDisparos()=tirosEnemigo
    method remove(tiro){tirosEnemigo.remove(tiro)}
    method desaparecer(disparo){
    	game.removeVisual(disparo)
        tirosEnemigo.remove(disparo)
    }
	
}

object desaparecedorDeTirosEnemigos{
	method existencia(){
		game.onTick(100,"ver posicion",{tirosEnemigo.tirosEnemigo().forEach({tiro => if(tiro.position().x()>20 || tiro.position().x()<=0){
    		tirosEnemigo.desaparecer(tiro)
    	}})})
		
	}
}

