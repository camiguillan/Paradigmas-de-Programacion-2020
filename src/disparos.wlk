import wollok.game.*
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
        position=nuevaPosicion
    }
    method encuentro(player){
    }
    method encuentra(enemigo,tiro){
        game.removeVisual(tiro)
        tirosPlayer.remove(tiro)
        if(tirosPlayer.listaDeDisparos()==0)
        	game.removeTickEvent("disparo tirito")
        enemigo.encuentra(enemigo,tiro)
    }
    method recibeDisparo(param1){}
}

class TiroPLayer inherits Tirito{
	override method image() {
        return "cami-der.png"
    }
	
}

class TiroEnemigo inherits Tirito{
	override method image() {
        return "fran-der.png"
    }
	
}

object tirosPlayer{
    var tirito
    const property tiros=[]
    method disparar(){
        tirito=new TiroPLayer(direccionPlayer=caro.direccion(), position=caro.position()) 
        	game.addVisual(tirito)
            tirito.nuevaPosition()
            tiros.add(tirito)
            config.colisionDisparoPersonaje(tirito)
    }
    method listaDeDisparos()=tiros
    method remove(tiro){tiros.remove(tiro)}

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
    }
    method listaDeDisparos()=tirosEnemigo
    method remove(tiro){tirosEnemigo.remove(tiro)}
    method desaparecer(disparo){
    	game.removeVisual(disparo)
        tirosEnemigo.remove(disparo)
    }
	
}
