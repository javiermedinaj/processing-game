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