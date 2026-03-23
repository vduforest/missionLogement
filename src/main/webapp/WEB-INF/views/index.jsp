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

    .btn-toggle-password {
      position: absolute;
      right: 14px;
      top: 50%;
      transform: translateY(-50%);
      cursor: pointer;
      font-size: 18px;
      color: #555;
      z-index: 2;
      background: none;
      border: none;
      padding: 0;
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

    function togglePassword(inputId, btn) {
      const input = document.getElementById(inputId);
      const icon = btn.querySelector('i');
      const isVisible = input.type === 'text';

      input.type = isVisible ? 'password' : 'text';
      icon.classList.toggle('bi-eye', isVisible);
      icon.classList.toggle('bi-eye-slash', !isVisible);

      btn.setAttribute('aria-pressed', String(!isVisible));
      btn.setAttribute('aria-label', isVisible ? 'Afficher le mot de passe' : 'Masquer le mot de passe');
    }

    function showLoading() {
      const btn = document.getElementById("loginBtn");
      btn.disabled = true;
      btn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Connexion en cours...';
      return true;
    }
  </script>
</head>

<body>

  <main class="split-container" id="top">

    <div class="split-pane left-pane">
      <div class="content-wrapper">

        <h1 class="brand-title">
          Bienvenue sur la<br />
          <span class="highlight">plateforme Mission Logement</span>
        </h1>

        <div class="login-box">
          <form action="login.do" method="POST" onsubmit="return showLoading()">
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
                <button type="button"
                        class="btn-toggle-password"
                        onclick="togglePassword('password', this)"
                        aria-label="Afficher le mot de passe"
                        aria-pressed="false">
                    <i class="bi bi-eye-slash" aria-hidden="true"></i>
                </button>
              </div>
            </div>

            <button type="submit" id="loginBtn" class="custom-button">Se connecter</button>
          </form>

          <div class="mt-3">
            <a href="passwordreset.do" class="defaultlink">Mot de passe oublié ?</a>
          </div>

          <div class="first-login-info">
            <h5>Première connexion ?</h5>
            <p>
              Si c'est votre première visite, vous devez avoir répondu
              <span class="highlight-text">"oui définitif"</span> avant la date indiquée sur le site et attendre la
              réception d'un email de la mission logement pour obtenir vos identifiants.
            </p>
          </div>
        </div>
      </div>
    </main>

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
