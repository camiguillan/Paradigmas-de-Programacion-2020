import wollok.game.*

object player{
	var property position = game.at(0, 0)

	method image() {
		return "cami-der.png"
	}
	
	method turn(nuevaPosicion){
		position = nuevaPosicion
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
}