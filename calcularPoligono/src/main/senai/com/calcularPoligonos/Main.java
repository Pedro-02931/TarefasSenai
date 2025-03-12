package main.senai.com.calcularPoligonos;

import main.senai.com.calcularPoligonos.model.*;

import java.io.BufferedReader; // Reduces latency in user input capture
import java.io.IOException;
import java.io.InputStreamReader;

/*
HPC Concepts 
    - Pre-computed area constant
    + On the other hand, division is a much more expensive operation, as it involves iterative algorithms (Newton-Raphson, Goldschmidt) that take more cycles.
    + If an idea is fixed in your mind (immutable), you don't need to reanalyze it every time you make a decision, saving mental processing.
        # Example: If you have already internalized that the square root of 2 is approximately 1.41, you don't need to recalculate it every time you need it.


    - Mathematical and Logic concepts
    + The multiplication of floating-point numbers is an operation that most FPUs can perform in a fixed and small number of clock cycles.
    + Given that the shapes will not have more than three dimensions, I chose to perform the validation directly using values and conditionals, where Shape.validate() checks if any of the three dimensions are greater than 0.
        # Example: if (v1 <= 0 || v2 <= 0) If v1 is less than or equal to zero, it does NOT even check v2, because it already knows that the condition is true.
        - This saves CPU cycles because it avoids unnecessary checks.

    - GarbageCollector
    + The use of `final` was implemented to anticipate unexpected changes and reduce thermal entropy, as the lack of nesting can cause the CPU to read two blocks instead of one, literally creating a state of quantum superposition.
    + 

    - Optimization
    + The BufferedReader is more efficient than the Scanner because it reads input as a continuous stream of characters, while the Scanner performs internal parsing and uses regular expressions to interpret the data, which introduces extra latency.
        - BufferedReader → Reads entire lines of text in a raw format, without interpreting the data.
        - Scanner → Interprets each input using parsing rules (numbers, words, tokens), which adds overhead.
        #Examples:
            - BufferedReader Mode (fast, continuous reading)
            → You listen to an entire sentence and understand the context before analyzing it word by word.
            ===========================================
            - Scanner Mode (slow, line-by-line parsing)
            → You listen to a sentence and need to analyze each word separately, checking if it makes sense before moving on to the next one.
    + The variable running allows the main execution loop to continue without forcing the program to terminate with System.exit(). Instead, it simply sets it to false, which causes the next iteration of the while loop to fail the condition and terminate naturally.
        - It avoids abruptly shutting down the JVM– System.exit() kills all threads and can interrupt critical operations.
        - It facilitates debugging and testing – The program ends naturally, without generating unexpected behavior.
        # Example:
            - System.exit() equivalent in your brain → Experiencing a blackout due to data overload or extreme exhaustion.
            ===========================================
            - `running = false` in your brain → You consciously decide to stop thinking about something without needing to collapse the entire system.
*/

public class Main {
    public static void main(String[] args) throws IOException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        boolean running = true;

        while (running) {
            System.out.println("Escolha a forma geométrica desejada: \n"
                + "1 - Círculo\n"
                + "2 - Retângulo\n"
                + "3 - Quadrado\n"
                + "4 - Triângulo\n"
                + "5 - Trapézio\n"
                + "6 - Sair\n"
                + "Digite o número correspondente: ");

            String input = reader.readLine();

            if (input == null) break; // Null check to prevent unexpected termination due to EOF(It's like you're waiting for someone's response, but you don't receive any message (I hate you, mom)).

            Shape shape = null; // Initialized lazily (no unnecessary memory allocation).

            try {
                switch (input.trim()) {
                    case "1":
                        System.out.print("Digite o raio: ");
                        double radius = parseDouble(reader);
                        shape = new Circle(radius);
                        break;

                    case "2":
                        System.out.print("Digite a largura: ");
                        double width = parseDouble(reader);
                        System.out.print("Digite a altura: ");
                        double height = parseDouble(reader);
                        shape = new Rectangle(width, height);
                        break;

                    case "3":
                        System.out.print("Digite o lado: ");
                        double side = parseDouble(reader);
                        shape = new Square(side);
                        break;

                    case "4":
                        System.out.print("Digite o lado: ");
                        double sideTri = parseDouble(reader);
                        shape = new Triangle(sideTri);
                        break;

                    case "5":
                        System.out.print("Digite a base maior: ");
                        double biggerBase = parseDouble(reader);
                        System.out.print("Digite a base menor: ");
                        double smallerBase = parseDouble(reader);
                        System.out.print("Digite a altura: ");
                        double trapHeight = parseDouble(reader);
                        shape = new Trapezoid(biggerBase, smallerBase, trapHeight);
                        break;

                    case "6":
                        running = false;
                        System.out.println("Saindo do sistema...");
                        break;

                    default:
                        System.out.println("Opção inválida. Por favor, tente novamente.");
                }

                if (shape != null) {
                    exibirResultados(shape);
                }

            } catch (NumberFormatException e) {
                System.out.println("Número inválido. Por favor, tente novamente.");
            } catch (IllegalArgumentException e) {
                System.out.println(e.getMessage());
            }
        }

        reader.close();
    }

    private static double parseDouble(BufferedReader reader) throws IOException {
        String line = reader.readLine();

        if (line == null) throw new IOException("EOF inesperado durante a leitura.");

        return Double.parseDouble(line.trim());
    }

    private static void exibirResultados(Shape shape) {
        System.out.printf("\nÁrea: %.2f\nPerímetro: %.2f\n",
                shape.getArea(), shape.getPerimeter());
    }
}