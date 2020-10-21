import wollok.game.*
import wollok.game.*
import movimientos.*
import enemys.*
import disparos.*

class Player{
    var property position = game.at(11, 0)
    var direccion=izquierda
    var property vida=77
    method move(nuevaPosicion){
        position = nuevaPosicion
    }
    method enElevator(){
         return self.position().x().between(11,12)
    }
    /*
    method mismoY(){
        return (position.y()==elevator.position().y())
    }
    */
    method enElFloor(){
        return (position.y()%4 == 0)
    }
    method enElTablero(){
        return (self.position().x().between(1,21))
    }
    method perderVida(cantidad){
        vida = (vida-cantidad).max(0)
    }
    method direccion()=direccion

    method nuevaOrientacion(nuevaOrientacion){
        direccion=nuevaOrientacion
    }
    method encuentra(enemigo,tiro){    }
    method recibeDisparo(disparo){
    	 vida = (vida-10).max(0)
    	 tirosEnemigo.desaparecer(disparo)
    }
}

object caro inherits Player{

    method image() {
        return "caro-der.png"
    }

}

object izquierda{
    method mover(objeto){
        objeto.move(objeto.position().left(1))
    }

}

object derecha{
    method mover(objeto){
        objeto.move(objeto.position().right(1))
    }

}

object elevator{
    var property position = game.at(3, 0)

    method image(){
        return "ascensor (1).png"
    }
    method move(nuevaPosicion) {
            position = nuevaPosicion
    }
    method enElTablero(){
        return(self.position().y().between(1,15))
    }
    method encuentro(player){}
    method encuentra(enemigo,tiro){    }
    method recibeDisparo(disparo){
    }

}
