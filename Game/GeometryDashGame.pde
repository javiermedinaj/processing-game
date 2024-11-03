import java.util.ArrayList;
import processing.core.PGraphics;
import processing.core.PImage;

public class GeometryDashGame {
    private Player player;
    private ArrayList<Obstacle> obstacles;
    private int score;
    private boolean gameOverFlag;
    private PImage backgroundImage;
    private final float floorY = 550;
    private ArrayList<Platform> platforms;

    public GeometryDashGame(PImage backgroundImage, PImage cubeImage) {
        this.backgroundImage = backgroundImage;
        initializeGame(cubeImage);
    }

public void initializeGame(PImage cubeImage) {
 player = new Player(100, floorY - 50, 50, cubeImage);
    obstacles = new ArrayList<>();
    platforms = new ArrayList<>();
    score = 0;
    gameOverFlag = false;

    //platforms.add(new Platform(500, 450, 100, 20));
    //platforms.add(new Platform(700, 400, 200, 20));
    //platforms.add(new Platform(900, 300, 200, 20));
    //platforms.add(new Platform(1100, 250, 200, 20));
    platforms.add(new Platform(2300, 450, 200, 20));

    obstacles.add(new TriangleObstacle(800, floorY - 50, 50, 5));
    obstacles.add(new RectangleObstacle(1200, floorY - 1, 50, 5));
    obstacles.add(new TriangleObstacle(1600, floorY - 50, 50, 5));
    obstacles.add(new SpikeObstacle(2000, floorY - 1, 50, 5));
    obstacles.add(new SpikeObstacle(2500, floorY - 1, 50, 5));
    obstacles.add(new SpikeObstacle(2550, floorY - 1, 50, 5));
    obstacles.add(new SpikeObstacle(2700, floorY - 1, 50, 5));
    obstacles.add(new SpikeObstacle(2800, floorY - 1, 50, 5));
    obstacles.add(new SpikeObstacle(2900, floorY - 1, 50, 5));
}

public void updateGame() {
    if (!gameOverFlag) {
        player.move(platforms);
        moveObstacles();
        movePlatforms();
        checkCollisions();
        updateScore();
        checkGameEnd(); // Verificar si el juego ha terminado
    }
}

private void checkGameEnd() {
    if (!obstacles.isEmpty()) {
        Obstacle lastObstacle = obstacles.get(obstacles.size() - 1);
        if (player.getX() > lastObstacle.getX() + lastObstacle.getSize()) {
            gameOver();
        }
    }
}


    public void drawGame(PGraphics pg) {
        pg.background(backgroundImage);
        player.draw(pg);
        for (Platform plat : platforms) {
            plat.draw(pg);
        }
        for (Obstacle obs : obstacles) {
            obs.draw(pg);
        }
        pg.stroke(255); 
        pg.strokeWeight(2);
        pg.line(0, floorY, width, floorY); 
        pg.textSize(32);
        pg.fill(255);
        pg.text("Score: " + score, 20, 40);
        if (gameOverFlag) {
            displayRestartButton(pg);
        }
    }

    private void movePlatforms() {
        for (Platform platform : platforms) {
            platform.move(5);
        }
        for (int i = platforms.size() - 1; i >= 0; i--) {
            if (platforms.get(i).getX() + platforms.get(i).getWidth() < 0) {
                platforms.remove(i);
            }
        }
    }

    private void moveObstacles() {
        for (Obstacle obs : obstacles) {
            obs.move();
        }
        for (int i = obstacles.size() - 1; i >= 0; i--) {
            if (obstacles.get(i).getX() + obstacles.get(i).getSize() < 0) {
                obstacles.remove(i);
            }
        }
    }

    private void checkCollisions() {
        for (Obstacle obs : obstacles) {
            if (player.checkCollision(obs)) {
                gameOver();
            }
        }
    }

    private void updateScore() {
        if (!gameOverFlag) {
            score = frameCount / 60;
        }
    }

    public void gameOver() {
        gameOverFlag = true;
        noLoop();
    }

    public void jumpPlayer() {
        player.jump();
    }

    public void displayRestartButton(PGraphics pg) {
        pg.textSize(32);
        pg.fill(255, 255, 0);
        pg.text("Click to Restart", width / 2 - 100, height / 2 + 50);
    }
}
