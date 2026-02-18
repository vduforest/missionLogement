<%-- Document : informationEleves Created on : 6 févr. 2025, 10:49:43 Author : Amolz --%>
  <%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="fr-fr">

    <head>
      <title>Mission Logement - Informations</title>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0">

      <link href="bootstrap/css/bootstrap.css" type="text/css" rel="stylesheet" />
      <link href="css/header.css" type="text/css" rel="stylesheet" />
      <link href="css/default.css" type="text/css" rel="stylesheet" />
    </head>

    <body>
      <jsp:include page="/WEB-INF/views/header.jsp" />

      <div class="main-container">
        <div class="info-card">
          <div class="informations-content">
            ${texteInfo}
          </div>

          <div class="text-center mt-5 pt-3">
            <form action="formulaire.do" method="POST">
              <input type="hidden" name="connexionId" value="${connexionId}" />
              <button type="submit" class="custom-button">
                Accéder au Formulaire
              </button>
            </form>
          </div>
        </div>
      </div>
    </body>

    </html>