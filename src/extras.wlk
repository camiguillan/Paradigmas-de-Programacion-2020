import wollok.game.*
import players.*
import movimientos.*

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
