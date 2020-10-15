import wollok.game.*
import movimientos.*

class Player{
	var property position = game.at(11, 0)
	var direccion=izquierda
	var property vida=77
	var property tirito
	
	method move(nuevaPosicion){
		position = nuevaPosicion
	}
	method enElevator(){
		 return self.position().x().between(11,12)
	}
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
	method encuentroTiro(disp){}
	
	method disparar(){
			tirito = new Tirito(position = self.position())
			game.addVisual(tirito)
			//tirito.nuevaPosition()
			config.colisionDisparo()
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
	method encuentroTiro(tirito){}
}

class Feind{ //enemigo aber auf Deutch    
	var property vida = 50
	var position
	method position() {
		position = perseguirPlayer.position()
		return position	
	}
	
	method enElElevator(){
		return (self.position().x().between(10,13))
	}
	method encuentro(jugador){
		game.onTick(800, "perder vida", {jugador.perderVida(5)}) 
		game.say(jugador,"me esta matando el coloquio de discreta")
		self.evaluador()
	}
	
	method evaluador(){
		game.onTick(800,"misma pos", {if(self.position() != caro.position()) self.sacartick()})
	}
	
	method sacartick(){
		game.removeTickEvent("perder vida") 
		game.removeTickEvent("misma pos")
	}
	method encuentroTiro(tirito){
		if(vida == 0){
			game.say(self,"promocionaste")
			game.removeVisual(self)
		}else {
		vida = (self.vida()-5).max(0)
		game.removeVisual(tirito)
		}
	}
}

object enemigos{
	var property enemigo
	method aparecerEnemigos(){
		enemigo = new Feind(position = game.at(2, 0))
		game.addVisual(enemigo)
		activador.perseguirAPlayer()
	}
}

/*object nivel1 inherits Feind{
	
	var position = game.at(2, 0)
	
	override method position() = perseguirPlayer.position()
	
	method image() {
		return "pinieiro.png"
	}
}*/

class Tirito{
	var direccionPlayer=caro.direccion()
	
	var position
	
	method image() {
		return "cami-der.png"
	}
	method nuevaPosition() = game.onTick(100,"disparo tirito",{direccionPlayer.mover(self)  })
	method position()=position
	method move(nuevaPosicion){
		position=nuevaPosicion
	}
	method encuentro(player){}
	method encuentroTiro(tirito){}
}



