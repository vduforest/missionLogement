<%@page contentType="text/html" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <!DOCTYPE html>
    <html lang="fr-fr">

    <head>
      <title>Connexion Mission Logement - Centrale Nantes</title>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0">

      <link href="bootstrap/css/bootstrap.css" type="text/css" rel="stylesheet" />
      <link href="css/index.css" type="text/css" rel="stylesheet" />

      <script>
        // Scroll to Top Logic for Mobile
        window.onscroll = function () { scrollFunction() };

        function scrollFunction() {
          var btn = document.getElementById("mobileLoginBtn");
          // Show button only if we have scrolled down 300px and we are on mobile
          if ((document.body.scrollTop > 300 || document.documentElement.scrollTop > 300) && window.innerWidth <= 992) {
            btn.style.display = "block";
          } else {
            btn.style.display = "none";
          }
        }

        function scrollToTop() {
          window.scrollTo({ top: 0, behavior: 'smooth' });
        }
      </script>
    </head>

    <body>

      <div class="split-container" id="top">

        <div class="split-pane left-pane">
          <div class="content-wrapper">

            <h1 class="brand-title">
              Bienvenue sur la<br />
              <span class="highlight">plateforme Mission Logement</span>
            </h1>

            <div class="login-box">
              <form action="login.do" method="POST">
                <c:if test="${! empty message}">
                  <div class="alert alert-danger custom-alert">
                    ${message}
                  </div>
                </c:if>

                <div class="form-group">
                  <input type="text" name="myLogin" placeholder="Identifiant" class="form-control custom-input" />
                </div>
                <div class="form-group">
                  <input type="password" name="myPasswd" placeholder="Mot de passe" class="form-control custom-input" />
                </div>

                <button type="submit" class="custom-button">Se connecter</button>
              </form>

              <div class="mt-3">
                <a href="passwordreset.do" class="defaultlink">Mot de passe oublié ?</a>
              </div>
              <!-- info pour la premiere connexion -->
              <div class="first-login-info">
                <h5>Première connexion ?</h5>
                <p>
                  Si c'est votre première visite, vous devez attendre la réception d'un email de la
                  <span class="highlight-text">Scolarité</span> pour obtenir vos identifiants.
                </p>
              </div>
            </div>
          </div>
        </div>

        <div class="split-pane right-pane">
          <div class="content-wrapper text-content">

            <c:if test="${! empty succesMessage}">
              <div class="alert alert-success custom-alert-box">
                ${succesMessage}
              </div>
            </c:if>

            <c:if test="${! empty errorMessage}">
              <div class="alert alert-danger custom-alert-box">
                ${errorMessage}
              </div>
            </c:if>

            <c:if test="${! empty textePopUp}">
              <div class="info-text">
                <h3 class="mb-4" style="color: #0e2748; font-weight: bold;">Informations</h3>
                ${textePopUp}
              </div>
            </c:if>

            <c:if test="${empty textePopUp}">
              <div class="info-placeholder">
                <h3>Informations</h3>
                <p>Veuillez vous connecter pour accéder aux services de la Mission Logement.</p>
                <p>Retrouvez toutes les informations sur la résidence ici (critères d'attribution, localisation...).</p>
              </div>
            </c:if>

          </div>
        </div>

      </div>

      <button id="mobileLoginBtn" onclick="scrollToTop()">&#8593; Se connecter</button>

    </body>

    </html>