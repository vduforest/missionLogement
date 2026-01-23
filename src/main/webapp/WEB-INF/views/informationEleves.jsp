<%-- Document : informationEleves Created on : 6 févr. 2025, 10:49:43 Author : Amolz --%>

  <%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="fr-fr">

    <head>
      <title>INFORMATIONS_ELEVES</title>
      <meta charset="UTF-8" />
      <link href="bootstrap/css/bootstrap.css" type="text/css" rel="stylesheet" />
      <link href="css/default.css" type="text/css" rel="stylesheet" />
      <link href="css/header.css" type="text/css" rel="stylesheet" />
    </head>

    <body>
      <jsp:include page="/WEB-INF/views/header.jsp" />

      <div class="main">
        <div class="col-md-12">
          <p class="informations">${texteInfo}</p>
        </div>
      </div>
      <div class="row mt-4 mb-5">
        <div class="col-md-12 text-center">
          <form action="formulaire.do" method="POST">
            <input type="hidden" name="connexionId" value="${connexionId}" />
            <button type="submit" class="custom-button" style="padding: 15px 30px; font-size: 1.2em;">Accéder au
              Formulaire</button>
          </form>
        </div>
      </div>
      </div>
    </body>

    </html>