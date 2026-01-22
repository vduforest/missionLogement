/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package org.centrale.infosi.pappl.logement.controllers;

import org.centrale.infosi.pappl.logement.util.PasswordUtils;
import jakarta.servlet.http.HttpServletRequest;
import org.centrale.infosi.pappl.logement.items.Formulaire;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import org.centrale.infosi.pappl.logement.items.Personne;
import org.centrale.infosi.pappl.logement.repositories.ConfigModifRepository;
import org.centrale.infosi.pappl.logement.repositories.FormulaireRepository;
import org.centrale.infosi.pappl.logement.repositories.PersonneRepository;
import org.centrale.infosi.pappl.logement.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * Controller permettant de gérer la page de première connexion (à modifier avec
 * le mail) (vérification du token/mail et création du login/mdp)
 *
 * @author samer
 */
@Controller
public class FirstConnectionController {

    @Autowired
    @Lazy
    private FormulaireRepository formulaireRepository;

    @Autowired
    @Lazy
    private PersonneRepository personneRepository;

    @Autowired
    @Lazy
    private ConfigModifRepository configModifRepository;

    private ModelAndView invalidAccountCreation(String scei,String mail) {
        ModelAndView returned = new ModelAndView("premier_connexion");
        returned.addObject("error", true);
        returned.addObject("mySCEI",scei);
        returned.addObject("mail", mail);
        //returned.addObject("token",token);
        return returned;
    }

    /**
     * Méthode permettant de traiter la route "firstConnection.do"
     *
     * @param request La requête contenant le token d'authentification et l'état
     * d'erreur de login/mdp/numéro SCEI
     * @return La page de première connexion si le token existe, une erreur 404
     * sinon
     */
    @RequestMapping(value = "creationcompte.do", method = RequestMethod.GET)
    public ModelAndView handleCreationCompte(HttpServletRequest request) {
        ModelAndView returned = new ModelAndView("index"); //erreur 404
        String token = request.getParameter("token");
        //vérification du token cad que si le token est expiré alors on envoie une page d'erreur
        if(verifyToken(token)==1){
            // Si le  token existe, il faut récupérer le numéro SCEI de la personne et son mail et préremplir la page
            String mail = formulaireRepository.findMailByToken(token).get(0);
            String numSCEI = formulaireRepository.findSCEIByToken(token).get(0);
            
            returned = new ModelAndView("premier_connexion");
            returned.addObject("mySCEI",numSCEI);  
            returned.addObject("mail",mail);
            returned.addObject("error", false);    
            //returned.addObject("token",token);
        } else if(verifyToken(token)==0){
            // Si le token n'existe pas ou est expiré, alors on supprime le token de la base et on envoie une page demandant à l'élève d'aller faire mot de passe oublié
            returned = new ModelAndView("tokenExpiry");
        } else{
            returned = new ModelAndView("index");
        }
        return returned;
    }
    
    /**
     * Méthode permettant de vérifier si un token existe et qu'il n'est pas expiré
     *
     * @param token token à vérifier
     * @return true si le token est valide, false sinon
     */
    private int verifyToken(String token) {
        Optional<Personne> result = personneRepository.findByFirstConnectionToken(token);
        
        // Test de l'existence de la personne
        if (result.isPresent()){
            
            Date expiry = (Date) result.get().getFirstConnectionTokenExpiry();
            // Test de l'expiration du token
            Date now = new Date();
            if (expiry.before(now)){
                return 0;
            }
            return 1;
        }
        
        return 2;
    }

    /**
     * Gestion de la route envoyant vers la page de première connexion vérifiant
     * les mails
     *
     * @param request La requête http
     * @return La page de première connexion vérifiant le mail
     */
    @RequestMapping(value = "verificationmail.do", method = RequestMethod.GET)
    public ModelAndView handleFirstConnexionPage(HttpServletRequest request) {
        ModelAndView returned = new ModelAndView("1er_connexion");
        return returned;
    }

    /**
     * Gestion de la route de vérification du mail et de la page d'inscription
     *
     * @param request La requête
     * @return La page de refus si le mail est invalide, la page de changement
     * de login s'il est valide
     */
    @RequestMapping(value = "verificationdumail.do", method = RequestMethod.GET)
    public ModelAndView handleVerificationduMail(HttpServletRequest request) {
        ModelAndView returned;

        String referer = request.getHeader("Referer");
        // Pour que l'on puisse y arriver seulement depuis first_connexion.jsp 
        System.out.println("Referer: " + referer);  // Pour voir la valeur dans la console
        // Vérifie que la requête vient bien de la page du formulaire
        if (referer == null || !referer.contains("verificationmail.do")) {
            return new ModelAndView("Pasledroit");  // Redirige ailleurs si l'accès est direct
        }

        String mail = Util.getStringFromRequest(request, "mail");
        List<Formulaire> cherche = new ArrayList<Formulaire>(formulaireRepository.findByMail(mail));
        Collections.sort(cherche, Formulaire.getComparator());

        if (!cherche.isEmpty()) {
            returned = new ModelAndView("premier_connexion");
            returned.addObject("mail", mail);
        } else {
            returned = new ModelAndView("mail_inconnue");
        }
        return returned;
    }

