import wollok.game.*
import players.*
import enemys.*
import disparos.*
import pantallaInicio.*

object config {
    method configurarTeclas() { //RESPOSABILIDAD DE CONDICIONES DEL TECLADO
        keyboard.left().onPressDo({ 
           personajeSeleccionado.personaje().moveIzq()
        })
        keyboard.right().onPressDo({ 
            personajeSeleccionado.personaje().moveDer()
        })
        keyboard.up().onPressDo({ 
            if(personajeSeleccionado.personaje().enElevator() && not enemigos.listaEnemigos().any({enemy => enemy.enElElevator()})&& (elevator.enElTablero() || elevator.position().y() == 0)){
                elevator.move(elevator.position().up(1))
                personajeSeleccionado.personaje().move(personajeSeleccionado.personaje().position().up(1))
            }
        })
        keyboard.down().onPressDo({ 
            if(personajeSeleccionado.personaje().enElevator() && not enemigos.listaEnemigos().any({enemy => enemy.enElElevator()}) && (elevator.enElTablero() || elevator.position().y() == 16)){
                elevator.move(elevator.position().down(1))
                personajeSeleccionado.personaje().move(personajeSeleccionado.personaje().position().down(1))
            }
        })
        keyboard.space().onPressDo({ 
            tirosPlayer.disparar()
        })
    }

    method configurarColisiones() {
        game.onCollideDo(personajeSeleccionado.personaje(), {enemy => enemy.encuentro(personajeSeleccionado.personaje())})
        //game.onCollideDo(tirito, {enemy => enemy.encuentra(tirito)})
    }
    method colisionDisparoPersonaje(){
        enemigos.listaEnemigos().forEach({enemy => game.onCollideDo(enemy, {tiro => tiro.encuentra(enemy,tiro)})})
        //game.onCollideDo(tirito, {enemigo => tirito.encuentra(enemigo,tirito)})
    }
    method colisionDisparoEnemigo(tiro){
        game.onCollideDo(tiro,{jugador=>jugador.recibeDisparo(tiro)})
    }
}
object activador{
    method iniciar() {
        self.perseguirAPlayer()
        game.start()
        }
    method perseguirAPlayer(){
        game.onTick(800, "perseguir player", { perseguirPlayer.algo()}) //CAMBIAR NOMBRE DE "ALGO"
    }
    method disparosEnemigos(){
    	enemigos.listaEnemigosDisparo().forEach({enemy => enemy.disparar()})
    }
    method ontick(){
    	game.onTick(2000, "disparo enemigo", { self.disparosEnemigos()})
    }
}

object perseguirPlayer{
    method algo(){enemigos.listaEnemigos().forEach({enemy => self.nuevaPosicion(enemy)})}
                                //puertas en x: 2-6-16-20 -> CONSTANTES
    method nuevaPosicion(enemy) {
         if(self.playerDistintoPiso(enemy)){
            self.irAlLimite(enemy)
        }else if(self.playerALaIzq(enemy)){
            self.movimientoDer(enemy)
        }else if(self.playerALaDer(enemy)){
            self.movimientoIzq(enemy)
        }
    }
    method movimientoDer(enemy){ //POLIMORFISMO
        if (personajeSeleccionado.personaje().enElevator() && self.playerDistintoPiso(enemy) && enemy.position().x() == 9){
            self.irIzq(enemy)
        } else if (not self.playerDistintoPiso(enemy) || (self.playerDistintoPiso(enemy) && enemy.position().x()<8)){
            self.irDer(enemy)
        }
    }
    method movimientoIzq(enemy){
        if (personajeSeleccionado.personaje().enElevator() && self.playerDistintoPiso(enemy) && enemy.position().x() == 14){
            self.irDer(enemy)}
         else if (not self.playerDistintoPiso(enemy) || (self.playerDistintoPiso(enemy) && enemy.position().x()>15)){
            self.irIzq(enemy)
        }
    }
    method playerALaIzq(enemy){
        return (enemy.position().x()<personajeSeleccionado.personaje().position().x())
    }
    method playerALaDer(enemy){
        return (enemy.position().x()>personajeSeleccionado.personaje().position().x())
    }
    method irIzq(enemy){
            enemy.move(enemy.position().left(1))
    }
    method irDer(enemy){
            enemy.move(enemy.position().right(1))
    }
    method playerDistintoPiso(enemy){
        return (personajeSeleccionado.personaje().position().y() != enemy.position().y())
    }
    
    method irAlLimite(enemy){
        if (enemy.position().x()<8)
            self.irDer(enemy)
        else if (enemy.position().x()>15)
            self.irIzq(enemy)
    }
}
