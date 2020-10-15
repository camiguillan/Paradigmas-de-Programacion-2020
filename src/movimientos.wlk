import wollok.game.*
import players.*

object config {
	
	method configurarTeclas() {
		keyboard.left().onPressDo({ 
			if(caro.enElFloor() && (caro.enElTablero() || caro.position().x() == 22)){
				caro.move(caro.position().left(1))	
				caro.nuevaOrientacion(izquierda)
			}
		})
		keyboard.right().onPressDo({ 
			if(caro.enElFloor() && (caro.enElTablero() || caro.position().x() == 0)){
				caro.move(caro.position().right(1))	
				caro.nuevaOrientacion(derecha)
			}
		})
		keyboard.up().onPressDo({ 
			if(caro.enElevator() && not enemigos.enemigo().enElElevator()&& (elevator.enElTablero() || elevator.position().y() == 0)){
				elevator.move(elevator.position().up(1))
				caro.move(caro.position().up(1))	
			}
		})
		keyboard.down().onPressDo({ 
			if(caro.enElevator() && not enemigos.enemigo().enElElevator() && (elevator.enElTablero() || elevator.position().y() == 16)){
				elevator.move(elevator.position().down(1))
				caro.move(caro.position().down(1))	
			}
		})
		keyboard.space().onPressDo({caro.disparar()})
	}

	method configurarColisiones() {
		game.onCollideDo(caro, {enemy => enemy.encuentro(caro)})
	}
	
	method colisionDisparo(){
		game.onCollideDo(caro.tirito(), {enemy => enemy.encuentroTiro(caro.tirito())})
	}
}

object activador{
	method perseguirAPlayer(){
		game.onTick(800, "mover aleatoriamente", {perseguirPlayer.nuevaPosicion()})
	}
}

object perseguirPlayer {
	var property position  		//puertas en x: 2-6-16-20 -> CONSTANTES
	
	method nuevaPosicion() {
		if(self.playerALaIzq()){
			self.movimientoDer()
		}else if(self.playerALaDer()){
			self.movimientoIzq()	
		}
	}
	method movimientoDer(){ //POLIMORFISMO
		if (caro.enElevator() && self.playerDistintoPiso() && enemigos.enemigo().position().x() == 9){
			self.irIzq()
		} else if (not self.playerDistintoPiso() || (self.playerDistintoPiso() && enemigos.enemigo().position().x()<8)){
			self.irDer()
		}
	}
	method movimientoIzq(){
		if (caro.enElevator() && self.playerDistintoPiso() && enemigos.enemigo().position().x() == 14){
			self.irDer()}
		 else if (not self.playerDistintoPiso() || (self.playerDistintoPiso() && enemigos.enemigo().position().x()>15)){
			self.irIzq()
		}
	}
	method playerALaIzq(){
		return (enemigos.enemigo().position().x() < caro.position().x())
	}
	method playerALaDer(){
		return (enemigos.enemigo().position().x()>caro.position().x())
	}
	method irIzq(){
			position = enemigos.enemigo().position().left(1)
	}
	method irDer(){
			position = enemigos.enemigo().position().right(1)
	}
	method playerDistintoPiso(){
		return (caro.position().y() != enemigos.enemigo().position().y())
	}
}