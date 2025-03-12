package main.senai.com.calcularPoligonos.model;

public final class Square extends Shape {
    private final double side;

    public Square(double side) {
        validate(side);
        this.side = side;
    }

    @Override
    public final double getArea() {
        return side * side;
    }

    @Override
    public final double getPerimeter() {
        return 4 * side;
    }
}
