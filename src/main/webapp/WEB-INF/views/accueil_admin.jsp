<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="fr-fr">
  <head>
    <title>ACCUEIL_ADMIN</title>
    <meta charset="UTF-8"/>
    <link href="bootstrap/css/bootstrap.css"type="text/css"rel="stylesheet"/>
    <link href="css/default.css" type="text/css" rel="stylesheet"/>
    <link href="css/accueil_admin.css"type="text/css"rel="stylesheet"/>
    <link href="css/pageDossiers.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="js/jquery-3.6.1.min.js"></script>
  </head>
  <body>
    <div id="header">
      <nav class="navbar navbar-expand-md navbar-dark bg-dark">
        <div class="container">
          <div class="collapse navbar-collapse"id="navbar1">
            <form method="POST">
              <input type="hidden" name="connexionId" value="${connexionId}" />
              <ul class="navbar-nav mb-lg">
                <h1>Plateforme Mission Logement</h1>
                <li class="nav-item"><button class="btn nav-link text-white" formaction="adminDashboard.do"><img src="img/logocn.png"alt="logo"class="logo"/></button></li>
                <li class="nav-item"><button class="btn nav-link text-white" formaction="index.do"><img src="img/porteOuverte.png"alt="sortie"class="sortie"/></button></li>
              </ul>
            </form>
          </div>
        </div>
      </nav>
    </div>    

    <div id="main">
      <div class="py-3">
        <div class="container">
          <div class="row">
            <div class="col-md-12">
              <div class="table-responsive">
                <table class="table table-striped">
                  <thead>
                    <tr>
                  <form method="POST">
                    <input type="hidden" name="connexionId" value="${connexionId}" />
                    <th scope="col"class="text-center"><button class="redirect" formaction="configuration.do">Configuration</button></th>                                             
                    <th scope="col"class="text-center"><button class="redirect" formaction="dossiers.do">Dossiers</button></th>
                    <th scope="col"class="text-center"><button class="redirect" formaction="pageAssistants.do">Assistants</button></th>
                  </form>
                  </tr>
                  </thead>
                </table>
                <c:choose>
                  <c:when test="${succes}"><div class="export" style="border-color: green"><p style="color:green">Les formulaires ont été importés avec succès</p></div></c:when>
                  <c:when test="${erreur}"><div class="export" style="border-color: red"><p style="color:red">Les formulaires n'ont pas pu être importés</p></div></c:when>
                  <c:when test="${suppressionSuccess}"><div class="export" style="border-color: green"><p style="color:green">Les données on été supprimées avec succès</p></div></c:when>
                  <c:when test="${suppressionErreur}"><div class="export" style="border-color: red"><p style="color:red">Erreur lors de la suppression des données</p></div></c:when>
                  <c:otherwise/>
                </c:choose>
              </div>
            </div>
          </div>
        </div>
      </div>
      <c:if test="${not empty confirmationMessage}">
        <div id="popupMessage" style="display: block; position: fixed; bottom: 20px; left: 20px; background-color: #4CAF50; color: white; padding: 10px; border-radius: 5px;">
          ${confirmationMessage}
        </div>

        <script type="text/javascript">
          // Masque le message après 5 secondes
          setTimeout(function () {
            document.getElementById("popupMessage").style.display = 'none';
          }, 5000);
        </script>
      </c:if>

      <div id="liste">
        <div class="py-3">
          <div class="container">
            <div class="row">
              <div class="col-md-12">
                <h2 class="" style="position:relative">Liste des dossiers en alerte
                  <form method="post" action="adminDashboard.do" style="position:absolute;right:0px;top:0px">
                    <input type="hidden" name="connexionId" value="${connexionId}" />
                    <button class="btn">Refresh</button>
                  </form>
                </h2>
              </div>
            </div>
            <div class="row">
              <div class="col-md-12">
                <div class="table-responsive">
                  <table class="table table-striped">
                    <thead>
                      <tr>
                        <th scope="col" class="text-center">Numero SCEI</th>
                        <th scope="col" class="text-center">Nom</th>
                        <th scope="col" class="text-center">Prenom</th>
                        <th scope="col" class="text-center">Etat</th>
                        <th scope="col" class="text-center">Statut</th>
                        <th scope="col" class="text-center">Informations</th>
                        <th scope="col" class="text-center">Action</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="alertes" items="${Alertes}">
                        <tr>
                          <td scope="col" class="text-center">${alertes.formulaireId.numeroScei}</td>
                          <td class="text-center">${alertes.formulaireId.personneId.nom}</td>
                          <td class="text-center">${alertes.formulaireId.personneId.prenom}</td>
                          <td class="text-center">${alertes.statutId.statutNom}</td>
                          <td class="text-center"><c:if test="${alertes.statutId.statutId==2}">
                              <c:choose>
                                <c:when test="${alertes.formulaireId.estConforme}">
                                  <img src="img/coche.png" alt="coche" class="icon"/>
                                </c:when>
                                <c:when test="${alertes.formulaireId.estValide}">
                                  <img src="img/red-x-icon.png" alt="refus" class="icon"/>
                                </c:when>
                              </c:choose>
                          </c:if></td>
                          <td class="text-center">
                                <c:if test="${(! empty alertes.formulaireId.estBoursier) && (alertes.formulaireId.estBoursier)}">Boursier<br/>
                                  <c:if test="${! alertes.formulaireId.hasBourseFile()}">
                                    <span class="text-danger">Preuve manquante</span><br/>
                                  </c:if>
                                </c:if>
                                <c:if test="${(! empty alertes.formulaireId.estPmr) && (alertes.formulaireId.estPmr)}">Nécessite aménagement<br/></c:if>
                                <c:if test="${(! empty alertes.formulaireId.paysId) && (alertes.formulaireId.paysId.paysId != 1)}">Localisation : ${alertes.formulaireId.paysId.paysNom}<br/></c:if>
                                <c:if test="${(empty alertes.formulaireId.dateDeNaissance)}"><span class="text-danger">Date de naissance manquante</span><br/></c:if>
                                <c:if test="${(empty alertes.formulaireId.genreId)}"><span class="text-danger">Genre non indiqué</span><br/></c:if>
                                <c:if test="${(empty alertes.formulaireId.mail)}"><span class="text-danger">Adresse mail non indiqué</span><br/></c:if>
                                <c:if test="${(empty alertes.formulaireId.numeroTel)}"><span class="text-danger">Numéro de téléphone non indiqué</span><br/></c:if>
                                <c:if test="${(empty alertes.formulaireId.ville)}"><span class="text-danger">Ville manquante</span><br/></c:if>
                                <c:if test="${(empty alertes.formulaireId.paysId)}"><span class="text-danger">Pays manquant</span><br/></c:if>
                                <c:if test="${(empty alertes.formulaireId.estBoursier)}"><span class="text-danger">Statut boursier incorrect</span><br/></c:if>
                                <c:if test="${(empty alertes.formulaireId.estPmr)}"><span class="text-danger">Statut PMR incorrect</span><br/></c:if>
                                <c:if test="${(empty alertes.formulaireId.souhaitId)}"><span class="text-danger">Souhait non formulé</span><br/></c:if>
                                <c:if test="${(! empty alertes.formulaireId.dateValidation)}"><span class="text-primary">Soumis le : <fmt:formatDate value='${alertes.formulaireId.dateValidation}' pattern='dd/MM/yyyy HH:mm:ss'/></span><br/></c:if>
                            </td>
                          <td class="text-center">
                            <form action="formulaireVe.do" method="POST">
                              <input type="hidden" name="connexionId" value="${connexionId}" />
                              <input type="hidden" name="formulaireId" value="${alertes.formulaireId.formulaireId}" />
                              <button name="edit" class="btn"><img src="img/show.png" alt="show" class="show"/></button>
                            </form>
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
      </div>
    </div>
</html>
