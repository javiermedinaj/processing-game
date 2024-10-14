PImage backgroundImage;

float playerX, playerY;
float playerSize = 50;
float playerSpeedY = 0;
float gravity = 0.6;
boolean isJumping = false;

ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
int score = 0;
boolean gameOverFlag = false; // Bandera para el estado de Game Over

void setup() {
  size(800, 600);
  backgroundImage = loadImage("background1.jpg");
  backgroundImage.resize(width, height);// Asegúrate de tener una imagen llamada "background.png" en la carpeta del proyecto
  initializeGame();
}

void initializeGame() {
  playerX = width / 4;
  playerY = height - playerSize;
  playerSpeedY = 0;
  isJumping = false;
  score = 0;
  gameOverFlag = false;
  obstacles.clear();
  loop(); // Reanudar el juego si estaba detenido
}

void draw() {
  background(backgroundImage);

  // Mover y dibujar el jugador
  movePlayer();
  drawPlayer();

  // Mover y dibujar los obstáculos
  moveObstacles();
  drawObstacles();

  // Detectar colisiones
  checkCollisions();

  // Actualizar puntuación
  updateScore();

  // Mostrar puntuación
  textSize(32);
  fill(255);
  text("Score: " + score, 20, 40);

  // Mostrar botón de reinicio si se termina el juego
  if (gameOverFlag) {
    displayRestartButton();
  }
}

void movePlayer() {
  if (isJumping) {
    playerSpeedY += gravity;
    playerY += playerSpeedY;

    if (playerY >= height - playerSize) {
      playerY = height - playerSize;
      isJumping = false;
    }
  }
}

void drawPlayer() {
  fill(255, 0, 0);
  rect(playerX, playerY, playerSize, playerSize);
}

void moveObstacles() {
  for (Obstacle obs : obstacles) {
    obs.move();
  }

  // Eliminar obstáculos fuera de la pantalla
  for (int i = obstacles.size() - 1; i >= 0; i--) {
    if (obstacles.get(i).x + obstacles.get(i).size < 0) {
      obstacles.remove(i);
    }
  }

  // Crear nuevos obstáculos
  if (frameCount % 60 == 0 && !gameOverFlag) {
    obstacles.add(new Obstacle());
  }
}

void drawObstacles() {
  for (Obstacle obs : obstacles) {
    obs.draw();
  }
}

void checkCollisions() {
  for (Obstacle obs : obstacles) {
    if (playerX < obs.x + obs.size &&
        playerX + playerSize > obs.x &&
        playerY < obs.y + obs.size &&
        playerY + playerSize > obs.y) {
      gameOver();
    }
  }
}

void updateScore() {
  if (!gameOverFlag) {
    score = frameCount / 60;
  }
}

void gameOver() {
  gameOverFlag = true;
  noLoop(); // Detener el juego
  textSize(64);
  fill(255, 0, 0);
  text("Game Over", width / 2 - 150, height / 2);
}

void keyPressed() {
  if (key == ' ' && !isJumping && !gameOverFlag) {
    isJumping = true;
    playerSpeedY = -12;
  }
}

void mousePressed() {
  if (gameOverFlag) {
    // Reiniciar el juego si se hace clic
    initializeGame();
  }
}

void displayRestartButton() {
  textSize(32);
  fill(255, 255, 0);
  text("Click to Restart", width / 2 - 100, height / 2 + 50);
}

class Obstacle {
  float x, y;
  float size = 50;
  float speed = 5;
  int type; // 0: Triángulo, 1: Círculo, 2: Polígono

  Obstacle() {
    x = width;
    y = height - size; // Asegurar que el obstáculo esté sobre el suelo
    type = int(random(3)); // Elegir un tipo de obstáculo aleatorio
  }

  void move() {
    x -= speed;
  }

  void draw() {
    fill(0, 0, 255);
    if (type == 0) {
      // Triángulo
      triangle(x, y + size, x + size, y + size, x + size / 2, y);
    } else if (type == 1) {
      // Círculo
      ellipse(x + size / 2, y + size / 2, size, size);
    } else if (type == 2) {
      // Polígono (hexágono)
      beginShape();
      for (int i = 0; i < 6; i++) {
        float angle = TWO_PI / 6 * i;
        float px = x + size / 2 + cos(angle) * size / 2;
        float py = y + size / 2 + sin(angle) * size / 2;
        vertex(px, py);
      }
      endShape(CLOSE);
    }
  }
}
