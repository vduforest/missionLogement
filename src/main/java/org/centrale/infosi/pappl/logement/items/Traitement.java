/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package org.centrale.infosi.pappl.logement.items;

import java.io.Serializable;
import java.util.Date;
import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;

/**
 * Entity for tracking dossier processing history.
 */
@Entity
@Table(name = "traitement")
@NamedQueries({
        @NamedQuery(name = "Traitement.findAll", query = "SELECT t FROM Traitement t"),
        @NamedQuery(name = "Traitement.findByFormulaireId", query = "SELECT t FROM Traitement t WHERE t.formulaireId = :formulaireId ORDER BY t.dateTraitement DESC")
})
public class Traitement implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "traitement_id")
    private Integer traitementId;

    @Column(name = "date_traitement")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateTraitement;

    @JoinColumn(name = "formulaire_id", referencedColumnName = "formulaire_id")
    @ManyToOne(optional = false)
    private Formulaire formulaireId;

    @JoinColumn(name = "personne_id", referencedColumnName = "personne_id")
    @ManyToOne(optional = false)
    private Personne personneId;

    public Traitement() {
    }

    public Traitement(Integer traitementId) {
        this.traitementId = traitementId;
    }

    public Integer getTraitementId() {
        return traitementId;
    }

    public void setTraitementId(Integer traitementId) {
        this.traitementId = traitementId;
    }

    public Date getDateTraitement() {
        return dateTraitement;
    }

    public void setDateTraitement(Date dateTraitement) {
        this.dateTraitement = dateTraitement;
    }

    public Formulaire getFormulaireId() {
        return formulaireId;
    }

    public void setFormulaireId(Formulaire formulaireId) {
        this.formulaireId = formulaireId;
    }

    public Personne getPersonneId() {
        return personneId;
    }

    public void setPersonneId(Personne personneId) {
        this.personneId = personneId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (traitementId != null ? traitementId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        if (!(object instanceof Traitement)) {
            return false;
        }
        Traitement other = (Traitement) object;
        if ((this.traitementId == null && other.traitementId != null)
                || (this.traitementId != null && !this.traitementId.equals(other.traitementId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "org.centrale.infosi.pappl.logement.items.Traitement[ traitementId=" + traitementId + " ]";
    }
}
