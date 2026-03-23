<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr-fr">

<head>
  <title>Nouveau mot de passe - Mission Logement</title>
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

    function validateForm() {
      var password = document.getElementById("password").value;
      var confirmPassword = document.getElementById("confirmPassword").value;
      var errorDiv = document.getElementById("jsErrorMessage");
      
      if (password !== confirmPassword) {
        errorDiv.innerText = "Les mots de passe ne correspondent pas.";
        errorDiv.style.display = "block";
        return false;
      }
      
      const btn = document.getElementById("submitBtn");
      btn.disabled = true;
      btn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Validation en cours...';
      
      return true;
    }
  </script>
</head>

<body>

  <div class="split-container">

    <div class="split-pane left-pane">
      <div class="content-wrapper">

        <h1 class="brand-title">
          Définir votre<br />
          <span class="highlight">nouveau mot de passe</span>
        </h1>

        <div class="login-box">
          <form action="submitnewpassword.do" method="POST" onsubmit="return validateForm()">
            <input type="hidden" value="${token}" name="token" />

            <div id="jsErrorMessage" class="alert alert-danger custom-alert" style="display:none;"></div>
            
            <c:if test="${! empty errorMessage}">
              <div class="alert alert-danger custom-alert">
                ${errorMessage}
              </div>
            </c:if>

            <div class="form-group">
              <label for="password">Nouveau mot de passe</label>
              <div class="password-field">
                <input type="password" id="password" name="password" placeholder="Nouveau mot de passe" class="form-control custom-input" required />
                <i class="bi bi-eye-slash toggle-password" onclick="togglePassword('password', this)"></i>
              </div>
            </div>

            <div class="form-group">
              <label for="confirmPassword">Confirmer le mot de passe</label>
              <div class="password-field">
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirmer le mot de passe" class="form-control custom-input" required />
                <i class="bi bi-eye-slash toggle-password" onclick="togglePassword('confirmPassword', this)"></i>
              </div>
            </div>

            <button type="submit" id="submitBtn" class="custom-button">Valider le nouveau mot de passe</button>
          </form>

          <div class="mt-4">
            <a href="index.do" class="defaultlink"><i class="bi bi-arrow-left"></i> Retour à la connexion</a>
          </div>
        </div>
      </div>
    </div>

    <div class="split-pane right-pane">
      <div class="content-wrapper text-content">
        <div class="info-text">
          <h3 class="mb-4" style="color: #0e2748; font-weight: bold;">Sécurité</h3>
          <p>
            Veuillez choisir un mot de passe robuste pour garantir la sécurité de votre compte.
          </p>
          <div class="first-login-info" style="margin-top: 20px; background-color: rgba(14, 39, 72, 0.05); border-left-color: #0e2748;">
            <h5 style="color: #0e2748;">Conseils :</h5>
            <ul style="color: #333; font-size: 14px; padding-left: 20px;">
              <li>Utilisez au moins 8 caractères</li>
              <li>Mélangez majuscules et minuscules</li>
              <li>Ajoutez des chiffres et des caractères spéciaux</li>
            </ul>
          </div>
        </div>
      </div>
    </div>

  </div>

</body>

</html>
