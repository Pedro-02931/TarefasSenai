package main.senai.com.calcularPoligonos.model;

public final class Triangle extends Shape {
    private final double side;

    public Triangle(double side) {
        validate(side);
        this.side = side;
    }

    @Override
    public double getArea() {
        return (Math.sqrt(3) / 4) * Math.pow(side, 2);
    }

    @Override
    public double getPerimeter() {
        return 3 * side;
    }
}
