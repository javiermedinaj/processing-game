PImage playerImg;
PImage invaderImg;
PImage bulletImg;

float playerX;
float playerY;
float bulletX;
float bulletY;
boolean bulletActive = false;

float invaderX;
float invaderY;
float invaderSpeed = 1;

void setup() {
  size(800, 600);
  
  // Cargar las imágenes
  playerImg = loadImage("player.png");
  invaderImg = loadImage("invader.png");
  bulletImg = loadImage("bullet.png");
  
  // Posición inicial del jugador
  playerX = width / 2;
  playerY = height - 50;
  
  // Posición inicial del invasor
  invaderX = width / 2;
  invaderY = 50;
}

void draw() {
  background(0);
  
  // Dibujar el jugador
  image(playerImg, playerX - playerImg.width / 2, playerY - playerImg.height / 2);
  
  // Mover el jugador
  if (keyPressed) {
    if (keyCode == LEFT && playerX > playerImg.width / 2) {
      playerX -= 5;
    } else if (keyCode == RIGHT && playerX < width - playerImg.width / 2) {
      playerX += 5;
    }
  }
  
  // Dibujar el invasor
  image(invaderImg, invaderX - invaderImg.width / 2, invaderY - invaderImg.height / 2);
  
  // Mover el invasor
  invaderX += invaderSpeed;
  if (invaderX > width - invaderImg.width / 2 || invaderX < invaderImg.width / 2) {
    invaderSpeed *= -1;
    invaderY += 20;
  }
  
  // Dibujar el disparo
  if (bulletActive) {
    image(bulletImg, bulletX - bulletImg.width / 2, bulletY - bulletImg.height / 2);
    bulletY -= 5;
    
    // Verificar si el disparo alcanza al invasor
    if (bulletX > invaderX - invaderImg.width / 2 && bulletX < invaderX + invaderImg.width / 2 &&
        bulletY > invaderY - invaderImg.height / 2 && bulletY < invaderY + invaderImg.height / 2) {
      bulletActive = false;
      invaderX = width / 2;
      invaderY = 50;
    }
    
    // Verificar si el disparo sale de la pantalla
    if (bulletY < 0) {
      bulletActive = false;
    }
  }
}

void keyPressed() {
  if (key == ' ' && !bulletActive) {
    bulletX = playerX;
    bulletY = playerY - playerImg.height / 2;
    bulletActive = true;
  }
}
