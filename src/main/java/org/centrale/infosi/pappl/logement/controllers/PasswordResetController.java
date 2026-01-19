/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package org.centrale.infosi.pappl.logement.controllers;

import org.centrale.infosi.pappl.logement.util.PasswordUtils;
import java.util.Iterator;
import java.util.Optional;
import jakarta.servlet.http.HttpServletRequest;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import org.centrale.infosi.pappl.logement.items.Formulaire;
import org.centrale.infosi.pappl.logement.items.Personne;
import org.centrale.infosi.pappl.logement.repositories.FormulaireRepository;
import org.centrale.infosi.pappl.logement.repositories.PersonneRepository;
import org.centrale.infosi.pappl.logement.util.Util;
import org.centrale.infosi.pappl.logement.controllers.MailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 *Co ntroller permettant de réinitialiser son login et mot de passe
 * En stand-by car pas de possibilité d'envoyer de mails
 * @author samer

 */
@Controller
public class PasswordResetController {
    
    @Autowired
    @Lazy
    private FormulaireRepository formulaireRepository;

    @Autowired
    @Lazy
    private PersonneRepository personRepository;
    
    @Autowired
    @Lazy
    private MailService mailService;
    
    /**
     * Permet d'afficher la page de réinitialisation d'un mot de passe
     * @return Le nom de la page de réinitialisation
     */
    @GetMapping("passwordreset.do")
    public String showPasswordResetPage() {
        return "passwordreset"; // This should match the JSP or HTML file name
    }

    
    /**
     * Gestion de la route permettant d'afficher la page de réinitialisation de soumission d'une adresse mail
     * @param request La requête http
     * @return La page de connexion
     */
    @RequestMapping(value = "submitpasswordreset.do", method = RequestMethod.POST)
    public ModelAndView handlePasswordReset(HttpServletRequest request) {

        ModelAndView returned = new ModelAndView("index");

        String mail = Util.getStringFromRequest(request, "mail");
        String scei = Util.getStringFromRequest(request, "scei");

        Optional<Formulaire> formulaireOpt = formulaireRepository.findBySceiAndMail(scei, mail);

        if (formulaireOpt.isEmpty()) {
            returned.addObject("errorMessage", scei+" "+mail);
            return returned;
        }

        Personne personneReset = formulaireOpt.get().getPersonneId();

        // Générer token + expiration
        String resetToken = PasswordUtils.generateToken();
        Date now = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(now);
        cal.add(Calendar.HOUR, 24);

        Date expiry = cal.getTime();

        // Stocker token + expiration
        personneReset.setFirstConnectionToken(resetToken);
        personneReset.setFirstConnectionTokenExpiry(expiry);
        personRepository.save(personneReset);

        // Envoyer le mail
        mailService.sendPasswordResetMail(resetToken,mail);

        returned.addObject("successMessage","Un e-mail de réinitialisation vous a été envoyé.");

        return returned;
    }

    
    
    /**
     * Gestion de la réinitialisation du mot de passe (doit être modif)
     * @param request La requête http
     * @return La vue de changement du mot de passe
     */
    @RequestMapping(value="passwordresetlink.do", method=RequestMethod.GET)
    public ModelAndView handleSetNewPassword(HttpServletRequest request){
        ModelAndView returned = null;
        String token = Util.getStringFromRequest(request, "token");
        //vérification du token
        if(verifyToken(token)){
            returned=new ModelAndView("setnewpassword");
            returned.addObject("token",token);
        }
        return returned;   
    }
    
    /**
     * Gestion de la route permettant d'afficher la page de modification son mot de passe 
     * @param request La requête http
     * @return La page de changement de mot de passe
     */
    
    @RequestMapping(value="submitnewpassword.do", method=RequestMethod.POST)
    public ModelAndView handleSubmitNewPassword(HttpServletRequest request) {
        String token = Util.getStringFromRequest(request, "token");
        String newPassword = Util.getStringFromRequest(request, "password");

        Optional<Personne> result = personRepository.findByFirstConnectionToken(token);

        if (result.isPresent()) {
            Personne personne = result.get();

            // Ensure the login is not null
            if (personne.getLogin() != null) {
                personne.setPassword(PasswordUtils.hashPassword(newPassword));
                personRepository.save(personne);
                deleteToken(personne);
                return new ModelAndView("index.do"); 
            }
        }

        // If token is invalid or login is null, show an error message
        ModelAndView returned = new ModelAndView("setnewpassword");
        returned.addObject("errorMessage", "Lien invalide ou expiré.");
        return returned;
    }

    private boolean verifyToken(String token) {
        Optional<Personne> result = personRepository.findByFirstConnectionToken(token);
    
        return result.isPresent(); //&& result.get().getLogin() != null;
    }
    
    private Personne changeLoginAndPassword (Personne personne, String login,String password){
        Personne result=personRepository.update(personne,login,PasswordUtils.hashPassword(password));
        return result;
    }
    
    private void deletePassword(Personne personne){
       personRepository.setPasswordToNull(personne.getPersonneId());
    }
    
    private void deleteToken(Personne personne){
       personRepository.setFirstConnectionTokenToNull(personne.getPersonneId());
    }

}

