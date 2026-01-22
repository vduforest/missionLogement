<%-- 
    Document   : premier_connexion
    Created on : 3 Dec 2024, 11:24:48
    Author     : samer
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr-fr">
  <head>
    <title>FIRST_CONNEXION</title>
    <meta charset="UTF-8"/>
    <link href="css/first_connexion.css" type="text/css" rel="stylesheet"/>
    <link href="bootstrap/css/bootstrap-reboot.min.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="js/jquery-3.6.1.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <script type="text/javascript" src="js/errorFirstConnection.js"></script>
  </head>
  <body>
    <div id="centrage">
      <h1>Création des logins</h1>
      <div class="row">
        <div class="col-md-12">
          <form action="saveUser.do" method="post" id="form">
             <input type="hidden" name="token" value="${token}" />
            <div id="boiteMessageAttention">
              <p id="messageAttention">PENSEZ A NOTER VOTRE IDENTIFIANT ET VOTRE MOT DE PASSE</p>
            </div>

            <div>
              <p>Votre identification :</p>
            </div>
              <c:if test="${not empty mySCEI}">
                <div class="form-group row">
                    <div class="col-10">
                        <input type="text" class="form-control" id="myScei" name="myScei" value="${mySCEI}" readonly>
                    </div>
                </div>
            </c:if>

            <c:if test="${not empty mail}">
              <div class="form-group row">
                <div class="col-10">
                  <input type="text" class="form-control" id="mail" name="mail" value="${mail}" readonly>
                </div>
              </div>
            </c:if>

            <p class="space"></p>
            <hr/>
            <p class="space"></p>
            <div>
              <p>Créez votre compte :</p>
            </div>

            <div class="form-group row">
              <div class="col-10">
                <input type="text" class="form-control" id="myLogin"
                       placeholder="Créer un Identifiant" name="myLogin" required="required">
              </div>
            </div>
            <p class="space"></p>
            <div class="form-group row">
              <div class="col-10">
                <input type="password" class="form-control" id="myPassword"
                       placeholder="Définir un mot de passe" name="myPassword" required="required">
              </div>
            </div>
            <div class="form-group row">
              <div class="col-10">
                <input type="password" class="form-control" id="confMyPassword"
                       placeholder="Confirmer le mot de passe" name="confMyPassword" required="required">
              </div>
            </div>
            <c:if test="${! empty mySCEI}"><input type="hidden" class="form-control" id="mySCEI" name="mySCEI" value="${mySCEI}" disabled></c:if>
            <c:if test="${! empty mail}"><input type="hidden" class="form-control" id="mail" name="mail" value="${mail}" disabled></c:if>
            <p class="space"></p>
            <button type="submit" class="btn btn-success">Valider</button>
            <div class="erreur"> 
              <script>error(${error});</script>
            </div>
          </form>
        </div>
      </div>
    </div>
  </body>
</html>
