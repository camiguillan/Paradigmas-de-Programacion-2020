import wollok.game.*
import players.*
import movimientos.*
import enemys.*

object configurarJuego{
	method empezar(seleccionado){
		game.addVisual(elevator)
    	game.addVisual(seleccionado)
    	enemigos.aparecerEnemigos()
    	game.showAttributes(seleccionado)
    	game.showAttributes(elevator)
    	config.configurarColisiones()	
	}
}

object teclas{
	var teclas = seleccionador
	
	method cambiarTeclas(){
		teclas = config
	}
	
	method activarTeclas(){
		teclas.configurarTeclas()
	}
}

object inicio{
	method position() = game.at(0,0)
	method image(){
		return "pasillos (3).png"
	}
}

object seleccionador{
	
	method configurarTeclas(){
	keyboard.left().onPressDo({ 
           nombreADefinir.cambiarPesonajeAColor(nombreADefinir.personajeAColor().aLaIzq())
        })
    keyboard.right().onPressDo({ 
           nombreADefinir.cambiarPesonajeAColor(nombreADefinir.personajeAColor().aLaDer())
        })
    keyboard.enter().onPressDo({
	    	game.removeVisual(inicio)
	    	teclas.cambiarTeclas()
	    	configurarJuego.empezar(nombreADefinir.personajeAColor().seleccionado())
	    	game.removeVisual(caroAElegir)
	    	game.removeVisual(camiAElegir)
	    	game.removeVisual(franAElegir)
    	})
    }
}

object nombreADefinir{
	var personajeAColor =caroAElegir
	method personajeAColor() = personajeAColor
	
	method cambiarPesonajeAColor(nuevoP){
		personajeAColor = nuevoP
	}

}

object camiAElegir{
	method position() = game.at(8,9)
	method aLaIzq() = franAElegir
	method aLaDer() = caroAElegir
	method seleccionado() = cami
	
	method image(){
		if(nombreADefinir.personajeAColor() == self){
			return "cami-der.png"
		}else{
			return "camienBYN"
		}
	}
}

object caroAElegir{
	method position() = game.at(12,9)
	method aLaIzq() = camiAElegir
	method aLaDer() = franAElegir
	method seleccionado() = caro
	method image(){
		if(nombreADefinir.personajeAColor() == self){
			return "caro-der.png"
		}else{
			return "camienBYN"
		}
	}
}

object franAElegir{
	method position() = game.at(16,9)
	method aLaIzq() = caroAElegir
	method aLaDer() = camiAElegir
	method seleccionado() = fran
	method image(){
		if(nombreADefinir.personajeAColor() == self){
			return "fran-der.png"
		}else{
			return "camienBYN"
		}
	}
}

object personajeSeleccionado{
	method personaje() = nombreADefinir.personajeAColor().seleccionado()
}