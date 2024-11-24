import java.util.ArrayList;

public class GeometryDashGame {
    private Player player;
    private ArrayList<Obstacle> obstacles;
    private int score;
    private boolean gameOverFlag;
    private boolean gameWon;
    private PImage backgroundImage;
    private PImage coinImage;
    private final float floorY = 550;
    private ArrayList<Platform> platforms;
    private ArrayList<Coin> coins;

    public GeometryDashGame(PImage backgroundImage, PImage cubeImage, PImage coinImage) {
        this.backgroundImage = backgroundImage;
        this.coinImage = coinImage;
        initializeGame(cubeImage);
    }
    
 public void initializeGame(PImage cubeImage) {
        player = new Player(100, floorY - 50, 50, cubeImage);
        obstacles = new ArrayList<>();
        platforms = new ArrayList<>();
        coins = new ArrayList<>();
        score = 0;
        gameOverFlag = false;
        gameWon = false;

    obstacles.add(new TriangleObstacle(800, floorY - 50, 50, 5));
    obstacles.add(new SpikeObstacle(1200, floorY - 1, 50, 5));
    obstacles.add(new SpikeObstacle(1250, floorY - 1, 50, 5));;
    obstacles.add(new RectangleObstacle(1500, floorY - 1, 50, 5));  
    platforms.add(new Platform(1500, 450, 300, 20));
    obstacles.add(new SpikeObstacle(1700, 450 - 1, 40, 5));
    obstacles.add(new SpikeObstacle(1750, 450 - 1, 40, 5));
    coins.add(new Coin(1750, 350, 50, coinImage));  
    obstacles.add(new TriangleObstacle(2100, floorY - 50, 50, 5));
    obstacles.add(new TriangleObstacle(2400, floorY - 50, 50, 5));
    platforms.add(new Platform(2600, 450, 200, 20));
    platforms.add(new Platform(2800, 350, 300, 20));
    obstacles.add(new SpikeObstacle(2700, 450 - 1, 40, 5));
    obstacles.add(new SpikeObstacle(2750, 450 - 1, 40, 5));
    coins.add(new Coin(2750, 300, 50, coinImage));
    obstacles.add(new SpikeObstacle(3200, floorY - 1, 50, 5));
    obstacles.add(new TriangleObstacle(3250, floorY - 50, 50, 5));
    platforms.add(new Platform(3500, 450, 150, 20));
    obstacles.add(new SpikeObstacle(3600, 450 - 1, 40, 5));
    obstacles.add(new SpikeObstacle(3500, floorY - 1, 50, 5));
    obstacles.add(new TriangleObstacle(3550, floorY - 50, 50, 5));
    obstacles.add(new TriangleObstacle(3600, floorY - 50, 50, 5));
    coins.add(new Coin(3550, 350, 50, coinImage));
  }

    public void updateGame() {
        if (!gameOverFlag) {
            player.move(platforms);
            moveObstacles();
            movePlatforms();
            moveCoins();
            checkCollisions();
            checkCoinCollection();
            checkGameEnd();
        }
    }

    private void moveCoins() {
        for (Coin coin : coins) {
            coin.move(5);
        }
        for (int i = coins.size() - 1; i >= 0; i--) {
            if (coins.get(i).getX() + coins.get(i).getSize() < 0) {
                coins.remove(i);
            }
        }
    }

    private void checkCoinCollection() {
        for (Coin coin : coins) {
            if (!coin.isCollected() && player.checkCollision(coin)) {
                coin.collect();
                score += 10; 
            }
        }
    }

    private void checkGameEnd() {
        if (!obstacles.isEmpty()) {
            Obstacle lastObstacle = obstacles.get(obstacles.size() - 1);
            if (player.getX() > lastObstacle.getX() + lastObstacle.getSize()) {
                gameWin();
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
        for (Coin coin : coins) {
            coin.draw(pg);
        }
        pg.stroke(255);
        pg.strokeWeight(2);
        pg.line(0, floorY, width, floorY);
        pg.textSize(32);
        pg.fill(255);
        pg.text("Score: " + score, 60, 40);
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
        if (!obs.isScored() && player.getX() > obs.getX() + obs.getSize()) {
            score += 5; 
            obs.setScored(true); 
        }
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
    public void gameOver() {
        gameOverFlag = true;
        gameWon = false;
        noLoop();
    }

    public void gameWin() {
        gameOverFlag = true;
        gameWon = true;
        noLoop();
    }

    public void jumpPlayer() {
        player.jump();
    }

   public void displayRestartButton(PGraphics pg) {
        pg.textSize(32);
        pg.textAlign(PGraphics.CENTER);
        
        if (gameWon) {
            pg.fill(0, 255, 0); 
            pg.text("You Win!", width / 2, height / 2);
            pg.fill(255, 255, 0);
            pg.text("Play Again?", width / 2, height / 2 + 50);
        } else {
            pg.fill(255, 0, 0);
            pg.text("Game Over!", width / 2, height / 2);
            pg.fill(255, 255, 0);
            pg.text("Click to Try Again", width / 2, height / 2 + 50);
        }
        
        pg.fill(255);
        pg.text("Final Score: " + score, width / 2, height / 2 - 50);
    }
}
