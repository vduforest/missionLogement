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

  </head>

  <body>
      <jsp:include page="/WEB-INF/views/header.jsp"/>
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
                    <th scope="col" class="text-center">Etat
                      <div style="display:inline-block;position:relative;">
                        <button id="etatFilterBtn" type="button" class="btn btn-sm" style="margin-left:6px;padding:2px 6px;">---</button>
                        <div id="etatFilterDropdown" style="display:none;position:absolute;right:0;background:#fff;border:1px solid #ccc;padding:8px;z-index:1000;min-width:140px;">
                          <label><input type="checkbox" class="etat-checkbox" value="traite_complet" checked/> Traitement complet</label><br/>
                          <label><input type="checkbox" class="etat-checkbox" value="dossier_non_conforme" checked/> Dossier non conforme</label><br/>
                          <label><input type="checkbox" class="etat-checkbox" value="a_traiter" checked/> A traiter</label><br/>
                          <label><input type="checkbox" class="etat-checkbox" value="non_transmis" checked/> Non transmis</label>
                        </div>
                      </div>
                    </th>
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
                      <c:choose>
                        <c:when test="${formulaire.estConforme}">
                          <c:set var="etat" value="traite_complet" />
                        </c:when>
                        <c:when test="${(!formulaire.estValide) && (! empty formulaire.commentairesVe)}">
                          <c:set var="etat" value="dossier_non_conforme" />
                        </c:when>
                        <c:when test="${(formulaire.estPmr) || (formulaire.estBoursier) || (formulaire.genreId.genreId!=formulaire.genreAttendu.genreId)}">
                          <c:set var="etat" value="a_traiter" />
                        </c:when>
                        <c:otherwise>
                          <c:set var="etat" value="non_transmis" />
                        </c:otherwise>
                      </c:choose>
                      <td class="text-center" data-etat="${etat}">
                        <c:choose>
                          <c:when test="${formulaire.estConforme}">
                            <img src="img/coche.png"alt="coche"class="icon"/>
                          </c:when>
                          <c:when test="${(!formulaire.estValide) && (! empty formulaire.commentairesVe)}">
                            <img onclick="afficherTexte('${formulaire.estBoursier}','${formulaire.estPmr}','${formulaire.genreId.genreId}','${formulaire.genreAttendu.genreId}');" src="img/red-x-icon.png"alt="refus"class="icon"/>
                          </c:when>
                          <c:when test="${(formulaire.estPmr) || (formulaire.estBoursier) || (formulaire.genreId.genreId!=formulaire.genreAttendu.genreId)}">
                            A traiter
                          </c:when>
                          <c:otherwise>
                            Non transmis
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
  <script type="text/javascript">
    $(document).ready(function(){
      var table = buildTable('StudentList');

      var selectedStatuses = ['traite_complet','dossier_non_conforme','a_traiter','non_transmis'];

      function reorderRows(){
        selectedStatuses = $('.etat-checkbox:checked').map(function(){return $(this).val();}).get();
        var tbody = $('#StudentList tbody');
        var nodes = table.rows({order:'applied'}).nodes().toArray();
        var matched = [], others = [];
        nodes.forEach(function(row){
          var status = $(row).find('td[data-etat]').data('etat');
          if ($.inArray(status, selectedStatuses) !== -1) matched.push(row);
          else others.push(row);
        });
        // append matched first, then others (moving DOM nodes)
        matched.concat(others).forEach(function(r){ tbody.append(r); });
        // redraw table display without resetting paging
        table.rows().invalidate().draw(false);
      }

      $('#etatFilterBtn').on('click', function(e){
        e.stopPropagation();
        $('#etatFilterDropdown').toggle();
      });

      $(document).on('click', function(){ $('#etatFilterDropdown').hide(); });

      $('.etat-checkbox').on('change', function(){ reorderRows(); });

      // initial ordering
      reorderRows();
    });
  </script>
      </body>
</html>