import wollok.game.*
import movimientos.*
import players.*
import disparos.*

class Feind{ //enemigo aber auf Deutch
    //var property movimiento
    var property position
    
    method cant()=0
    
    method move(nuevaPosicion){
        position = nuevaPosicion
    }

    method enElElevator(){
        return (self.position().x().between(10,13))
    }
    method encuentro(jugador){
        game.onTick(800, "perder vida", {jugador.perderVida(self.cant())}) 
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
    
    method impactos()
    
    method encuentra(enemigo,tiro){
        if(enemigo.impactos() == 0){
        	game.removeVisual(enemigo)
        	if(enemigos.listaEnemigos().size()==1)
            	game.removeTickEvent("perseguir player")
        	enemigos.listaEnemigos().remove(enemigo)	
        }else{
        	enemigo.restarImp()
        }
    }
}

class FeindSimple inherits Feind{
	var property impactos = 0
	method restarImp(){
		impactos-=1
	}
	
	method image() {
        return "pinieiro.png"
    }
    override method cant() = 5
}

class FeindDispara inherits Feind{
	
	var property impactos = 1
	method image() {
        return "vanos.png"
    }
    override method cant() = 10
    
    method restarImp(){
		impactos-=1
	}
}

object enemigos{
    var enemigo
    const property listaEnemigos=[]
    //const pos = [2,6,16,20]
    
    method aparecerEnemigos(){
        game.onTick(8000,"nuevo enemigo simple",{
            enemigo=new FeindSimple(position= game.at(2, 0))
            crearEnemigos.nuevoEnemigo(enemigo)
        })
         game.onTick(5000,"nuevo enemigo dispara",{
            enemigo=new FeindDispara(position= game.at(2, 4))
            crearEnemigos.nuevoEnemigo(enemigo)
        })
    }
    method enemigo()= enemigo
}

object crearEnemigos{
	method nuevoEnemigo(enemigo){
		game.addVisual(enemigo)
		enemigos.listaEnemigos().add(enemigo)
		if(enemigos.listaEnemigos().size() == 1){
			activador.perseguirAPlayer()
		}
	}
}