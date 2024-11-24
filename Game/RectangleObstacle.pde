public class RectangleObstacle extends Obstacle {
    public RectangleObstacle(float x, float y, float size, float speed) {
        super(x, y, size, speed);
    }

    @Override
    public void draw(PGraphics pg) {
        pg.fill(255, 0, 0); 
        pg.noStroke();
        pg.rect(x, y - size, size, size); 
    }
}
