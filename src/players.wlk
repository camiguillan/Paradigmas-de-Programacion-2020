import wollok.game.*

object player{
	var property position = game.at(0, 0)

	method image() {
		return "caro-der.png"
	}
	method move(nuevaPosicion){
		position = nuevaPosicion
	}
	method enElevator(){
		 return self.mismoX() && self.mismoY()  
	}
	method mismoX(){
		return self.position().x().between(11,12)
	}
	method mismoY(){
		return (position.y()==elevator.position().y())
	}
	method enElFloor(){
		return (position.y()%4 == 0)
	}
	method enElTablero(){
		return (self.position().x().between(1,21))
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
}

object feind{ //enemigo aber auf Deutch    
	
	method position() = perseguirPlayer.position()
	
}

object perseguirPlayer {

	var property position = game.at(2, 0) 		//puertas en x: 2-6-16-20

	method nuevaPosicion() {
		// calculo coordenadas aleatorias dentro la pantalla
		if (self.position().x()>player.position().x()){
			const x = self.position().x()-1
			position = game.at(x, 0)
		} 
		else if (self.position().x()<player.position().x()){
			const x = self.position().x()+1
			position = game.at(x, 0)
		}
	}
}

