<%-- Document : passwrodreset Created on : 10 Feb 2025, 16:27:44 Author : samer --%>
  <%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="fr-fr">

    <head>
      <title>Réinitialisation du mot de passe</title>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0">

      <link href="bootstrap/css/bootstrap.css" type="text/css" rel="stylesheet" />
      <link href="css/index.css" type="text/css" rel="stylesheet" />
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

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

        function showLoading() {
          const btn = document.getElementById("submitBtn");
          btn.disabled = true;
          btn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Envoi en cours...';
          return true;
        }
      </script>
    </head>

    <body>

      <div class="split-container" id="top">

        <div class="split-pane left-pane">
          <div class="content-wrapper">

            <h1 class="brand-title">
              Réinitialisation du<br />
              <span class="highlight">mot de passe</span>
            </h1>

            <div class="login-box">
              <form action="submitpasswordreset.do" method="POST" onsubmit="return showLoading()">
                <c:if test="${param.error != null}">
                  <div class="alert alert-danger custom-alert">
                    ${param.error}
                  </div>
                </c:if>
                <c:if test="${! empty errorMessage}">
                  <div class="alert alert-danger custom-alert">
                    ${errorMessage}
                  </div>
                </c:if>
                <c:if test="${param.success != null}">
                  <div class="alert alert-success custom-alert">
                    ${param.success}
                  </div>
                </c:if>
                <c:if test="${! empty succesMessage}">
                  <div class="alert alert-success custom-alert">
                    ${succesMessage}
                  </div>
                </c:if>

                <div class="form-group">
                  <label for="mySCEI">Numéro SCEI</label>
                  <input type="text" id="mySCEI" name="scei" placeholder="Votre numéro SCEI"
                    class="form-control custom-input" required />
                </div>

                <div class="form-group">
                  <label for="myMail">Adresse e-mail</label>
                  <input type="email" id="myMail" name="mail" placeholder="Votre adresse mail"
                    class="form-control custom-input" required />
                </div>

                <button type="submit" id="submitBtn" class="custom-button">Envoyer le lien de réinitialisation</button>
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
              <h3 class="mb-4" style="color: #0e2748; font-weight: bold;">Instructions</h3>
              <p>
                Pour réinitialiser votre mot de passe, veuillez saisir votre <strong>numéro SCEI</strong> ainsi que
                l'<strong>adresse e-mail</strong>
                associée à votre dossier de candidature.
              </p>
              <p>
                Un e-mail contenant un lien de réinitialisation vous sera envoyé. Ce lien sera valide pendant <strong>24
                  heures</strong>.
              </p>
              <p>
                Si vous ne recevez pas l'e-mail dans les prochaines minutes, vérifiez votre dossier de courriers
                indésirables (spams).
              </p>
            </div>
          </div>
        </div>

      </div>

      <button id="mobileLoginBtn" onclick="scrollToTop()">&#8593; Réinitialiser</button>

    </body>

    </html>