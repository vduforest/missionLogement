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
     * @param request     La requête http
     * @param messageType le type de message à envoyer
     * @return La page d'accueil admin avec un pop up
     */
    private ModelAndView envoyerMessage(HttpServletRequest request, int messageType) {
        ModelAndView returned;
        Connexion connection = connectionService.checkAccess(request, "Admin");
        if (connection != null) {

            // Il faut créer une liste avec l'adress mail de tous les utilisateurs.
            Optional<ConfigModif> contenuMsg = configmodifrepository.getLastTypeId(messageType);
            Optional<ConfigModif> envoyeurMsg = configmodifrepository.getLastTypeId(MailConstants.MAILCONTACT);
            if ((contenuMsg.isPresent()) && (envoyeurMsg.isPresent())) {
                ConfigModif messageToSend = contenuMsg.get();
                ConfigModif envoyeur = envoyeurMsg.get();
                switch (messageType) {
                    case MailConstants.MSGPREMIERCONTACT:
                        List<String> tousLesTokens = personneRepository.findAllTokenVague();
                        Collection<String> tousLesMails = formulaireRepository.findAllEmailsVague();
                        int compteur = 0;
                        for (String email : tousLesMails) {
                            mailService.sendFirstConnectionMail(tousLesTokens.get(compteur), email);
                            compteur++;
                        }
                        formulaireRepository.updateVague();

                        // Renvoie sur la page accueil_admin avec un message pop_up
                        List<Alerte> alertes = new ArrayList<Alerte>(alerteRepository.findAll());
                        Collections.sort(alertes, Alerte.getComparator());

                        returned = connectionService.prepareModelAndView(connection, "accueil_admin");

                        returned.addObject("Alertes", alertes);
                        if (tousLesMails.isEmpty()) {
                            returned.addObject("confirmationMessage", "Aucun mail à envoyer");
                        } else {
                            returned.addObject("confirmationMessage", "Emails envoyés avec succès ! ");
                        }
                        break;
                    case MailConstants.MSGRESET:
                        returned = connectionService.prepareModelAndView(connection, "accueil_admin");
                        /* on reçoit l'id du formulaire et de la personne */
                        Integer id = Integer.parseInt(request.getParameter("id"));
                        Integer personneId = Integer.parseInt(request.getParameter("personneId"));
                        System.out.println("début");
                        Optional<Formulaire> formulaires = formulaireRepository.findById(id);
                        Optional<Personne> perso = personneRepository.findById(personneId);
                        System.out.println("début2");

                        if (perso.isPresent() && formulaires.isPresent()) {
                            Personne personne = perso.get();
                            Formulaire formulaire = formulaires.get();

                            String token = personne.getFirstConnectionToken();
                            System.out.println(token + personne);
                            /*
                             * if ((token == null) || (firstConnection.verifyToken(token) == 0)) {
                             * genererToken(personne);
                             * throw new IllegalArgumentException("Token manquant");
                             * }
                             */

                            /**
                             * vérifier le token
                             */

                            /* le token est expire */
                            genererToken(personne);
                            /* on met à jour le token transmis */
                            token = personne.getFirstConnectionToken();
                            System.out.println("a passer la condition");
                            String recipient = formulaire.getMail();
                            mailService.sendPasswordResetMail(token, recipient);
                        }
                        break;
                    default:
                        returned = new ModelAndView("index");
                        break;
                }
                return returned;
            }
        }
        return new ModelAndView("redirect");
    }

    /**
     * Gestion de la route permettant d'envoyer les mails de premier connexion
     *
     * @param request La requête http
     * @return La page d'accueil admin avec un pop up
     */
    @RequestMapping(value = "envoiemail.do", method = RequestMethod.POST)
    public ModelAndView Envoi(HttpServletRequest request) {
        return envoyerMessage(request, MailConstants.MSGPREMIERCONTACT);
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
     */
    @RequestMapping(value = "envoiemailfin.do", method = RequestMethod.POST)
    public ModelAndView EnvoiFin(HttpServletRequest request) {
        return envoyerMessage(request, MailConstants.MSGPFIN);
    }

    /**
     * Gestion de la route permettant d'envoyer les mails de reset perso
     *
     * @param request La requête http
     * @return La page d'accueil admin avec un pop up
     */
    @RequestMapping(value = "envoiemailresetperso.do", method = RequestMethod.POST)
    public ModelAndView EnvoiReset(HttpServletRequest request) {
        return envoyerMessage(request, MailConstants.MSGRESET);
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
