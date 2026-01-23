<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="fr-fr">
  <head>
    <title>FORMULAIRE_VE</title>
    <meta charset="UTF-8"/>
    <link href="bootstrap/css/bootstrap.css"type="text/css"rel="stylesheet"/>
    <link href="css/default.css"type="text/css"rel="stylesheet"/>
    <link href="css/formulaire.css"type="text/css"rel="stylesheet"/>
    <link href="css/header.css" type="text/css" rel="stylesheet"/>
    <script src="js/formulaire.js"></script>
  </head>

  <body>
    <jsp:include page="/WEB-INF/views/header.jsp"/> 
    <div id="main">
      <div id="liste">
        <div class="py-3">
          <div class="container">
            <div class="row">
              <div class="col-md-12">
                <h2 class="">Formulaire
                  <form method="post" action="formulaireVe.do" style="position:absolute;right:20px;top:0px">
                    <input type="hidden" name="connexionId" value="${connexionId}" />
                    <input type="hidden" name="id" value="${item.formulaireId}" />
                    <input type="hidden" name="personneId" value="${item.personneId.personneId}" />
                    <input type="hidden" name="formulaireId" value="${item.formulaireId}" />
                    <button class="btn">Refresh</button>
                  </form>
                </h2>
              </div>
            </div>
            <div class="row">
              <div class="col-md-12">
                <div class="table-responsive">
                  <c:choose>
                    <c:when test="${item.estConforme}"><p style="color:red">Le formulaire à déjà été validé</p></c:when>
                    <c:when test="${(!item.estValide) && (! empty item.commentairesVe)}"><p style="color:blue">Le formulaire a été refusé mais peut être corrigé</p></c:when>
                  </c:choose>
                  <form id="formVe" method="post">
                    <script>
                      // Récupérer la valeur de formulaireId depuis le JSP
                      var formulaireId = "${item.formulaireId}";
                    </script>
                    <div class="table-responsive">
                      <table class="table table-striped">
                        <tbody>
                          <tr>
                            <th scope="col">Nom</th>
                            <td>
                              <input type="hidden" name="numSCEI" value="${item.numeroScei}"/>
                              <input type="text" id="nom" name="nom" value="${item.personneId.nom}" disabled="disabled" required="required"/>
                            </td>
                            <td>
                              <button type="button" id="locker_nom" class="btn btn-secondary" onclick="delock('nom')">
                                <img id="img_nom" src="img/close.png" class="avion" alt="submit"/>
                              </button>
                            </td>
                            </td>
                          </tr>
                          <tr>
                            <th scope="col">Prenom</th>
                            <td>
                              <input type="text" id="prenom" name="prenom" value="${item.personneId.prenom}" disabled="disabled" required="required"/>
                            </td>
                            <td>
                              <button type="button" id="locker_prenom" class="btn btn-secondary" onclick="delock('prenom')">
                                <img id="img_prenom" src="img/close.png" class="avion" alt="submit"/>
                              </button>
                            </td>
                          </tr>
                          <tr>
                            <th scope="col">Date de naissance (DD/MM/YYYY)</th>
                            <td> 
                              <input type="text" id="dateNaissance" name="dateDeNaissance" class="dateNaissance" value="<c:if test="${! empty item.dateDeNaissance}"><fmt:formatDate value='${item.dateDeNaissance}' pattern='dd/MM/yyyy'/></c:if>" disabled="disabled" required="required"/> 
                              </td>
                              <td>
                                <button type="button" id="locker_dateNaissance" class="btn btn-secondary" onclick="delock('dateNaissance')">
                                  <img id="img_dateNaissance" src="img/close.png" class="avion" alt="submit"/>
                                </button>
                              </td>
                            </tr>
                            <tr>
                              <th scope="col">Ville</th>
                              <td>
                                <input type="text" id="ville" name="ville" value="${item.ville}" disabled="disabled" required="required"/>
                            </td>
                            <td>
                              <button type="button" id="locker_ville" class="btn btn-secondary" onclick="delock('ville')">
                                <img id="img_ville" src="img/close.png" class="avion" alt="submit"/>
                              </button>                                                                
                            </td>
                          </tr>
                          <tr>
                            <th scope="col">Code Postal</th>
                            <td>
                              <input type="text" id="codePostal" name="codePostal" value="${item.codePostal}" disabled="disabled" />
                            </td>
                            <td>
                              <button type="button" id="locker_codePostal" class="btn btn-secondary" onclick="delock('codePostal')">
                                <img id="img_codePostal" src="img/close.png" class="avion" alt="submit"/>
                              </button>
                            </td>
                          </tr>
                          <tr>
                            <th scope="col" <c:if test="${(empty item.paysId) || (item.paysId.paysId != 1)}">style="background-color:orange"</c:if>>Pays</th>
                              <td>
                                <select id='pays' name="pays" disabled='disabled' required="required">
                                <c:forEach var="pays" items="${pays}">
                                  <option value=${pays.paysId} ${item.paysId.paysId == pays.paysId?'selected="selected"' : ''}>${pays.paysNom}</option>
                                </c:forEach>
                              </select>
                            </td>
                            <td>
                              <button type="button" id="locker_pays" class="btn btn-secondary" onclick="delock('pays')">
                                <img id="img_pays" src="img/close.png" class="avion" alt="submit"/>
                              </button>
                            </td>
                          </tr>
                          <tr>
                            <th scope="col">Adresse mail</th>
                            <td>
                              <input type="text" id="mail" name="mail" value="${item.mail}" placeholder="insérer votre mail" disabled="disabled" required="required"/>
                            </td>
                            <td>
                              <button type="button" id="locker_mail" class="btn btn-secondary" onclick="delock('mail')">
                                <img id="img_mail" src="img/close.png" class="avion" alt="submit"/>
                              </button>
                            </td>
                          </tr>
                          <tr>
                            <th scope="col" <c:if test="${(empty item.genreId) || (item.genreId.genreId > 2) || (item.genreId.genreId != item.genreAttendu.genreId)}">style="background-color:orange"</c:if>>Genre</th>   
                              <td>
                                <select id="Genre" name="Genre" disabled="disabled" required="required">
                                <c:if test="${(empty item.genreId) || (item.genreId.genreId <= 0)}"><option value=0 selected="selected">------------------------------------------------</option></c:if>
                                <c:forEach var="genre" items="${genresList}"><option value="${genre.genreId}" ${(! empty item.genreId) && (genre.genreId == item.genreId.genreId) ? 'selected="selected"' : ''} readonly="readonly">${genre.genreNom}</option>
                                </c:forEach>
                              </select>
                              <br/>
                              Initial : ${item.genreAttendu.genreNom}
                            </td>
                            <td>
                              <button type="button" id="locker_Genre" class="btn btn-secondary" onclick="delock('Genre')">
                                <img id="img_Genre" src="img/close.png" class="avion" alt="submit"/>
                              </button>
                            </td>
                          </tr>
                          <tr>
                            <th scope="col">Numéro de téléphone</th>
                            <td>
                              <input id="tel" type="text"name="tel" value="<c:if test="${! empty item.numeroTel}">${item.numeroTel}</c:if>" disabled="disabled" required="required" />
                              </td>
                              <td>
                                <button type="button" id="locker_tel" class="btn btn-secondary" onclick="delock('tel')">
                                  <img id="img_tel" src="img/close.png" class="avion" alt="submit"/>
                                </button>
                              </td>
                            </tr>
                            <tr>
                              <th scope="col"
                              <c:choose>
                                <c:when test="${(! empty item.estBoursier) && ((item.estBoursier) && (! item.hasBourseFile()))}">style="background-color:red"</c:when>
                                <c:when test="${(! empty item.estBoursier) && (item.estBoursier)}">style="background-color:orange"</c:when>
                              </c:choose>>Êtes-vous boursier ?</th>
                            <td>
                              <select name="boursier" id="boursier" disabled="disabled" required="required">
                                <c:if test="${(empty item.estBoursier)}"><option value="null" ${empty item.estBoursier ? 'selected="selected"' : ''}>---</option></c:if>
                                <option value="true" ${item.estBoursier == 'true' ? 'selected="selected"' : ''}>Oui</option>
                                <option value="false" ${item.estBoursier == 'false' ? 'selected="selected"' : ''}>Non</option>                                                       
                              </select>
                              <c:choose>
                                <c:when test="${item.estBoursier && (! item.hasBourseFile())}">
                                  <button type="submit" class="btn btn-danger" disabled="disabled">
                                    Preuve manquante
                                  </button>
                                </c:when>
                                <c:when test="${item.estBoursier}">
                                  <button formaction="telechargerBourse.do" type="submit" id="telechargement" class="btn btn-primary">
                                    télécharger preuve <img id="img_tel" src="img/export.png" class="icon" alt="download proof"/>
                                  </button>
                                </c:when>
                              </c:choose>
                            </td>
                            <td>
                              <button type="button" id="locker_boursier" class="btn btn-secondary" onclick="delock('boursier')">
                                <img id="img_boursier" src="img/close.png" class="avion" alt="submit"/>
                              </button>
                            </td>   
                          </tr> 
                          <tr>
                            <th scope="col">Préférence logement</th>
                            <td>
                              <select id="souhait" name="Souhait"<c:if test="${item.estValide}"> disabled="disabled"</c:if> required="required">
                                <option value=0 ${(empty item.souhaitId) || (item.souhaitId.souhaitId <=0) ? 'selected="selected"' : ''} readonly="readonly">------------------------------------------------</option>
                                <c:forEach var="souhait" items="${souhaitsList}"><option value="${souhait.souhaitId}" ${(! empty item.souhaitId) && (souhait.souhaitId == item.souhaitId.souhaitId) ? 'selected="selected"' : ''} readonly="readonly">${souhait.souhaitType}</option>
                                </c:forEach>
                              </select> 
                            </td>
                            <td>
                              <button type="button" id="locker_souhait" class="btn btn-secondary" onclick="delock('souhait')">
                                <img id="img_souhait" src="img/close.png" class="avion" alt="submit"/>
                              </button>
                            </td>
                          </tr>
                          <tr>
                            <th scope="col">Avez-vous besoin de dispositions particulières<br/>(pmr, traitement médical...) ?</th>
                            <td>
                              <select name="pmr" id="pmr" disabled="disabled" required="required">
                                <c:if test="${empty item.estPmr}"><option value="null" selected="selected">---</option></c:if>
                                <option value="true" ${item.estPmr == 'true' ? 'selected="selected"' : ''}>Oui</option>
                                <option value="false" ${item.estPmr == 'false' ? 'selected="selected"' : ''}>Non</option>                                                       
                              </select>
                            </td>
                            <td>
                              <button type="button" id="locker_pmr" class="btn btn-secondary" onclick="delock('pmr')">
                                <img id="img_pmr" src="img/close.png" class="avion" alt="submit"/>
                              </button>
                            </td>
                          <tr>
                            <th scope="col" style="color:blue">Commentaire Eleve</th>
                            <td class="infoSupplementaires" name="infoSupplementaires" style="color:blue">${item.commentairesEleve}</td>
                            <td></td>
                          </tr>
                          <tr>
                            <th scope="col" style="color:red">Commentaire Mission Logement<br/>(obligatoire en cas de refus)<br/>(sera transmis à l'étudiant en cas de refus du dossier)</th>
                            <td> 
                              <textarea class="commentairesVe" cols="40" rows="5" name="commentairesVe" id="commentairesVe" disabled="disabled" >${item.commentairesVe}</textarea> 
                            </td>
                            <td>
                              <button type="button" id="locker_commentairesVe" class="btn btn-secondary" onclick="delock('commentairesVe')">
                                <img id="img_commentairesVe" src="img/close.png" class="avion" alt="submit"/>
                              </button>
                            </td>
                          </tr>
                        </tbody>
                      </table>
                    </div>  
                    <div class="container mt-4 mb-4 text-center">
                      <div class="row justify-content-center">
                        <div class="col-md-10">
                          <input type="hidden" name="id" value="${item.formulaireId}" />
                          <input type="hidden" name="personneId" value="${item.personneId.personneId}" />
                          <input type="hidden" name="connexionId" value="${connexionId}" />
                          <c:choose>
                            <c:when test="${item.estConforme}">
                              <p>Le formulaire à déjà été validé</p>
                              <c:if test="${(! empty connexion) && (connexion.isAdmin())}">
                                <button onclick="openForm('formVe')" 
                                        formaction="EnregistrerFormVe.do" type="submit" name="enregistrer" class="btn btn-primary mr-3" value="enregistrer" >
                                  Forcer la sauvegarde <img src="img/save.png" class="icon" alt="save"/>
                                </button>
                              </c:if>
                            </c:when>
                            <c:otherwise>
                              <button onclick="openForm('formVe')" 
                                      formaction="AnnulerPwd.do" type="submit" name="annulerpwd" class="btn btn-info" value="annulerpwd" <c:if test="${empty item.personneId.password}">disabled="disabled"</c:if>>
                                        Reinitialiser Mot de Passe <img src="img/refuse.png" class="icon" alt="Reinitialiser"/>
                              </button>

                              <button onclick="openForm('formVe')" 
                                      formaction="EnregistrerFormVe.do" type="submit" name="enregistrer" class="btn btn-primary mr-3" value="enregistrer" >
                                Sauvegarder <img src="img/save.png" class="icon" alt="save"/>
                              </button>

                              <button onclick="openForm('formVe')" 
                                      formaction="ValiderFormVe.do" type="submit" name="valider" class="btn btn-success mr-3" value="valider">
                                Valider <img src="img/coche.png" class="icon" alt="Valider"/>
                              </button>

                              <button onclick="messageCommVide('formVe')" 
                                      formaction="RefuserFormVe.do" type="submit" name="refuser" class="btn btn-danger" value="refuser" <c:if test="${(! item.estconforme) || (empty item.commentairesVe)}">disabled="disabled"</c:if>>
                                        Refuser <img src="img/refuse.png" class="icon" alt="Refuser"/>
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