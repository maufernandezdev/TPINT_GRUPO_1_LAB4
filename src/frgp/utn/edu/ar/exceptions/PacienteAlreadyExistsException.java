package frgp.utn.edu.ar.exceptions;

public class PacienteAlreadyExistsException extends RuntimeException {
	
	private static final long serialVersionUID = 1L;

	public PacienteAlreadyExistsException(String message) {
        super(message);
    }
}
