package main.senai.com.calcularPoligonos.model;
import java.lang.IllegalArgumentException;

public abstract class Shape {

    public abstract double getArea();

    public abstract double getPerimeter();

    protected void validate(double... values) {
        for (double value : values) {
            if (value <= 0) throw new IllegalArgumentException(
                    "Os valores devem ser maiores que 0."
            );
        }
    }

}
