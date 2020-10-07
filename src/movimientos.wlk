import wollok.game.*
import players.*

object config {

	method configurarTeclas() {
		keyboard.left().onPressDo({ 
			if(player.enElFloor() && player.enElTablero()){
				player.move(player.position().left(1))	
			}else if(player.enElFloor() && player.position().x() == 22){
				player.move(player.position().left(1))	
			}
		})
		keyboard.right().onPressDo({ 
			if(player.enElFloor() && player.enElTablero()){
				player.move(player.position().right(1))	
			}else if(player.enElFloor() && player.position().x() == 0){
				player.move(player.position().right(1))	
			}
		})
		keyboard.up().onPressDo({ 
			if(player.enElevator() && elevator.enElTablero() && not feind.enElElevator()){
				elevator.move(elevator.position().up(1))
				player.move(player.position().up(1))	
			}else if(player.enElevator() && elevator.position().y() == 0  && not feind.enElElevator()){
				elevator.move(elevator.position().up(1))
				player.move(player.position().up(1))
			}
		})
		keyboard.down().onPressDo({ 
			if(player.enElevator()&& elevator.enElTablero() && not feind.enElElevator()){
				elevator.move(elevator.position().down(1))
				player.move(player.position().down(1))	
			}else if(player.enElevator() && elevator.position().y() == 16 && not feind.enElElevator()){
				elevator.move(elevator.position().down(1))
				player.move(player.position().down(1))
			}
		})
	}

	method configurarColisiones() {
		game.onCollideDo(player, {enemy => enemy.encuentro(player)})
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