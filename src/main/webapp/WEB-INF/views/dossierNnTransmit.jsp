<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr-fr">
  <head>
    <title>Dossier_Non_Transmit</title>
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
                <h2 class="">Formulaire</h2>
              </div>
            </div>
            <div class="row">
              <div class="col-md-12">
                <div class="table-responsive">
                  <form method="post" id="formVe">
                    <script>
                      // Récupérer la valeur de formulaireId depuis le JSP
                      var formulaireId = "${form.formulaireId}";
                    </script>
                    <div class="table-responsive">
                      <table class="table table-striped">
                        <tbody>
                          <tr>
                            <th scope="col">Nom</th>
                            <td>
                              <input type="text" id="nom" name="nom" value="${form.personneId.nom}" disabled="disabled"/>
                            </td>
                            <td>
                              <button type="button" id="locker_nom" class="btn btn-secondary" onclick="delock('nom')">
                                <img id="img_nom" src="img/close.png" class="avion" alt="submit"/>
                              </button>
                            </td>
                          </tr>
                          <tr>
                            <th scope="col">Prenom</th>
                            <td>
                              <input type="text" id="prenom" name="prenom" value="${form.personneId.prenom}" disabled="disabled"/>
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
                              <input type="text" id="dateNaissance" name="dateDeNaissance" class="dateNaissance" value="<c:if test="${! empty date}"><fmt:formatDate value='${date}' pattern='dd/MM/yyyy'/></c:if>" disabled="disabled" /> 
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
                              <input type="text" id="ville" name="ville" value="${form.ville}" disabled="disabled"/>
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
                              <input type="text" id="codePostal" name="codePostal" value="${form.codePostal}" disabled="disabled"/>
                            </td>
                            <td>
                              <button type="button" id="locker_codePostal" class="btn btn-secondary" onclick="delock('codePostal')">
                                <img id="img_codePostal" src="img/close.png" class="avion" alt="submit"/>
                              </button>
                            </td>
                          </tr>
                          <tr>
                            <th scope="col">Pays</th>
                            <td>
                              <select id='pays' name="pays" disabled='disabled'>
                                <c:forEach var="pays" items="${pays}">
                                  <option value=${pays.paysId} ${form.paysId.paysId == pays.paysId?'selected="selected"' : ''}>${pays.paysNom}</option>
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
                              <input type="text" id="mail" name="mail" value="${form.mail}" placeholder="insérer votre mail" disabled="disabled"/>
                            </td>
                            <td>
                              <button type="button" id="locker_mail" class="btn btn-secondary" onclick="delock('mail')">
                                <img id="img_mail" src="img/close.png" class="avion" alt="submit"/>
                              </button>
                            </td>
                          </tr>
                          <tr>
                            <th scope="col" style="color:red">Commentaire Mission Logement<br/>(sera transmis à l'étudiant en cas de refus du dossier)</th>
                            <td> 
                              <textarea class="commentairesVe" cols="40" rows="5" name="commentairesVe" id="commentairesVe" style="color:red" disabled="disabled" >${form.commentairesVe}</textarea> 
                            </td>
                            <td>
                              <button type="button" id="locker_commentairesVe" class="btn btn-secondary" onclick="delock('commentairesVe')">
                                <img id="img_commentairesVe" src="img/close.png" class="avion" alt="submit"/>
                              </button>
                            </td>
                          </tr>
                        </tbody>
                      </table>
                      <input type="hidden" name="id" value="${form.formulaireId}" />
                      <input type="hidden" name="personneId" value="${form.personneId}" />
                    </div>  
                    <div class="container mt-4 mb-4 text-center">
                      <div class="row justify-content-center">
                        <div class="col-md-6">
                          <p>Le Bouton Vider et Transmettre gardera toutes les informations présentes sur cet écran mais supprimera les autres informations rentrées par l'étudiant (bourse, souhait,...) avant de le transmettre  </p>
                          <input type="hidden" name="connexionId" value="${connexionId}" />
                          <button onclick="openForm('formVe')" formaction="EnregistrerDossierNnTransmit.do" type="submit" name="enregistrer" class="btn btn-primary mr-3" value="enregistrer" >
                            Sauvegarder <img src="img/save.png" class="icon" alt="save"/>
                          </button>
                          <button onclick="openForm('formVe')" formaction="ViderEtTransmettre.do" type="submit" name="refuser" class="btn btn-danger" value="refuser">
                            Vider et Transmettre <img src="img/refuse.png" class="icon" alt="submit"/>
                          </button>     
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







