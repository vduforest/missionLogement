<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr-fr">
  <head>
    <title>ACCUEIL_ETUDIANT</title>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="bootstrap/css/bootstrap.css" type="text/css"rel="stylesheet"/>
    <link href="css/default.css" type="text/css"rel="stylesheet"/>
    <link href="css/accueil_etudiant.css" type="text/css"rel="stylesheet"/>
    <link href="css/header.css" type="text/css" rel="stylesheet"/>

    <script type="text/javascript">
      function showLoading(btn, text) {
        if (btn.classList.contains('is-loading')) return false;
        btn.classList.add('is-loading');

        const spinner = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true" style="margin-right: 5px;"></span> ';
        btn.innerHTML = spinner + (text || "");

        // Delay disabling to allow form data capture
        setTimeout(() => {
          btn.disabled = true;
        }, 10);

        return true;
      }
    </script>
  </head>

  <body>
    <jsp:include page="/WEB-INF/views/header.jsp"/>
    <div class="main">
      <div class="py-3">
        <div class="container">
          <div class="row">
            <div class="col-md-12">
              <div class="table-responsive">
                <table class="table table-striped">
                  <thead>
                  <form method="POST">
                    <input type="hidden" name="connexionId" value="${connexionId}" />
                    <tr>
                      <th scope="col"class="text-center"><button class="redirect" formaction="informations.do" onclick="showLoading(this, 'Chargement...')">Informations Standard</button></th>
                      <th scope="col"class="text-center"><button class="btn redirect" formaction="formulaire.do" onclick="showLoading(this, 'Chargement...')">Formulaire</button></th>
                    </tr>
                  </form>
                  </thead>
                </table>
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