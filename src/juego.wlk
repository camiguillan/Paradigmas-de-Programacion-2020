import wollok.game.*
import players.*
import movimientos.*
import enemys.*
import pantallaInicio.*

object configurarJuego{
	game.addVisual(elevator)
    game.addVisual(caro)
    enemigos.aparecerEnemigos()
    game.showAttributes(caro)
    game.showAttributes(elevator)
    config.configurarTeclas()
    config.configurarColisiones()
}