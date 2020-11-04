import wollok.game.*
import movimientos.*
import enemys.*
import disparos.*
import pantallaInicio.*
import disparos.*
import mascotas.*

class Player{
    var property position = game.at(11, 0)
    var direccion=izquierda
    var property vida = 101
    var vivo = true
    var property estado = simpleMortal
    var muertesTot = 0    
    
    method direccion()=direccion
        
    method vidaCompleta(){
    	vida = 101
    }
    
    method cambiarEstado(nuevoE){
    	estado = nuevoE
    }
    
    method vivo() = vivo
    
    method move(nuevaPosicion){
        position = nuevaPosicion
    }
    
    method moveIzq(){ 
    	if(self.enElFloor() && (self.enElTablero()  || self.position().x() == 22)){
                self.move(self.position().left(1))
                self.nuevaOrientacion(izquierda)
            }
    }
    
    method moveDer(){
    	if(self.enElFloor() && (self.enElTablero() || self.position().x() == 0)){
                self.move(self.position().right(1))
                self.nuevaOrientacion(derecha)
            }
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
        self.sterben()
    }
    
    method encuentroEnemigo(cantidad){
    	estado.encuentroEnemigo(cantidad,self)
    }
    
    method recibeDisparo(disparo){
    	 estado.recibeDisparo(disparo,self)
    }

    method nuevaOrientacion(nuevaOrientacion){
        direccion=nuevaOrientacion
    }
    
    method encuentra(enemigo,tiro){}
    
    method sterben(){
    	if(vida == 0){
    		vivo = false
    		game.say(self,"F")
    		game.schedule(9000, {game.stop()})
    	}else{
    		game.say(self,"me esta matando el coloquio de discreta")
    	}
    }
    
    method matoAUno(){
    	muertesTot+=1
    	if(muertesTot == 20)
    		self.sieg()
    }
    
    method sieg(){
    	game.say(self, "GANE PERRI")
    	game.schedule(5000, game.addVisual(""))
    	game.schedule(20000, {game.stop()})
    }
}

object caro inherits Player{
	method mascota() = mora

	method disparo() = "flor.png"
	
    method image() {
        if(vivo){
        	return "caro-der.png"	
        }else{
        	return "caroBYN.png"
        }
    }
}

object cami inherits Player{
	method disparo() = "flor.png"
	method mascota() = unicornio
	
    method image() {
        if(vivo){
        	return "cami-der.png"	
        }else{
        	return "camiBYN.png"
        }
    }
}

object fran inherits Player{
	method disparo() = "fuego.png"
	method mascota() = junior
	
    method image() {
        if(vivo){
        	return "fran-der.png"	
        }else{
        	return "franBYN.png"
        }
    }
}

///////////////////////////////////////////////////////////////////

object izquierda{
    method mover(objeto){
    	if(objeto.position().x()>0 && objeto.position().x()< game.width()){ 
        	objeto.move(objeto.position().left(1))
        }else{
        	objeto.remove()
        }
    }
}

object derecha{
    method mover(objeto){
        if(objeto.position().x()>0 && objeto.position().x()<game.width()){
        	objeto.move(objeto.position().right(1))
        }else{
        	objeto.remove()
        }
    }
}

///////////////////////////////////////////////////////////////////

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
    method encuentra(enemigo,tiro){}
    method recibeDisparo(disparo){
    }
    
    method paArriba(){
    	if(personajeSeleccionado.personaje().enElevator() && not enemigos.listaEnemigos().any({enemy => enemy.enElElevator()})&& (self.enElTablero() || self.position().y() == 0)){
                self.move(self.position().up(1))
                personajeSeleccionado.personaje().move(personajeSeleccionado.personaje().position().up(1))
            }
    }
    
    method paAbajo(){
    	if(personajeSeleccionado.personaje().enElevator() && not enemigos.listaEnemigos().any({enemy => enemy.enElElevator()}) && (self.enElTablero() || self.position().y() == 16)){
                self.move(self.position().down(1))
                personajeSeleccionado.personaje().move(personajeSeleccionado.personaje().position().down(1))
            }
    }
}

///////////////////////////////////////////////////////////////////////////////////

class Estado{
	method recibeDisparo(disparo,personaje){
		tirosEnemigo.desaparecer(disparo)
	}
	method encuentroEnemigo(cantidad, personaje){}
}

object simpleMortal inherits Estado{
	override method recibeDisparo(disparo,personaje){
		super(disparo,personaje)
		personaje.perderVida(10)
	}
	
	override method encuentroEnemigo(cantidad, personaje){
		personaje.perderVida(cantidad)
	}
}

object semiDios inherits Estado{
	
}