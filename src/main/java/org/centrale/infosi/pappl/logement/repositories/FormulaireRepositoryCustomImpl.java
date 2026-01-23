/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package org.centrale.infosi.pappl.logement.repositories;

import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.Optional;
import org.centrale.infosi.pappl.logement.items.Formulaire;
import org.centrale.infosi.pappl.logement.items.Genre;
import org.centrale.infosi.pappl.logement.items.Pays;
import org.centrale.infosi.pappl.logement.items.Personne;
import org.centrale.infosi.pappl.logement.items.Souhait;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Repository;

/**
 * Repository custom des formulaires
 *
 * @author clesp
 */
@Repository
public class FormulaireRepositoryCustomImpl implements FormulaireRepositoryCustom {

    @Autowired
    @Lazy
    private FormulaireRepository repository;

    @Autowired
    @Lazy
    private PaysRepository paysRepository;

    @Autowired
    @Lazy
    private SouhaitRepository souhaitRepository;

    @Autowired
    @Lazy
    private GenreRepository genreRepository;

    @Autowired
    @Lazy
    private PersonneRepository personneRepository;

    /**
     * Cree un nouveau formulaire à l'import des nouvelles donnees
     *
     * @param personne
     * @param ville
     * @param mail
     * @param scei
     * @param dateDeNaissance
     * @param codePostal
     * @param genreId
     * @param paysId
     * @return le formulaire cree
     */
    @Override
    public Formulaire createNewForm(
            Personne personne, String ville, String mail, String scei,
            Date dateDeNaissance, String codePostal, Genre genreId, Pays paysId) {

        if ((personne != null) && (scei != null) && (genreId != null) && (paysId != null)) {

            Formulaire item = new Formulaire();

            item.setPersonneId(personne);
            item.setNumeroScei(scei);
            item.setGenreId(genreId);
            item.setGenreAttendu(genreId);
            item.setPaysId(paysId);

            if (ville != null) {
                ville = ville.trim();
                if (!ville.isEmpty()) {
                    item.setVille(ville);
                }
            }
            if (mail != null) {
                mail = mail.trim().toLowerCase();
                if (!mail.isEmpty()) {
                    item.setMail(mail);
                }
            }
            if (dateDeNaissance != null) {
                item.setDateDeNaissance(dateDeNaissance);
            }
            if (codePostal != null) {
                codePostal = codePostal.trim();
                item.setCodePostal(codePostal);
            }

            repository.saveAndFlush(item);

            Optional<Formulaire> result = repository.findById(item.getFormulaireId());
            if (result.isPresent()) {
                return result.get();
            }
        }
        return null;
    }

