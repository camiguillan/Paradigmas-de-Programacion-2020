import wollok.game.*

object player{
	var property position = game.at(11, 0)
	var property vida = 77

	method image() {
		return "caro-der.png"
	}
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
}

object feind{ //enemigo aber auf Deutch    
	
	method position() = perseguirPlayer.position()
	
	method image() {
		return "pinieiro.png"
	}
	
	method enElElevator(){
		return (self.position().x().between(10,13))
	}
	method encuentro(jugador){
		game.onTick(800, "perder vida", {if (self.position()==player.position())  jugador.perderVida(5)})
		game.say(jugador,"me esta matando el coloquio de discreta")
		//game.removeTickEvent("perder vida")  DUDOSO	
	}
}

object perseguirPlayer {

	var property position = game.at(2, 0) 		//puertas en x: 2-6-16-20

	method nuevaPosicion() {
		if(self.playerALaIzq()){
			self.movimientoDer()
		}else if(self.playerALaDer()){
			self.movimientoIzq()	
		}
	}
	method movimientoDer(){
		if (player.enElevator() && self.position().y()!= player.position().y() && self.position().x()==9){
			self.irIzq()
		} else if  (not self.playerDistintoPiso()){
			self.irDer()
		} else if(self.playerDistintoPiso() && self.position().x()<8) {
			self.irDer()}
	}
	method movimientoIzq(){
		if (player.enElevator() && self.position().y()!= player.position().y() && self.position().x()==14){
			self.irDer()}
		 else if (not self.playerDistintoPiso()){
			self.irIzq()
		} else if(self.playerDistintoPiso() && self.position().x()>15) {
			self.irIzq()
		}
	}
	method playerALaIzq(){
		return (self.position().x()<player.position().x())
	}
	method playerALaDer(){
		return (self.position().x()>player.position().x())
	}
	method irIzq(){
			const x = self.position().x()-1
			position = game.at(x, 0)
	}
	method irDer(){
			const x = self.position().x()+1
			position = game.at(x, 0)
	}
	method playerDistintoPiso(){
		return (player.position().y() != self.position().y())
	}
}