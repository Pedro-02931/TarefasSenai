package main.senai.com.calcularPoligonos.model;
import java.lang.IllegalArgumentException;

public abstract class Shape {
    protected final void validate(double value) {
        if (value <= 0) {
            throw new IllegalArgumentException("Os valores devem ser > 0");
        }
    }

    protected final void validate(double v1, double v2) {
        if (v1 <= 0 || v2 <= 0) {
            throw new IllegalArgumentException("Os valores devem ser > 0");
        }
    }

    protected final void validate(double v1, double v2, double v3) {
        if (v1 <= 0 || v2 <= 0 || v3 <= 0) {
            throw new IllegalArgumentException("Os valores devem ser > 0");
        }
    }

    public abstract double getArea();
    public abstract double getPerimeter();
}
