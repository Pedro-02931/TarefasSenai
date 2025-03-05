package br.sp.senai.jandira.clinica;

import java.time.LocalDate;

import br.sp.senai.jandira.clinica.model.Paciente;

public class ClinicaApp {

	public static void main(String[] args) {
		
		Paciente p1 = new Paciente();
		
		p1.setNome("Joana");
		p1.setPeso(68);
		p1.setAltura(160);		
		p1.setGenero("F");
		p1.setTelefone("9998-5746");
		p1.setDataNascimento(LocalDate.of(2004, 2, 29));
		p1.exibirDados();
			// System.out.println(p1.getNome());
				
	}

}
