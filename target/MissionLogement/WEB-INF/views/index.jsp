<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="fr-fr">
  <head>
    <title>Connexion Mission Logement - Centrale Nantes</title>
    <meta charset="UTF-8"/>

    <link href="bootstrap/css/bootstrap.css"type="text/css"rel="stylesheet"/>
    <link href="css/index.css" type="text/css" rel="stylesheet"/>

    <script>
      function switchElement(ref) {
        var elt = document.getElementById(ref);
        if ((elt !== null) && (elt !== "undefined")) {
          if (elt.style.display === "block") {
            elt.style.display = 'none';
          } else {
            elt.style.display = 'block';
          }
        }
        return false;
      }
    </script>
  </head>
  <body>

    <div class="py-5">
      <div class="container">
        <div class="row">

          <div class="col-md-6" id="boite">
            <h1>Bienvenue sur la<br/>
              Plateforme Mission Logement</h1>

            <p>&nbsp;</p>
            <c:if test="${! empty message}">
              <h3 class="text-center" style="color:red">${message}</h3>
              <p>&nbsp;</p>
            </c:if>

            <!-- Login Form -->
            <form action="login.do" method="POST">
                <div class="text-center"><a href="creationcompte.do" class="defaultlink">Première connexion : Créer un compte</a></div><br>
                <div class="text-center" style="color:yellow;text-decoration: underline;font-weight: bold;cursor: pointer;" onclick="document.getElementById('identification').style.display='block';">J'ai déja un compte</div>
              <div>&nbsp;</div>
              <div id="identification" style="display:none">
                <p><input type="text" name="myLogin" value="" placeholder="Identifiant"/></p>
                <p><input type="password" name="myPasswd" value="" placeholder="Mot de passe"/></p>
                <p><button style="cursor:pointer;">Login</button></p>
              </div>
            </form>
            <div class="text-center"><a href="passwordreset.do" class="defaultlink">Mot de passe oublié ?</a></div>
          </div>

          <c:if test="${! empty textePopUp}">
            <div class="col-md-1"></div>
            <div class="col-md-5">
              <div><img src="img/info.png" id="info" class="info" onclick="switchElement('popUp')"/></div>
              <p id="popUp" class="text-left" style="display:block">${textePopUp}</p>
            </div>
          </c:if>
            
          <c:if test="${! empty succesMessage}">
            <div class="export" style="border-color: green"><p style="color:green">${succesMessage}</p></div>
          </c:if>
          
          <c:if test="${! empty errorMessage}">
            <div class="export" style="border-color: green"><p style="color:green">${errorMessage}</p></div>
          </c:if>
        </div>
      </div>

    </div>
  </body>
</html>
