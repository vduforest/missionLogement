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
    <link href="css/header.css" type="text/css" rel="stylesheet"/>
    

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
    <script type="text/javascript">
      function checkSubmit(formId, msg) {
        var result = confirm(msg);
        var formRef = document.getElementById(formId);
        if ((formRef !== null) && (result)) {
          // launch
          formRef.submit();
          return true;
        }
        return false;
      }
    </script>

  </head>

  <body>
    <!-- Header Section -->
    <jsp:include page="/WEB-INF/views/header.jsp"/>   

    <!-- Main Section -->
    <div class="py-3">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <h2 class="" style="position:relative">Liste des dossiers transmis
              <form method="post" action="dossiers.do" style="position:absolute;right:0px;top:0px">
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
                    <th scope="col" class="text-center">Informations</th>
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
                        <c:if test="${(! empty formulaire.estBoursier) && (formulaire.estBoursier)}">Boursier<br/>
                          <c:if test="${! formulaire.hasBourseFile()}">
                            <span class="text-danger">Preuve manquante</span><br/>
                          </c:if>
                        </c:if>
                        <c:if test="${(! empty formulaire.estPmr) && (formulaire.estPmr)}">Nécessite aménagement<br/></c:if>
                        <c:if test="${(! empty formulaire.paysId) && (formulaire.paysId.paysId != 1)}">Localisation : ${formulaire.paysId.paysNom}<br/></c:if>
                        <c:if test="${(empty formulaire.dateDeNaissance)}"><span class="text-danger">Date de naissance manquante</span><br/></c:if>
                        <c:if test="${(empty formulaire.genreId)}"><span class="text-danger">Genre non indiqué</span><br/></c:if>
                        <c:if test="${(empty formulaire.mail)}"><span class="text-danger">Adresse mail non indiqué</span><br/></c:if>
                        <c:if test="${(empty formulaire.numeroTel)}"><span class="text-danger">Numéro de téléphone non indiqué</span><br/></c:if>
                        <c:if test="${(empty formulaire.ville)}"><span class="text-danger">Ville manquante</span><br/></c:if>
                        <c:if test="${(empty formulaire.paysId)}"><span class="text-danger">Pays manquant</span><br/></c:if>
                        <c:if test="${(empty formulaire.estBoursier)}"><span class="text-danger">Statut boursier incorrect</span><br/></c:if>
                        <c:if test="${(empty formulaire.estPmr)}"><span class="text-danger">Statut PMR incorrect</span><br/></c:if>
                        <c:if test="${(empty formulaire.souhaitId)}"><span class="text-danger">Souhait non formulé</span><br/></c:if>
                        <c:if test="${(! empty formulaire.dateValidation)}"><span class="text-primary">Soumis le : <fmt:formatDate value='${formulaire.dateValidation}' pattern='dd/MM/yyyy HH:mm:ss'/></span><br/></c:if>
                        </td>
                        <td class="text-center">
                          <div class="row">
                            <div class="col-md-6">
                              <form action="formulaireVe.do" method="POST">
                                <input type="hidden" name="connexionId" value="${connexionId}" />
                              <input type="hidden" name="formulaireId" value="${formulaire.formulaireId}" />
                              <button name="edit" class="btn btn-primary">
                                <img src="img/show.png" alt="show" class="icon" />
                              </button>
                            </form>
                          </div>
                          <div class="col-md-6">
                            <form action="AnnulerPwd2.do" id="check_${formulaire.formulaireId}" method="POST">
                              <input type="hidden" name="connexionId" value="${connexionId}" />
                              <input type="hidden" name="formulaireId" value="${formulaire.formulaireId}" />
                              <input type="hidden" name="id" value="${formulaire.formulaireId}" />
                              <button name="reinitialiser" class="btn btn-danger" onclick="return checkSubmit('check_${formulaire.formulaireId}', 'Rï¿½initialiser le mot de passe ?');">
                                <img src="img/return.png" class="icon" alt="Reinitialiser"/>
                              </button>
                            </form>
                            <c:if test="${(! empty connexion) && (connexion.isAdmin())}">
                              ${formulaire.personneId.login}
                            </c:if>
                          </div>
                        </div>
                      </td>
                    </tr>
                  </c:forEach>
                </tbody>
                <tfoot>
                  <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td class="text-center">
                      <form action="allDossiers.do" method="POST">
                        <input type="hidden" name="connexionId" value="${connexionId}" />
                        <button id="allDossiers">Voir tous les dossiers</button>
                      </form>
                    </td>
                    <td class="text-center">
                      <form action="export.do" method="POST">
                        <input type="hidden" name="connexionId" value="${connexionId}" />
                        <button id="export">Exporter les dossiers</button>
                      </form>
                    </td>
                  </tr>
                </tfoot>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
    <script>
      var tableName = "StudentList";
      $(document).ready(function () {
        // Setup - ajout d'un text pour chaque case du footer
        $('#' + tableName + 'tfoot th').each(function () {
          var theId = $(this).attr('id');
          if ((theId !== null) && ((typeof theId) !== 'undefined') && (theId !== "")) {
            var title = $(this).text();
            $(this).html('<input type="text" name="search_' + theId + '" placeholder="' + title + '" value=""/>');
          }
        });

        /*
         // addDataTableButtonNew("Etudiants");
         setDataTableRemovePaginate();
         var table = buildTable(tableName);
         
         //mise en place de la recherche
         table.columns().every(function () {
         var that = this;
         $('input', this.footer()).on('keyup change', function () {
         if (that.search() !== this.value) {
         that.search(this.value).draw();
         }
         });
         });
         */
      });
    </script>
  </body>
</html>
