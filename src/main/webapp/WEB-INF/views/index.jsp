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
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

  <style>
    .password-field {
      position: relative;
    }

    .password-field input {
      padding-right: 42px;
    }

    .toggle-password {
      position: absolute;
      right: 14px;
      top: 50%;
      transform: translateY(-50%);
      cursor: pointer;
      font-size: 18px;
      color: #555;
      z-index: 2;
    }
  </style>

  <script>
    // Scroll to Top Logic for Mobile
    window.onscroll = function () { scrollFunction() };

    function scrollFunction() {
      var btn = document.getElementById("mobileLoginBtn");
      if ((document.body.scrollTop > 300 || document.documentElement.scrollTop > 300) && window.innerWidth <= 992) {
        btn.style.display = "block";
      } else {
        btn.style.display = "none";
      }
    }

    function scrollToTop() {
      window.scrollTo({ top: 0, behavior: 'smooth' });
    }

    function togglePassword(inputId, icon) {
      const input = document.getElementById(inputId);

      if (input.type === "password") {
        input.type = "text";
        icon.classList.remove("bi-eye-slash");
        icon.classList.add("bi-eye");
      } else {
        input.type = "password";
        icon.classList.remove("bi-eye");
        icon.classList.add("bi-eye-slash");
      }
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
              <label for="login">Login</label>
              <input type="text" id="login" name="myLogin" placeholder="Identifiant" class="form-control custom-input" />
            </div>

            <div class="form-group">
              <label for="password">Mot de passe</label>
              <div class="password-field">
                <input type="password" id="password" name="myPasswd" placeholder="Mot de passe" class="form-control custom-input" />
                <i class="bi bi-eye-slash toggle-password"
                   onclick="togglePassword('password', this)"></i>
              </div>
            </div>

            <button type="submit" class="custom-button">Se connecter</button>
          </form>

          <div class="mt-3">
            <a href="passwordreset.do" class="defaultlink">Mot de passe oublié ?</a>
          </div>

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