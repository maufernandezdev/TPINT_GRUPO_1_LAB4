package frgp.utn.edu.ar.entidad;

import java.io.Serializable;
import java.time.DayOfWeek;
import java.time.LocalTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "Horarios")
public class Horario implements Serializable {

	private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "dia")
    private DayOfWeek dia;

    @Column(name = "hora_inicio")
    private LocalTime horaInicio;

    @Column(name = "hora_fin")
    private LocalTime horaFin;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "medico_id")
    private Medico medico;

    public Horario() {
    }

    public Horario(String dia, LocalTime horaInicio, LocalTime horaFin, Medico medico) {
        this.dia = DayOfWeek.valueOf(dia.toUpperCase()); // Convertir el String a DayOfWeek
        this.horaInicio = horaInicio;
        this.horaFin = horaFin;
        this.medico = medico;
    }
    
// para faciltarr
    public void setHorarioDetails(String dia, LocalTime horaInicio, LocalTime horaFin, Medico medico) {
        this.dia = DayOfWeek.valueOf(dia.toUpperCase());
        this.horaInicio = horaInicio;
        this.horaFin = horaFin;
        this.medico = medico;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public DayOfWeek getDia() {
        return dia;
    }

    public void setDia(DayOfWeek dia) {
        this.dia = dia;
    }

    public LocalTime getHoraInicio() {
        return horaInicio;
    }

    public void setHoraInicio(LocalTime horaInicio) {
        this.horaInicio = horaInicio;
    }

    public LocalTime getHoraFin() {
        return horaFin;
    }

    public void setHoraFin(LocalTime horaFin) {
        this.horaFin = horaFin;
    }
    
    public Medico getMedico() {
        return medico;
    }

    public void setMedico(Medico medico) {
        this.medico = medico;
    }

    @Override
    public String toString() {
        return "Horario [id=" + id + ", dia=" + dia + ", horaInicio=" + horaInicio + ", horaFin=" + horaFin
                + ", medico=" + medico + "]";
    }
    
}