    /**
     * Met à jour un formulaire
     */
    @Override
    public Formulaire update(int id,
            String nom, String prenom, Date dateNaissance, String ville, String codePostal,
            int pays, String mail, int genre,
            String numTelephone, String numTelephone2,
            Double distance, Boolean estInternational, Integer rang,
            String boursier, int souhait, String pmr,
            String commentaireVe, String commentaireEleve, Boolean validation) {

        Formulaire formulaire = repository.getReferenceById(id);
        if (formulaire != null) {

            // Mise à jour noms / prénoms (dans Personne)
            personneRepository.updateNoms(formulaire.getPersonneId().getPersonneId(), nom, prenom);

            // Date naissance
            if (dateNaissance != null) {
                formulaire.setDateDeNaissance(dateNaissance);
            }

            // Ville
            if (ville != null) {
                ville = ville.trim();
                if (!ville.isEmpty()) {
                    formulaire.setVille(ville);
                }
            }

            // Code postal
            if (codePostal != null) {
                codePostal = codePostal.trim();
                formulaire.setCodePostal(codePostal);
            }

            // Pays
            if (pays > 0) {
                Pays paysId = paysRepository.getReferenceById(pays);
                if (paysId != null) {
                    formulaire.setPaysId(paysId);
                }
            }

            // Mail
            if (mail != null) {
                mail = mail.trim().toLowerCase();
                formulaire.setMail(mail);
            }

            // Genre
            if (genre > 0) {
                Genre genreId = genreRepository.getReferenceById(genre);
                if (genreId != null) {
                    formulaire.setGenreId(genreId);
                }
            }

            // Téléphone 1
            if (numTelephone != null) {
                numTelephone = numTelephone.trim();
                formulaire.setNumeroTel(numTelephone);
            }

            // Téléphone 2 (NOUVEAU)
            if (numTelephone2 != null) {
                numTelephone2 = numTelephone2.trim();
                if (numTelephone2.isEmpty()) {
                    numTelephone2 = null;
                }
                formulaire.setNumeroTel2(numTelephone2);
            } else {
                formulaire.setNumeroTel2(null);
            }

            // Distance (NOUVEAU)
            formulaire.setDistance(distance);

            // International (NOUVEAU)
            formulaire.setEstInternational(estInternational);

            // Rang (NOUVEAU)
            formulaire.setRang(rang);

            // Souhait
            if (souhait > 0) {
                Souhait souhaitId = souhaitRepository.getReferenceById(souhait);
                if (souhaitId != null) {
                    formulaire.setSouhaitId(souhaitId);
                }
            } else {
                formulaire.setSouhaitId(null);
            }

            // Commentaires
            formulaire.setCommentairesVe(commentaireVe);
            formulaire.setCommentairesEleve(commentaireEleve);

            // PMR
            switch (pmr) {
                case "true":
                    formulaire.setEstPmr(true);
                    break;
                case "false":
                    formulaire.setEstPmr(false);
                    break;
                default:
                    formulaire.setEstPmr(null);
                    break;
            }

            // Boursier
            switch (boursier) {
                case "true":
                    formulaire.setEstBoursier(true);
                    break;
                case "false":
                    formulaire.setEstBoursier(false);
                    break;
                default:
                    formulaire.setEstBoursier(null);
                    break;
            }

            // Validation
            if (validation != null) {
                formulaire.setEstConforme(validation);
                formulaire.setEstValide(validation);
            }

            repository.saveAndFlush(formulaire);
            return formulaire;
        }
        return null;
    }

    /**
     * Vide et valide un formulaire (en cas de problème pour remplir un formulaire par un élève)
     */
    @Override
    public Formulaire viderEtValider(int id) {
        Formulaire formulaire = repository.getReferenceById(id);
        if (formulaire != null) {
            formulaire.setGenreId(formulaire.getGenreAttendu());
            formulaire.setNumeroTel(null);
            formulaire.setNumeroTel2(null);     // ✅ nouveau
            formulaire.setSouhaitId(null);
            formulaire.setEstBoursier(null);
            formulaire.setEstPmr(null);
            formulaire.setDistance(null);       // ✅ nouveau
            formulaire.setEstInternational(null); // ✅ nouveau
            formulaire.setRang(null);           // ✅ nouveau

            Date dateValidation = new Date();
            formulaire.setCommentairesEleve(null);
            formulaire.setDateValidation(dateValidation);

            formulaire.setEstValide(true);

            repository.saveAndFlush(formulaire);
            return formulaire;
        }
        return null;
    }

    @Override
    public void soumettre(int id, boolean soumission) {
        Formulaire formulaire = repository.getReferenceById(id);
        if (formulaire != null) {
            if (soumission) {
                Calendar aCalendar = Calendar.getInstance();
                Date now = aCalendar.getTime();
                formulaire.setEstValide(true);
                formulaire.setDateValidation(now);
            } else {
                formulaire.setEstValide(false);
                formulaire.setDateValidation(null);
            }
            repository.saveAndFlush(formulaire);
        }
    }

    @Override
    public Formulaire getByEmail(String mail) {
        if ((mail != null) && (!mail.isEmpty())) {
            Collection<Formulaire> result = repository.findByEmailNoCase(mail);
            if ((result != null) && (result.size() == 1)) {
                return result.iterator().next();
            }
        }
        return null;
    }

    @Override
    public Formulaire getBySCEI(String scei) {
        if ((scei != null) && (!scei.isEmpty())) {
            Collection<Formulaire> result = repository.findByNumeroScei(scei);
            if ((result != null) && (result.size() == 1)) {
                return result.iterator().next();
            }
        }
        return null;
    }
}
