import wollok.game.*
import playersC.*
import movimientosC.*

object izquierda{
	method mover(objeto){
		objeto.move(objeto.position().left(1))
	}
}

object derecha{
	method mover(objeto){
		objeto.move(objeto.position().right(1))
	}
}
