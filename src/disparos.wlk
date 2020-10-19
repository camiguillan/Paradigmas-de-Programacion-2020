import wollok.game.*
import players.*
import movimientos.*
import enemys.*

class Tirito{
    var direccionPlayer=caro.direccion()
    var position= caro.position()
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
        tiros.remove(tiro)
        game.removeTickEvent("disparo tirito")
    }
}

object tiros{
    var tirito
    var tiros=[]
    method disparar(){
        tirito=new Tirito() 
            game.addVisual(tirito)
            tirito.nuevaPosition()
            config.colisionDisparo()
            tiros.add(tirito)
    }
    method listaDeDisparos()=tiros
    method remove(tiro){tiros.remove(tiro)}

}