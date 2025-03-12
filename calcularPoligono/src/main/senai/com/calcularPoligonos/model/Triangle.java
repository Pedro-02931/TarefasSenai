package main.senai.com.calcularPoligonos.model;

public final class Triangle extends Shape {
    private static final double AREA_CONSTANT = Math.sqrt(3) * 0.25;
    private final double side;

    public Triangle(double side) {
        validate(side);
        this.side = side;
    }

    @Override
    public final double getArea() {
        return AREA_CONSTANT * side * side; 
    }

    @Override
    public final double getPerimeter() {
        return 3 * side;
    }
}
