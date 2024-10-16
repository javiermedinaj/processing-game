import processing.core.PGraphics;

public abstract class Obstacle {
    protected float x, y, size, speed;

    public Obstacle(float x, float y, float size, float speed) {
        this.x = x;
        this.y = y;
        this.size = size;
        this.speed = speed;
    }

    public void move() {
        x -= speed;
    }

    public abstract void draw(PGraphics pg);

    public float getX() {
        return x;
    }

    public float getY() {
        return y;
    }

    public float getSize() {
        return size;
    }
}

public class TriangleObstacle extends Obstacle {
    public TriangleObstacle(float x, float y, float size, float speed) {
        super(x, y, size, speed);
    }

    @Override
    public void draw(PGraphics pg) {
        pg.fill(0, 0, 255);
        pg.noStroke();
        pg.triangle(x, y + size, x + size, y + size, x + size / 2, y);
    }
}

public class RectangleObstacle extends Obstacle {
    public RectangleObstacle(float x, float y, float size, float speed) {
        super(x, y, size, speed);
    }

    @Override
    public void draw(PGraphics pg) {
        pg.fill(255); 
        pg.noStroke();
        pg.rect(x, y - size, size, size);
    }
}

public class CircleObstacle extends Obstacle {
    public CircleObstacle(float x, float y, float size, float speed) {
        super(x, y, size, speed);
    }

    @Override
    public void draw(PGraphics pg) {
        pg.fill(0, 255, 0); 
        pg.noStroke();
        pg.ellipse(x + size / 2, y - size - 10, size / 2, size / 2); // Bola verde sobre el rectángulo
    }
}

public class SpikeObstacle extends Obstacle {
    public SpikeObstacle(float x, float y, float size, float speed) {
        super(x, y, size, speed);
    }

    @Override
    public void draw(PGraphics pg) {
        pg.fill(0); 
        pg.noStroke();
        pg.triangle(x, y, x + size, y, x + size / 2, y - size); 
    }
}
