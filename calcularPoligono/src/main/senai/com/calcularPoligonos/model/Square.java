package main.senai.com.calcularPoligonos.model;

public final class Square extends Shape {
    private final double side;

    public Square(double side) {
        validate(side, side);
        super.validate(side, side);
        this.side = side;
    }

    public double getSide() {
        return side;
    }

    @Override
    public double getArea() {
        return side * side;
    }

    @Override
    public double getPerimeter() {
        return 4 * side;
    }
}
