/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package org.centrale.infosi.pappl.logement.controllers;

import java.util.Collection;
import org.centrale.infosi.pappl.logement.items.Alerte;
import org.centrale.infosi.pappl.logement.repositories.AlerteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import jakarta.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import org.centrale.infosi.pappl.logement.util.MailConstants;
import org.centrale.infosi.pappl.logement.items.ConfigModif;
import org.centrale.infosi.pappl.logement.items.Connexion;
import org.centrale.infosi.pappl.logement.items.Formulaire;
import org.centrale.infosi.pappl.logement.items.Personne;
import org.centrale.infosi.pappl.logement.repositories.ConfigModifRepository;
import org.centrale.infosi.pappl.logement.repositories.FormulaireRepository;
import org.centrale.infosi.pappl.logement.repositories.PersonneRepository;
import org.centrale.infosi.pappl.logement.controllers.MailService;
import org.centrale.infosi.pappl.logement.controllers.FirstConnectionController;
import org.centrale.infosi.pappl.logement.util.Util;
import static org.centrale.infosi.pappl.logement.util.Util.getIntFromString;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Cette classe permet l'envoie automatique du premier mail pour la connexion;
 * Controller mis en stand by car pas de serveur SMTP
 *
 * @author barbo
 *
 */
@Controller
public class MailController {

    @Lazy
    @Autowired
    private AlerteRepository alerteRepository;

    @Lazy
    @Autowired
    private FormulaireRepository formulaireRepository;

    @Lazy
    @Autowired
    private PersonneRepository personneRepository;

    @Autowired
    private ConnectionService connectionService;

    @Autowired
    private MailService mailService;

    @Lazy
    @Autowired
    private ConfigModifRepository configmodifrepository;

    @Autowired
    private FirstConnectionController firstConnection;

    // Constants are now imported from MailConstants
    /**
     * Méthode permettant d'envoyer un message de premier connexion à tous les
     * élèves selon la vague choisie
     *
     * @param request La requête http
     * @param messageType le type de message à envoyer
     * @return La page d'accueil admin avec un pop up
     */
    private int envoyerMessage(HttpServletRequest request, int messageType) {
        int returned;
        Connexion connection = connectionService.checkAccess(request, "Admin");
        if (connection != null) {
            try {

                // Il faut créer une liste avec l'adress mail de tous les utilisateurs.
                Optional<ConfigModif> contenuMsg = configmodifrepository.getLastTypeId(messageType);
                Optional<ConfigModif> envoyeurMsg = configmodifrepository.getLastTypeId(MailConstants.MAILCONTACT);
                if ((contenuMsg.isPresent()) && (envoyeurMsg.isPresent())) {
                    ConfigModif messageToSend = contenuMsg.get();
                    ConfigModif envoyeur = envoyeurMsg.get();

                    // On teste quel message est à envoyer
                    switch (messageType) {
                        // Si c'est un mail de premier connexion
                        case MailConstants.MSGPREMIERCONTACT:
                            List<String> tousLesTokens = personneRepository.findAllTokenVague();
                            Collection<String> tousLesMails = formulaireRepository.findAllEmailsVague();
                            int compteur = 0;
                            // On récupère les mails et on update la vague car on va leur envoyer un mail
                            for (String email : tousLesMails) {
                                mailService.sendFirstConnectionMail(tousLesTokens.get(compteur), email);
                                compteur++;
                            }
                            formulaireRepository.updateVague();

                            // Renvoie sur la page accueil_admin avec un message pop_up
                            List<Alerte> alertes = new ArrayList<Alerte>(alerteRepository.findAll());
                            Collections.sort(alertes, Alerte.getComparator());

                            // returned = connectionService.prepareModelAndView(connection, "accueil_admin");
                            // returned.addObject("Alertes", alertes);
                            if (tousLesMails.isEmpty()) {
                                // AUCUN MAIL A ENVOYER
                                return 1;
                                // returned.addObject("confirmationMessage", "Aucun mail à envoyer");
                            } else {
                                // EMAILS ENVOYES AVEC SUCCES
                                return 2;
                                // returned.addObject("confirmationMessage", "Emails envoyés avec succès ! ");
                            }

                        // Si c'est un mail de réinitialisation de mot de passe
                        case MailConstants.MSGRESET:

                            /* on reçoit l'id du formulaire et de la personne */
                            Integer id = Integer.parseInt(request.getParameter("id"));
                            Integer personneId = Integer.parseInt(request.getParameter("personneId"));

                            Optional<Formulaire> formulaires = formulaireRepository.findById(id);
                            Optional<Personne> perso = personneRepository.findById(personneId);

                            if (perso.isPresent() && formulaires.isPresent()) {
                                Personne personne = perso.get();
                                Formulaire formulaire = formulaires.get();

                                String token = personne.getFirstConnectionToken();

                                genererToken(personne);
                                // on met à jour le token transmis 
                                token = personne.getFirstConnectionToken();

                                String recipient = formulaire.getMail();
                                mailService.sendPasswordResetMail(token, recipient);
                            }
                            returned = 4;
                            break;

                        default:
                            returned = 0;
                            break;
                    }
                    return returned;
                }
            } catch (Exception e) {
                return 0;
            }
        }
        return 5;
    }

