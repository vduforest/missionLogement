<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang='fr-fr'>
  <head>
    <title>DOSSIERS</title>
    <meta charset="UTF-8"/>

    <script type="text/javascript" src="js/jquery-3.6.1.min.js"></script>

    <!--Boostrap-->
    <script src="bootstrap/js/bootstrap.js" type="text/javascript"></script>
    <script src="js/alerte.js" type="text/javascript"></script>
    <link href="bootstrap/css/bootstrap.css" type="text/css" rel="stylesheet"/>

    <!--Local-->
    <link href="css/default.css" type="text/css" rel="stylesheet"/>
    <link href="css/pageDossiers.css" type="text/css" rel="stylesheet"/>

    <!--Datatable-->
    <script src="js/mainDataTables.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="dataTables/css/jquery.dataTables.css"/>
    <link rel="stylesheet" type="text/css" href="dataTables/css/buttons.dataTables.css">
    <link rel="stylesheet" type="text/css" href="dataTables/css/responsive.dataTables.min.css">
    <link rel="stylesheet" type="text/css" href="dataTables/css/rowReorder.dataTables.min.css">
    <script type="text/javascript" src="dataTables/js/jquery.dataTables.js" ></script>
    <script type="text/javascript" src="dataTables/js/dataTables.buttons.js"></script>
    <script type="text/javascript" src="dataTables/js/buttons.html5.js"></script>
    <script type="text/javascript" src="dataTables/js/buttons.print.js"></script>
    <script type="text/javascript" src="dataTables/js/dataTables.select.js"></script>
    <script type="text/javascript" src="dataTables/js/dataTables.responsive.min.js"></script>
    <script type="text/javascript" src="dataTables/js/dataTables.rowReorder.min.js"></script>

  </head>

  <body>
    <!-- Header Section -->
    <div id="header">
      <nav class="navbar navbar-expand-md navbar-dark bg-dark">
        <div class="container">
          <div class="collapse navbar-collapse"id="navbar1">
            <form method="POST">
              <input type="hidden" name="connexionId" value="${connexionId}" />
              <ul class="navbar-nav mb-lg">
                <h1>Plateforme Mission Logement</h1>
                <li class="nav-item"><button class="btn nav-link text-white" formaction="returnToDossiers.do"><img src="img/logocn.png"alt="logo"class="logo"/></button></li>
                <li class="nav-item"><button class="btn nav-link text-white" formaction="index.do"><img src="img/porteOuverte.png"alt="sortie"class="sortie"/></button></li>
              </ul>
            </form>
          </div>
        </div>
      </nav>
    </div>   

    <!-- Main Section -->
    <div class="py-3">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <h2 class="" style="position:relative">Liste de tous les dossiers
              <form method="post" action="allDossiers.do" style="position:absolute;right:0px;top:0px">
                <input type="hidden" name="connexionId" value="${connexionId}" />
                <button class="btn">Refresh</button>
              </form>
            </h2>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <div class="table-responsive">
              <table id="StudentList" class="table table-striped table-md sortable">
                <thead>
                  <tr>
                    <th scope="col" class="text-center">Numero SCEI</th>
                    <th scope="col" class="text-center">Nom</th>
                    <th scope="col" class="text-center">Prenom</th>
                    <th scope="col" class="text-center">Etat</th>
                    <th scope="col" class="text-center">Actions</th>
                  </tr>
                </thead>
                <tbody>
                  <!-- Loop through Formulaire objects -->
                  <c:forEach var="formulaire" items="${forms}">
                    <tr>
                      <td class="text-center">${formulaire.numeroScei}</td>
                      <td class="text-center">${formulaire.personneId.nom}</td>
                      <td class="text-center">${formulaire.personneId.prenom}</td>
                      <td class="text-center">
                        <c:choose>
                          <c:when test="${formulaire.estConforme}">
                            <img src="img/coche.png"alt="coche"class="icon"/>
                          </c:when>
                          <c:when test="${(!formulaire.estValide) && (! empty formulaire.commentairesVe)}">
                            <img onclick="afficherTexte(${formulaire.estBoursier},${formulaire.estPmr},${formulaire.genreId.genreId},${formulaire.genreAttendu.genreId});" src="img/red-x-icon.png"alt="refus"class="icon"/>
                          </c:when>
                          <c:when test="${(formulaire.estPmr) || (formulaire.estBoursier) || (formulaire.genreId.genreId!=formulaire.genreAttendu.genreId)}">
                            <img onclick="afficherTexte(${formulaire.estBoursier},${formulaire.estPmr},${formulaire.genreId.genreId},${formulaire.genreAttendu.genreId});" src="img/warning.png"alt="warning"class="icon"/>
                          </c:when>
                          <c:otherwise>
                            A traiter
                          </c:otherwise>
                        </c:choose>
                      </td>
                      <td class="text-center">
                        <c:choose>
                          <c:when test="${formulaire.estConforme}">
                            Transmis
                          </c:when>
                          <c:otherwise>
                            <form action="dossierNnTransmit.do" method="POST">
                              <input type="hidden" name="connexionId" value="${connexionId}" />
                              <input type="hidden" name="formulaireId" value="${formulaire.formulaireId}" />
                              <button name="edit" class="btn btn-primary">
                                <img src="img/show.png" alt="show" class="icon" />
                              </button>
                            </form>
                          </c:otherwise>
                        </c:choose>
                      </td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
