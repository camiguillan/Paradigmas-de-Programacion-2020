import wollok.game.*
import players.*

object config {

	method configurarTeclas() {
		keyboard.left().onPressDo({ 
			if(player.enElFloor() && (player.enElTablero() || player.position().x() == 22)){
				player.move(player.position().left(1))	
				player.nuevaOrientacion(izquierda)
			}
		})
		keyboard.right().onPressDo({ 
			if(player.enElFloor() && (player.enElTablero() || player.position().x() == 0)){
				player.move(player.position().right(1))	
				player.nuevaOrientacion(derecha)
			}
		})
		keyboard.up().onPressDo({ 
			if(player.enElevator() && not feind.enElElevator()&& (elevator.enElTablero() || elevator.position().y() == 0)){
				elevator.move(elevator.position().up(1))
				player.move(player.position().up(1))	
			}
		})
		keyboard.down().onPressDo({ 
			if(player.enElevator() && not feind.enElElevator() && (elevator.enElTablero() || elevator.position().y() == 16)){
				elevator.move(elevator.position().down(1))
				player.move(player.position().down(1))	
			}
		})
		keyboard.space().onPressDo({const tirito=new Tirito()   
			game.addVisual(tirito)
			tirito.nuevaPosition()
		})
	}

	method configurarColisiones() {
		game.onCollideDo(player, {enemy => enemy.encuentro(player)})
		//game.onCollideDo(tirito, {enemy => enemy.encuentro(player)})
	}
}

object activador{
	method iniciar() {
		self.perseguirAPlayer()
		game.start()
		}
	method perseguirAPlayer(){
		game.onTick(800, "mover aleatoriamente", { perseguirPlayer.nuevaPosicion()})
	}
}

object perseguirPlayer {

	var property position = game.at(2, 0) 		//puertas en x: 2-6-16-20 -> CONSTANTES

	method nuevaPosicion() {
		if(self.playerALaIzq()){
			self.movimientoDer()
		}else if(self.playerALaDer()){
			self.movimientoIzq()	
		}
	}
	method movimientoDer(){ //POLIMORFISMO
		if (player.enElevator() && self.playerDistintoPiso() && self.position().x() == 9){
			self.irIzq()
		} else if (not self.playerDistintoPiso() || (self.playerDistintoPiso() && self.position().x()<8)){
			self.irDer()
		}
	}
	method movimientoIzq(){
		if (player.enElevator() && self.playerDistintoPiso() && self.position().x() == 14){
			self.irDer()}
		 else if (not self.playerDistintoPiso() || (self.playerDistintoPiso() && self.position().x()>15)){
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
			position = self.position().left(1)
	}
	method irDer(){
			position = self.position().right(1)
	}
	method playerDistintoPiso(){
		return (player.position().y() != self.position().y())
	}
}