    @RequestMapping(value = "tokenmail.do", method = RequestMethod.POST)
    public ModelAndView genererTokenEnvoyerMail(HttpServletRequest request) {
        Connexion connection = connectionService.checkAccess(request, "Admin");
        ModelAndView returned = connectionService.prepareModelAndView(connection, "accueil_admin");
        String connexionId = request.getParameter("connexionId");
        if (connection != null) {
            if (firstConnection.generateTokensForAllUsers()) {
                int resEnvMessage = envoyerMessage(request, MailConstants.MSGPREMIERCONTACT);
                List<Alerte> alertes = new ArrayList<Alerte>(alerteRepository.findAll());
                Collections.sort(alertes, Alerte.getComparator());
                returned.addObject("Alertes", alertes);
                // Aucun mail à envoyer
                if (resEnvMessage == 1) {
                    returned.addObject("confirmationMessage", "Aucun mail à envoyer");
                } else {
                    // Les mails ont été envoyés
                    if (resEnvMessage == 2) {
                        returned.addObject("confirmationMessage", "Tokens generated and Mails sent successfully");
                    } else {
                        returned.addObject("ConfirmationMessage", "An error occurred while sending mails");
                    }
                }

            } else {
                returned.addObject("confirmationMessage", "An error occurred while generating tokens.");
            }
            returned.addObject("connexionId", connexionId);
            return returned;
        }
        return new ModelAndView("index");
    }

    /**
     * Gestion de l'envoi d'un mail lorsque un dossier est non conforme
     *
     * @param request La requête http
     */
    public void envoiMailDossierIncomplet(HttpServletRequest request) {
        // Récupération du mail à partir de la request
        String recipient = Util.getStringFromRequest(request, "mail");
        String comm = Util.getStringFromRequest(request, "commentairesVE");
        String prenom = Util.getStringFromRequest(request, "prenom");

        // Envoi au service - pas besoin de vérifier que le commentaire est vide, c'est
        // sûr que c'est bon
        mailService.sendDossierIncompletMail(recipient, comm, prenom);
    }

    public void envoiMailDossierComplet(HttpServletRequest request) {
        // Récupération du mail à partir de la request
        String recipient = Util.getStringFromRequest(request, "mail");
        String prenom = Util.getStringFromRequest(request, "prenom");

        mailService.sendDossierCompletMail(recipient, prenom);
    }

    /**
     * Gestion de la route permettant d'envoyer les mails de reçu du formulaire
     *
     * @param request La requête http
     * @return La page d'accueil admin avec un pop up
     
    @RequestMapping(value = "envoiemailfin.do", method = RequestMethod.POST)
    public ModelAndView EnvoiFin(HttpServletRequest request) {
        return envoyerMessage(request, MailConstants.MSGPFIN);
    }*/

    /**
     * Gestion de la route permettant d'envoyer les mails de reset perso
     *
     * @param request La requête http
     * @return La page d'accueil admin avec un pop up
     */
    @RequestMapping(value = "envoiemailresetperso.do", method = RequestMethod.POST)
    public ModelAndView EnvoiReset(HttpServletRequest request) {
        int resEnvoiMail = envoyerMessage(request, MailConstants.MSGRESET);
        ModelAndView returned  = new ModelAndView("index");
        if (resEnvoiMail == 4){
            returned.addObject("ConfirmationMessage", "Mail de réinitialisation envoyé");
        } else{
            returned.addObject("ConfirmationMessage", "Erreur lors de l'envoi, veuillez contacter la mission logement");
        }
        return returned;
    }

    public void genererToken(Personne personne) {
        String token = firstConnection.generateUniqueToken(); // Generate a secure token
        personne.setFirstConnectionToken(token); // Set the token in the user record
        Date dateNow = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(dateNow);
        cal.add(Calendar.HOUR, 24);
        Date expiryDate = cal.getTime();
        // LocalDate oneMonthLater = LocalDate.now().plusMonths(1); // Add 1 month to
        // the current date
        // java.sql.Date expiryDate = java.sql.Date.valueOf(oneMinuteLater); // Convert
        // to java.sql.Date
        personne.setFirstConnectionTokenExpiry(expiryDate);
        personneRepository.save(personne);
    }

    /**
     * Gestion de la route permettant d'envoyer un mail pour réinitialiser un
     * mot de passe
     *
     * @param request La requête http
     * @return La page d'accueil admin avec un pop up
     */
    /*
     * @RequestMapping(value = "", method = RequestMethod.POST)
     * public ModelAndView EnvoiReset(HttpServletRequest request){
     * return envoyerMessageReset(request,MSGRESET);
     * }
     */
}
