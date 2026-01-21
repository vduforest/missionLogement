<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr-fr">
  <head>
    <title>ACCUEIL_ETUDIANT</title>
    <meta charset="UTF-8"/>
    <link href="bootstrap/css/bootstrap.css" type="text/css"rel="stylesheet"/>
    <link href="css/default.css" type="text/css"rel="stylesheet"/>
    <link href="css/accueil_etudiant.css" type="text/css"rel="stylesheet"/>
    <link href="css/header.css" type="text/css" rel="stylesheet"/>

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
                      <th scope="col"class="text-center"><button class="redirect" formaction="informations.do">Informations Standard</button></th>
                      <th scope="col"class="text-center"><button class="btn redirect" formaction="formulaire.do">Formulaire</button></th>
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