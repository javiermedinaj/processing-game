let playerX, playerY;
let playerSize = 50;
let playerSpeedY = 0;
let gravity = 0.6;
let isJumping = false;
let obstacles = [];
let score = 0;
let gameOverFlag = false;
function setup() {
    createCanvas(800, 600);
    initializeGame();
}
function initializeGame() {
    playerX = width / 4;
    playerY = height - playerSize;
    playerSpeedY = 0;
    isJumping = false;
    score = 0;
    gameOverFlag = false;
    obstacles = [];
    loop(); // Reanudar el juego si estaba detenido
}
function draw() {
    background(0);
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
function movePlayer() {
    if (isJumping) {
        playerSpeedY += gravity;
        playerY += playerSpeedY;
        if (playerY >= height - playerSize) {
            playerY = height - playerSize;
            isJumping = false;
        }
    }
}
function drawPlayer() {
    fill(255, 0, 0);
    rect(playerX, playerY, playerSize, playerSize);
}
function moveObstacles() {
    for (let i = obstacles.length - 1; i >= 0; i--) {
        obstacles[i].move();
        if (obstacles[i].x + obstacles[i].size < 0) {
            obstacles.splice(i, 1);
        }
    }
    // Crear nuevos obstáculos
    if (frameCount % 60 == 0 && !gameOverFlag) {
        obstacles.push(new Obstacle());
    }
}
function drawObstacles() {
    for (let obs of obstacles) {
        obs.draw();
    }
}
function checkCollisions() {
    for (let obs of obstacles) {
        if (playerX < obs.x + obs.size &&
            playerX + playerSize > obs.x &&
            playerY < obs.y + obs.size &&
            playerY + playerSize > obs.y) {
            gameOver();
        }
    }
}
function updateScore() {
    if (!gameOverFlag) {
        score = Math.floor(frameCount / 60);
    }
}
function gameOver() {
    gameOverFlag = true;
    noLoop(); // Detener el juego
    textSize(64);
    fill(255, 0, 0);
    text("Game Over", width / 2 - 150, height / 2);
}
function keyPressed() {
    if (key == ' ' && !isJumping && !gameOverFlag) {
        isJumping = true;
        playerSpeedY = -12;
    }
}
function mousePressed() {
    if (gameOverFlag) {
        // Reiniciar el juego si se hace clic
        initializeGame();
    }
}
function displayRestartButton() {
    textSize(32);
    fill(255, 255, 0);
    text("Click to Restart", width / 2 - 100, height / 2 + 50);
}
class Obstacle {
    constructor() {
        this.x = width;
        this.y = height - 50; // Asegurar que el obstáculo esté sobre el suelo
        this.size = 50;
        this.speed = 5;
    }
    move() {
        this.x -= this.speed;
    }
    draw() {
        fill(0, 0, 255);
        // Ajustar la posición para que el triángulo esté alineado con el suelo
        triangle(this.x, this.y + this.size, this.x + this.size, this.y + this.size, this.x + this.size / 2, this.y);
    }
}