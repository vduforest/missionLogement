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
import java.util.Collections;
import java.util.List;
import java.util.Optional;

import org.centrale.infosi.pappl.logement.items.ConfigModif;
import org.centrale.infosi.pappl.logement.items.Connexion;
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

    private static final int MSGPREMIERCONTACT = 7;
    private static final int MSGPFIN = 9;
    private static final int MAILCONTACT = 8;

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
                    case MSGPREMIERCONTACT:
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
     * Gestion de l'envoi d'un mail lorsque un dossier est non conforme
     *
     * @param request La requête http
     */
    public void envoiMailDossierIncomplet(HttpServletRequest request) {
        // Récupération du mail à partir de la request
        String recipient = Util.getStringFromRequest(request, "mail");
        String comm = Util.getStringFromRequest(request, "commentairesVE");
        String prenom = Util.getStringFromRequest(request, "prenom");

        //Envoi au service - pas besoin de vérifier que le commentaire est vide, c'est sûr que c'est bon
        mailService.sendDossierIncompletMail(recipient, comm, prenom);
    }
    
    public void envoiMailDossierComplet(HttpServletRequest request){
        // Récupération du mail à partir de la request
        String recipient = Util.getStringFromRequest(request, "mail");
        String prenom = Util.getStringFromRequest(request, "prenom");
        
        mailService.sendDossierCompletMail(recipient,prenom);
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
     * @RequestMapping(value = "", method = RequestMethod.POST)
     * public ModelAndView EnvoiReset(HttpServletRequest request){
     * return envoyerMessageReset(request,MSGRESET);
     * }
     */
}
