<%-- 
    Document   : informationEleves
    Created on : 6 févr. 2025, 10:49:43
    Author     : Amolz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr-fr">
    <head>
        <title>INFORMATIONS_ELEVES</title>
        <meta charset="UTF-8"/>
        <link href="bootstrap/css/bootstrap.css"type="text/css"rel="stylesheet"/>
        <link href="css/default.css"type="text/css"rel="stylesheet"/>
    </head>

    <body>
        <div id="header">
            <nav class="navbar navbar-expand-md navbar-dark bg-dark">
                <div class="container">
                    <div class="collapse navbar-collapse"id="navbar1">
                        <form method="POST">
                        <input type="hidden" name="connexionId" value="${connexionId}" />
                        <ul class="navbar-nav ml-auto">
                            <h1>Plateforme Mission Logement</h1>
                            <li class="nav-item"><button class="btn nav-link text-white" formaction="studentDashboard.do"><img src="img/logocn.png"alt="logo"class="logo"/></button></li>
                            <li class="nav-item"><button class="btn nav-link text-white" formaction="index.do"><img src="img/porteOuverte.png"alt="sortie"class="sortie"/></button></li>
                        </ul>

                        </form>
                    </div>
                </div>
            </nav>
        </div>

        <div class="main">
          <div class="row">
            <div class="col-md-12">
              <div class="table-responsive">
                <table class="table table-striped">
                  <thead>
                  <form method="POST">
                    <input type="hidden" name="connexionId" value="${connexionId}" />
                    <tr>
                      <th scope="col"class="text-center"><button class="redirect" formaction="informations.do" disabled="disabled">Informations Standard</button></th>
                      <th scope="col"class="text-center"><button class="btn redirect" formaction="formulaire.do">Formulaire</button></th>
                    </tr>
                  </form>
                  </thead>
                </table>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-md-12">
            <p class="informations">${texteInfo}</p>
            </div>
          </div>
        </div>    
    </body>
</html>