    /**
     * Méthode permettant de traiter la route saveUser.do
     *
     * @param request La requête contenant le login et mot de passe voulus, un
     * mot de passe de vérification, le numéro SCEI et le token
     * @return La page de première connexion si erreur, la page de connexion
     * générale sinon
     */
    @RequestMapping(value = "saveUser.do", method = RequestMethod.POST)
    public ModelAndView handleSaveUserPost(HttpServletRequest request) {
        ModelAndView returned;

        //Paramètres de la requête
        String Scei = Util.getStringFromRequest(request, "myScei");
        String mail = Util.getStringFromRequest(request, "mail").trim();

        String login = Util.getStringFromRequest(request, "myLogin");
        String password = Util.getStringFromRequest(request, "myPassword");
        String verifyPassword = Util.getStringFromRequest(request, "confMyPassword");
        String token=request.getParameter("token");

        // Check passwords are equal
        if ((password.isEmpty()) || (!password.equals(verifyPassword))) {
            // Given password is not the same as verifyPassword
            return invalidAccountCreation(Scei,mail);
        }

        // Check SCEI number and token
        Optional<Formulaire> students = formulaireRepository.findBySceiAndMail(Scei,mail);
        if (!students.isPresent()) {
            // No valid SCEI number ot given password is not the same as verifyPassword
            return invalidAccountCreation(Scei,mail);
        }

        Formulaire formulaire = students.get();
        Personne personne = formulaire.getPersonneId();
        personne = personneRepository.getReferenceById(personne.getPersonneId());


        
        
        // Check mail is the given one
        if ((formulaire.getMail() != null) && (!formulaire.getMail().equalsIgnoreCase(mail))) {
            return invalidAccountCreation(Scei,mail);
        }

        Collection<Personne> personneLogin = personneRepository.findByLogin(login);
        if (! personneLogin.isEmpty()) {
            // Login already used
            Personne altPerson = personneLogin.iterator().next();
            if (!personne.equals(altPerson)) {
                // Not by this person
                return invalidAccountCreation(Scei,mail);
            }
        }
        
        if ((personne.getLogin() != null) && (! personne.getLogin().equals(login))) {
            // Login already defined but not this one
            return invalidAccountCreation(Scei,mail);
        }

        // OK, set Login / Password
        personneRepository.update(personne, login, PasswordUtils.hashPassword(password));
        personneRepository.resetToken(personne);
        returned = new ModelAndView("redirect");
        return returned;
    }

    /**
     * Gestion de la route permettant de générer les tokens de premières
     * connexion
     *
     * @param request
     * @return La page d'accueil de l'admin après création des tokens
     */
    @RequestMapping(value = "generatetokens.do")
    public ModelAndView generateTokensForAllUsers(HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView("accueil_admin");
        String connexionId = request.getParameter("connexionId");
        
        try {
            Collection<Personne> personnes = personneRepository.findAll(); // Fetch all users
            for (Personne personne : personnes) {
                // Only generate token for users with role_id = 1 and no token set
                if (personne.getRoleId().getRoleId() == 1 && personne.getFirstConnectionToken() == null) {
                    String token = generateUniqueToken(); // Generate a secure token
                    personne.setFirstConnectionToken(token); // Set the token in the user record
                    Date dateNow = new Date();
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(dateNow);
                    cal.add(Calendar.HOUR, 24);
                    Date expiryDate = cal.getTime();
                    // LocalDate oneMonthLater = LocalDate.now().plusMonths(1);  // Add 1 month to the current date
                    // java.sql.Date expiryDate = java.sql.Date.valueOf(oneMinuteLater);  // Convert to java.sql.Date
                    personne.setFirstConnectionTokenExpiry(expiryDate);

                    personneRepository.save(personne); // Save the updated user entity

                }
            }

            modelAndView.addObject("confirmationMessage", "Tokens generated and emails sent to all users.");
            modelAndView.addObject("connexionId",connexionId);
        } catch (Exception e) {
            modelAndView.addObject("confirmationMessage", "An error occurred while generating tokens.");
            modelAndView.addObject("connexionId",connexionId);
        }

        return modelAndView;
    }

    private String generateUniqueToken() {
        String token;
        boolean isTokenUnique = false;

        do {
            token = PasswordUtils.generateToken(); // Generate a secure token
            isTokenUnique = !personneRepository.existsByFirstConnectionToken(token); // Check if the token already exists in the database
            System.out.println(!personneRepository.existsByFirstConnectionToken(token));
        } while (!isTokenUnique); // If the token already exists, generate a new one

        return token;
    }
    
    
}
