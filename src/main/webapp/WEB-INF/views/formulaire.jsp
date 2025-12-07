<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="fr-fr">
  <head>
    <title>FORMULAIRE</title>
    <meta charset="UTF-8"/>
    <link href="bootstrap/css/bootstrap.css"type="text/css"rel="stylesheet"/>
    <link href="css/default.css"type="text/css"rel="stylesheet"/>
    <link href="css/formulaire.css"type="text/css"rel="stylesheet"/>
    <script src="js/formulaire.js"></script>
  </head>

  <body>
    <div id="header">
      <nav class="navbar navbar-expand-md navbar-dark bg-dark">
        <div class="container">
          <div class="collapse navbar-collapse"id="navbar1">
            <form method="POST">
              <input type="hidden" name="connexionId" value="${connexionId}" />
              <ul class="navbar-nav ml-auto">
                <li class="nav-item"><button class="btn nav-link text-white" formaction="studentDashboard.do"><img src="img/logocn.png" alt="logo" class="logo"/></button></li>
                <li><h1>Plateforme Mission Logement</h1></li>
                <li class="nav-item"><button class="btn nav-link text-white" formaction="index.do"><img src="img/porteOuverte.png" alt="sortie" class="sortie"/></button></li>
              </ul>

            </form>
          </div>
        </div>
      </nav>
    </div> 

    <div id="main">
      <div id="liste">
        <div class="py-3">
          <div class="container">
            <div class="row">
              <div class="col-md-12">
                <h2 class="">Formulaire de demande de logement à la résidence</h2>
              </div>
            </div>
          <div class="row">
            <div class="col-md-12">
              <div class="table-responsive">
                <table class="table table-striped">
                  <thead>
                  <form method="POST">
                    <input type="hidden" name="connexionId" value="${connexionId}" />
                    <tr>
                      <th scope="col"class="text-center"><button class="redirect" formaction="informations.do">Informations Standard</button></th>
                      <th scope="col"class="text-center"><button class="btn redirect" formaction="formulaire.do" disabled="disabled">Formulaire</button></th>
                    </tr>
                  </form>
                  </thead>
                </table>
              </div>
            </div>
          </div>
            <div class="row">
              <div class="col-md-12">
                <div class="table-responsive">
                  <form action="SauvegardeFormulaire.do" method="POST" enctype="multipart/form-data">
                    <input type="hidden" name="connexionId" value="${connexionId}" />
                    <input type="hidden" name="id" value="${item.formulaireId}" />
                    <c:if test="${item.estValide == true}">
                      <p class="text-primary"><b>Le formulaire a déjà été soumis, il ne peut plus être modifié</b>.<br/>
                      La Mission Logement vous contactera pour la suite.</p>
                    </c:if>
                    <div class="table-responsive">
                      <table class="table table-striped">
                        <tbody>
                          <tr>
                            <c:if test="${(! empty item.commentairesVe) && (! item.estValide)}">
                              <th style="color:red"> Votre dossier doit être complété.<br/>précisions :</th>
                              <td><p style="color:red">${item.commentairesVe}</p></td>
                              </c:if>
                          </tr>
                          <tr>
                            <th scope="col">Nom</th>
                            <td onclick="message()">${item.personneId.nom}<input type="hidden" name="nom" value="${item.personneId.nom}" /></td>
                          </tr>
                          <tr>
                            <th scope="col">Prenom</th>
                            <td onclick="message()">${item.personneId.prenom}<input type="hidden" name="prenom" value="${item.personneId.prenom}" /></td>
                          </tr>
                          <tr>
                            <th scope="col">Date de naissance</th>
                            <td onclick="message()"><fmt:formatDate value="${item.dateDeNaissance}" pattern="dd/MM/yyyy"/><input type="hidden" name="dateDeNaissance" value="${item.dateDeNaissance}" /></td>
                          </tr>
                          <tr>
                            <th scope="col">Ville</th>
                            <td onclick="message()">${item.ville}<input type="hidden" name="ville" value="${item.ville}" /></td>
                          </tr>
                          <tr>
                            <th scope="col">Code Postal</th>
                            <td onclick="message()">${item.codePostal}<input type="hidden" name="codePostal" value="${item.codePostal}" /></td>
                          </tr>
                          <tr>
                            <th scope="col">Pays</th>
                            <td onclick="message()">${item.paysId.paysNom}<input type="hidden" name="pays" value="${item.paysId.paysId}" /></td>
                          </tr>
                          <tr>
                            <th scope="col">Adresse mail</th>
                            <td>
                              <input type="text" id="mail" name="mail" size="40" value="${item.mail}" placeholder="indiquez votre adresse mail" <c:if test="${item.estValide == true}">readonly="readonly"</c:if> required="required"/>
                              </td>
                            </tr>
                            <tr>
                              <th scope="col">Confirmation Adresse mail</th>
                              <td>
                                <input type="text" id="Confirmmail" name="Confirmmail" size="40" placeholder="confirmer votre adresse mail" value="${item.mail}" <c:choose><c:when test="${item.estValide == true}">readonly="readonly"</c:when><c:otherwise>onchange="verifMail('mail', 'Confirmmail');"</c:otherwise></c:choose> />
                                </td>
                              </tr>

                              <tr>
                                <th scope="col">Genre</th>   
                                <td>
                                    <select name="Genre"<c:if test="${item.estValide}"> disabled="disabled"</c:if> required="required">
                                <option value=0 ${(empty item.genreId) || (item.genreId.genreId <=0) ? 'selected="selected"' : ''} readonly="readonly">------------------------------------------------</option>
                                <c:forEach var="genre" items="${genresList}"><option value="${genre.genreId}" ${(! empty item.genreId) && (genre.genreId == item.genreId.genreId) ? 'selected="selected"' : ''} readonly="readonly">${genre.genreNom}</option>
                                </c:forEach>
                              </select>                                                                                                     
                            </td>
                          </tr>
                          <tr>
                            <th scope="col">Numéro de téléphone</th>
                            <td>
                              <input type="text" name="tel" value="<c:if test="${not empty item.numeroTel}">${item.numeroTel}</c:if>" size="15" <c:if test="${item.estValide == true}">readonly="readonly"</c:if> required="required"/>
                              </td>
                            </tr>
                            <tr>
                              <th scope="col">Êtes-vous boursier ? (si le dépôt de fichier n'apparait pas rappuyer sur oui, vérifiez bien que le fichier est présent lors de la validation du formulaire)</th>
                              <td>
                              <c:choose>
                                <c:when test="${item.estValide == true}">
                                  <input onload="sendDocument()" onclick="sendDocument()" type="radio" name="bourse" id="ouiB" value="true" ${item.estBoursier == 'true' ? 'checked="checked"' : ''} disabled="disabled" required="required"/>
                                  <label for="ouiB">Oui</label>

                                  <br/><input onload="sendDocument()" onclick="sendDocument()" type="radio" name="bourse" id="nonB" value="false" ${item.estBoursier == 'false' ? 'checked="checked"' : ''} disabled="disabled" required="required"/>
                                  <label for="nonB">Non</label>
                                </c:when>     
                                <c:otherwise>
                                  <input onload="sendDocument()" onclick="sendDocument()" type="radio" name="bourse" id="ouib" value="true" ${item.estBoursier == 'true' ? 'checked="checked"' : ''} required="required"/>
                                  <label for="ouib">Oui</label>

                                  <br/><input onload="sendDocument()" onclick="sendDocument()" type="radio" name="bourse" id="nonb" value="false" ${item.estBoursier == 'false' ? 'checked="checked"' : ''} required="required"/>
                                  <label for="nonb">Non</label>
                                </c:otherwise>
                              </c:choose>
                              <p>
                                <c:if test="${(item.estBoursier) && (item.hasBourseFile())}">Fichier bourse transmis<br/></c:if>
                                  <input type="file" id="preuveBourse" name="preuveBourse" class="preuveBourse" accept="image/png,application/pdf" style="display: none;"/>
                                </p>
                              </td>   
                            </tr>

                            <tr>
                              <th scope="col" <c:if test="${(! empty error) && (error)}">class="bg-danger"</c:if>>Préférence logement (Pensez à consulter la rubrique « Questions posées fréquemment »  sur la page https://www.ec-nantes.fr/campus/nantes/vivre-a-la-rez)</th>
                              <td>
                                <select name="Souhait"<c:if test="${item.estValide}"> disabled="disabled"</c:if> required="required">
                                <option value=0 ${(empty item.souhaitId) || (item.souhaitId.souhaitId <=0) ? 'selected="selected"' : ''} readonly="readonly">------------------------------------------------</option>
                                <c:forEach var="souhait" items="${souhaitsList}"><option value="${souhait.souhaitId}" ${(! empty item.souhaitId) && (souhait.souhaitId == item.souhaitId.souhaitId) ? 'selected="selected"' : ''} readonly="readonly">${souhait.souhaitType}</option>
                                </c:forEach>
                              </select> 
                            </td>
                          </tr>

                          <tr>
                            <th scope="col">Avez-vous besoin de dispositions particulières<br/>(handicap, PMR...) ?</th>
                            <td>
                              <c:choose>
                                <c:when test="${item.estValide == true}">
                                  <input type="radio" name="pmr" id="ouip" value="true" ${item.estPmr == 'true' ? 'checked="checked"' : ''} disabled="disabled" required="required" onclick="document.getElementById('infoSupplementaires').setAttribute('required', 'required');return true;"/>
                                  <label for="ouip">Oui</label>
                                  <br/><input type="radio" name="pmr" id="nonp" value="false" ${item.estPmr == 'false' ? 'checked="checked"' : ''} disabled="disabled" required="required" onclick="document.getElementById('infoSupplementaires').removeAttribute('required');return true;"/>
                                  <label for="nonp">Non</label>
                                </c:when>     
                                <c:otherwise>
                                  <input type="radio" name="pmr" id="ouip" value="true" ${item.estPmr == 'true' ? 'checked="checked"' : ''} required="required" onclick="document.getElementById('infoSupplementaires').setAttribute('required', 'required');return true;"/>
                                  <label for="ouip">Oui</label>
                                  <br/><input type="radio" name="pmr" id="nonp" value="false" ${item.estPmr == 'false' ? 'checked="checked"' : ''} required="required" onclick="document.getElementById('infoSupplementaires').removeAttribute('required');return true;"/>
                                  <label for="nonp">Non</label>
                                </c:otherwise>
                              </c:choose>
                            </td>   
                          </tr>

                          <tr>
                            <th scope="col">Autre informations à transmettre (détails des dispositions à prendre, ajout d'un contact, remarques diverses...), pour envoyer des documents supplémentaires envoyer les par mail à mission.logement@ec-nantes.fr</th>
                            <td>                                                       
                              <textarea class="infoSupplementaires" id="infoSupplementaires" name="infoSupplementaires"<c:if test="${item.estValide}"> style="color:red" readonly="readonly"</c:if> <c:if test="${item.estPmr == 'true'}"> required="required"</c:if> cols="35" rows="5">${item.commentairesEleve}</textarea>
                              </td>
                            </tr>
                          </tbody> 
                        </table>
                      </div>  
                      <div class="container mt-4 mb-4 text-center">
                        <div class="row justify-content-center">
                          <div class="col-md-6">
                          <c:choose>
                            <c:when test="${item.estValide == true}">
                              <p class="text-primary">Le formulaire a déjà été soumis, il ne peut plus être modifié</p>
                            </c:when>
                            <c:otherwise>
                              <p>Attention : une fois soumis, vous ne pourrez plus modifier le formulaire</p>
                              <button type="submit" name="enregistrer" class="Enregistrer btn btn-primary mr-3" value="enregistrer" >
                                Sauvegarder <img src="img/save.png" class="icon" alt="save"/>
                              </button>
                              <button type="submit" name="soumettre" class="Confirmer btn btn-success" value="soumettre">
                                Sauvegarder et Soumettre <img src="img/avionPapier.png" class="avion" alt="submit"/>
                              </button>
                            </c:otherwise>
                          </c:choose>
                        </div>
                      </div>
                    </div>
                  </form> 
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <script>
      window.onload = function () {
        var message = "<%= request.getAttribute("confirmationMessage")%>";
        if (message && message.trim() !== "null") {
          alert(message);
        }
      };
    </script>
  </body>
</html>







