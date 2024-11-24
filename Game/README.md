# Geometry Dash Game

Este es un juego inspirado en Geometry Dash, desarrollado en Processing. El objetivo del juego es controlar un cubo que salta sobre obstáculos y recoge monedas para obtener puntos. El juego termina cuando el cubo colisiona con un obstáculo.

## Instrucciones

- **Controles del Juego**:
  - **Barra Espaciadora**: Hace que el cubo salte.
  - **Clic del Ratón**: Reinicia el juego si ha terminado.

## Estructura del Proyecto

El proyecto está compuesto por varios archivos `.pde`, cada uno de los cuales define una parte específica del juego:

### Archivos Principales

- **Main.pde**: Archivo principal que configura el entorno de Processing y maneja la lógica de inicio del juego y la pantalla de records.
- **GeometryDashGame.pde**: Define la lógica principal del juego, incluyendo la inicialización, actualización y dibujo del juego, así como la gestión de colisiones y puntuaciones.

### Clases del Juego

- **Player.pde**: Define la clase `Player`, que maneja el movimiento, el dibujo y las colisiones del jugador.
- **Platform.pde**: Define la clase `Platform`, que representa las plataformas sobre las que el jugador puede saltar.
- **Coin.pde**: Define la clase `Coin`, que representa las monedas que el jugador puede recoger para obtener puntos.
- **Obstacle.pde**: Define la clase base `Obstacle` y la interfaz `ObstacleInterface`, que representan los obstáculos en el juego.
- **RectangleObstacle.pde**: Define la clase `RectangleObstacle`, que extiende `Obstacle` y representa un obstáculo rectangular.
- **SpikeObstacle.pde**: Define la clase `SpikeObstacle`, que extiende `Obstacle` y representa un obstáculo en forma de pico.
- **TriangleObstacle.pde**: Define la clase `TriangleObstacle`, que extiende `Obstacle` y representa un obstáculo triangular.

## Cómo Jugar

**Controlar el Cubo**: Usa la barra espaciadora para hacer que el cubo salte sobre los obstáculos y recoja monedas.
**Reiniciar el Juego**: Si el juego termina, haz clic en cualquier parte de la pantalla para reiniciar el juego.
