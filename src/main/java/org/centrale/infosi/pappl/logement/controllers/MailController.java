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
import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import jakarta.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import javax.net.ssl.SSLContext;
import org.centrale.infosi.pappl.logement.items.ConfigModif;
import org.centrale.infosi.pappl.logement.items.Connexion;
import org.centrale.infosi.pappl.logement.items.Personne;
import org.centrale.infosi.pappl.logement.repositories.ConfigModifRepository;
import org.centrale.infosi.pappl.logement.repositories.FormulaireRepository;
import org.centrale.infosi.pappl.logement.repositories.PersonneRepository;
import org.centrale.infosi.pappl.logement.controllers.MailService;
import org.centrale.infosi.pappl.logement.controllers.FirstConnectionController;
import org.centrale.infosi.pappl.logement.items.Formulaire;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMethod;
import org.centrale.infosi.pappl.logement.util.CertificateManager;

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

    @Autowired
    private FirstConnectionController firstConnection;

    @Lazy
    @Autowired
    private ConfigModifRepository configmodifrepository;

    private static final int MSGPREMIERCONTACT = 7;
    private static final int MSGPFIN = 9;
    private static final int MAILCONTACT = 8;
    private static final int SIGNATURE = 10;
    private static final int NB = 11;
    private static final int MSGRESET = 12;

    /**
     * Méthode permettant d'envoyer un message de premier connexion à tous les
     * élèves selon la vague choisie
     *
     * @param request La requête http
     * @param messageType le type de message à envoyer
     * @return La page d'accueil admin avec un pop up
     */
    private ModelAndView envoyerMessage(HttpServletRequest request, int messageType) {
        ModelAndView returned;
        Connexion connection = connectionService.checkAccess(request, "Admin");
        if (connection != null) {

            // Il faut créer une liste avec l'adress mail de tous les utilisateurs.
            Optional<ConfigModif> contenuMsg = configmodifrepository.getLastTypeId(messageType);
            Optional<ConfigModif> envoyeurMsg = configmodifrepository.getLastTypeId(MAILCONTACT);
            if ((contenuMsg.isPresent()) && (envoyeurMsg.isPresent())) {
                ConfigModif messageToSend = contenuMsg.get();
                ConfigModif envoyeur = envoyeurMsg.get();
                switch (messageType) {
                    case 7:
                        List<String> tousLesTokens = personneRepository.findAllTokenVague();
                        Collection<String> tousLesMails = formulaireRepository.findAllEmailsVague();
                        int compteur = 0;
                        for (String email : tousLesMails) {
                            mailService.sendFirstConnectionMail(tousLesTokens.get(compteur), email);
                            compteur++;
                        }
                        formulaireRepository.updateVague();

                        //Renvoie sur la page accueil_admin avec un message pop_up
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
                    case 12:
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
                            if ((token == null) || (firstConnection.verifyToken(token) == 0)) {
                                genererToken(personne);
                                throw new IllegalArgumentException("Token manquant");
                            }

                            /**
                             * vérifier le token
                             */
                        
                            /* le token est expire */
                        genererToken(personne);

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
        return envoyerMessage(request, MSGPREMIERCONTACT);
    }

    /**
     * Gestion de la route permettant d'envoyer les mails de reset perso
     *
     * @param request La requête http
     * @return La page d'accueil admin avec un pop up
     */
    @RequestMapping(value = "envoiemailresetperso.do", method = RequestMethod.POST)
    public ModelAndView EnvoiReset(HttpServletRequest request) {
        return envoyerMessage(request, MSGRESET);
    }

    /**
     * Gestion de la route permettant d'envoyer les mails de reçu du formulaire
     *
     * @param request La requête http
     * @return La page d'accueil admin avec un pop up
     */
    @RequestMapping(value = "envoiemailfin.do", method = RequestMethod.POST)
    public ModelAndView EnvoiFin(HttpServletRequest request) {
        return envoyerMessage(request, MSGPFIN);
    }

    /**
     * Gestion de la route permettant d'envoyer un mail pour réinitialiser un
     * mot de passe
     *
     * @param request La requête http
     * @return La page d'accueil admin avec un pop up
     */
    /*
    @RequestMapping(value = "", method =  RequestMethod.POST)
    public ModelAndView EnvoiReset(HttpServletRequest request){
        return envoyerMessageReset(request,MSGRESET);
    }
     */
    /**
     * Méthode permettant d'envoyer des mails avec JavaMail
     *
     * @param token token de l'élève destinataire
     * @param recipient Adresse mail du destinataire
     * @param subject L'objet du mail
     * @param body Le contenu
     */
    public void sendEmail(String token, String recipient, String subject, String body) {

        final String mailExpediteur = "noreply@ec-nantes.fr";
        final String usernameSMTP = "raphael.delacote@eleves.ec-nantes.fr";
        final String passwordSMTP = "baEd7n3kjE5@Ma2";

        final String host = "smtps.nomade.ec-nantes.fr";

        String port = "587";

        // Configuration SMTP
        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", port);
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        // A quoi servent ces deux lignes là ? 
        properties.put("mail.smtp.socketFactory.port", port);
        properties.put("mail.smtp.socketFactory.fallback", "false");
        properties.put("mail.smtp.ssl.trust", "smtps.nomade.ec-nantes.fr");
        properties.put("mail.smtp.user", usernameSMTP);
        properties.put("mail.smtp.password", passwordSMTP);

        try {
            // Récupère le SSLContext permissif
            SSLContext sslContext = CertificateManager.getSSLContext();
            properties.put("mail.smtp.ssl.socketFactory", sslContext.getSocketFactory());
            properties.put("mail.smtp.ssl.checkserveridentity", "false");

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Création de la session avec authentification
        Authenticator authenticator = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(usernameSMTP, passwordSMTP);
            }
        };

        Session session = Session.getInstance(properties, authenticator);

        // Active le debug pour voir la communication SMTP
        session.setDebug(true);
        try {

            // Création du message email
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(usernameSMTP));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(recipient));

            // Emp$êche de répondre au mail
            message.setReplyTo(InternetAddress.parse("no-reply@invalid.local"));

            // Objet du mail
            message.setSubject(subject);
            message.setText(body);

            // Envoi du message
            Transport.send(message);

            //System.out.println("Email envoyé avec succès !");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Erreur lors de l'envoi de l'email.");
        }
    }

    public void genererToken(Personne personne) {
        String token = firstConnection.generateUniqueToken(); // Generate a secure token
        personne.setFirstConnectionToken(token); // Set the token in the user record
        Date dateNow = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(dateNow);
        cal.add(Calendar.HOUR, 24);
        Date expiryDate = cal.getTime();
        // LocalDate oneMonthLater = LocalDate.now().plusMonths(1);  // Add 1 month to the current date
        // java.sql.Date expiryDate = java.sql.Date.valueOf(oneMinuteLater);  // Convert to java.sql.Date
        personne.setFirstConnectionTokenExpiry(expiryDate);
        personneRepository.save(personne);
    }
}
