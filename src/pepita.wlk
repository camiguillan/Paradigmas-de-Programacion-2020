import wollok.game.*

object player{
	var position
	method position() {
		return game.center()
	}

	method image() {
		return "juego-pixilart.png"
	}
	
	method turn(nuevaPosicion){
		position = nuevaPosicion
	}
}

object elevator{
	var property position = game.at(2.99, 0)
	
	method image(){
		return "ascensor (1).png"
	}
	
	method move(nuevaPosicion) {
			position = nuevaPosicion
	}
}