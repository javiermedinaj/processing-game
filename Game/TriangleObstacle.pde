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