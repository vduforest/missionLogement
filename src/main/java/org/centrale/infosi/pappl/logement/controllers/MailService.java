/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package org.centrale.infosi.pappl.logement.controllers;

import java.util.Optional;
import org.centrale.infosi.pappl.logement.items.ConfigModif;
import org.centrale.infosi.pappl.logement.items.Personne;
import org.centrale.infosi.pappl.logement.repositories.ConfigModifRepository;
import org.centrale.infosi.pappl.logement.repositories.PersonneRepository;
import static org.centrale.infosi.pappl.logement.util.MailConstants.*;
import org.springframework.stereotype.Service;

/**
 * Service responsable de la construction et de l'envoi des mails automatiques
 * Il délègue l'envoi effectif des mails au MailController
 * @author vdufo
 */
@Service
public class MailService {

    private final MailController mailController;
    private final ConfigModifRepository configModifRepository;
    private final PersonneRepository personneRepository;

    /**
     * Constructeur du service d'envoi de mails
     * @param mailController controller responsable de l'envoi effectif des mails
     * @param configModifRepository repository permettant l'accès aux contenus des messages srockés en base
     * @param personneRepository repository permettant l'accès aux informations des utilisateurs
     */
    public MailService(MailController mailController,ConfigModifRepository configModifRepository,PersonneRepository personneRepository) {
        this.mailController = mailController;
        this.configModifRepository = configModifRepository;
        this.personneRepository = personneRepository;
    }

    /**
     * Méthode permettant un envoi de mail première connexion à un utilisateur
     * 
     * @param token token unique associé à la création du compte
     * @param recipient mail du destinataire
     */
    public void sendFirstConnectionMail(String token, String recipient) {
        String subject = "Première connexion à la plateforme logement";
        String link = "http://dtest-mlogement.ec-nantes.fr:8080/MissionLogement_test/creationcompte.do?token=" + token;

        String body = getConfigText(MSGPREMIERCONTACT);

        sendGenericMail(token, subject, body, link, recipient);
    }

    /**
     * Méthode permettant un envoi de mail de réinitialisation de mot de passe à un utilisateur
     * 
     * @param token token unique associé à la création du compte
     * @param recipient mail du destinataire
     */
    public void sendPasswordResetMail(String token, String recipient) {
        String subject = "Réinitialisation de votre mot de passe";
        String link = "http://dtest-mlogement.ec-nantes.fr:8080/MissionLogement_test/passwordresetlink.do?token=" + token;

        String body = getConfigText(MSGRESET);

        sendGenericMail(token, subject, body, link, recipient);
    }
    
    /**
     * Méthode permettant de construire le contenu du mail selon le type de mail envoyé
     * 
     * @param personne utilisateur concerné par la réinitialisation du mot de passe
     * @param subject objet du mail
     * @param body corps du mail
     * @param link lien à envoyer selon reset ou first connexion
     * @param token token unique associé à la création du compte
     * @param recipient mail du destinataire
     * @throws IllegalStateException si la configuration des mails est incomplète
     * @throws IllegalArgumentException si le token est invalide ou la personne est introuvable
     */
    private void sendGenericMail(String token,String subject,String body,String link, String mail) {
        
        Optional<Personne> recipientOpt = personneRepository.findByFirstConnectionToken(token);
        Optional<ConfigModif> signature = configModifRepository.getLastTypeId(SIGNATURE);
        Optional<ConfigModif> nb = configModifRepository.getLastTypeId(NB);
        
        if (recipientOpt.isEmpty()) {
        throw new IllegalArgumentException("Token invalide ou personne introuvable");
        }
        
        if (signature.isEmpty() || nb.isEmpty()) {
            throw new IllegalStateException("Configuration mail manquante");
        }

        StringBuilder texte = new StringBuilder();
        Personne recipient = recipientOpt.get();
        
        texte.append("Bonjour ")
                .append(recipient.getPrenom())
                .append(",\n\n");

        texte.append(body).append("\n\n");

        texte.append("Voici votre lien :\n")
                .append(link)
                .append("\n\n");

        texte.append("""
            Attention !! Ce lien est unique et personnel.
            Il expirera dans 24h à compter de la réception du mail.
            Si votre lien a expiré, merci de refaire une demande.
            """);

        texte.append("\n")
                .append(signature.get().getContenu())
                .append("\n\n")
                .append(nb.get().getContenu());

        mailController.sendEmail(token,mail,subject,texte.toString());
    }

    private String getConfigText(int typeId) {
        return configModifRepository.getLastTypeId(typeId).map(ConfigModif::getContenu).orElse("");
    }
}
