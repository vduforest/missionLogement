<%@ taglib prefix="c" uri="jakarta.tags.core" %>
  <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
    <!DOCTYPE html>
    <html lang='fr-fr'>

    <head>
      <title>DOSSIERS</title>
      <meta charset="UTF-8" />

      <script type="text/javascript" src="js/jquery-3.6.1.min.js"></script>

      <script src="bootstrap/js/bootstrap.js" type="text/javascript"></script>
      <script src="js/alerte.js" type="text/javascript"></script>
      <link href="bootstrap/css/bootstrap.css" type="text/css" rel="stylesheet" />

      <link href="css/default.css" type="text/css" rel="stylesheet" />
      <link href="css/pageDossiers.css" type="text/css" rel="stylesheet" />
      <link href="css/header.css" type="text/css" rel="stylesheet" />

      <script src="js/mainDataTables.js" type="text/javascript"></script>
      <link rel="stylesheet" type="text/css" href="dataTables/css/jquery.dataTables.css" />
      <link rel="stylesheet" type="text/css" href="dataTables/css/buttons.dataTables.css">
      <link rel="stylesheet" type="text/css" href="dataTables/css/responsive.dataTables.min.css">
      <link rel="stylesheet" type="text/css" href="dataTables/css/rowReorder.dataTables.min.css">
      <script type="text/javascript" src="dataTables/js/jquery.dataTables.js"></script>
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
      <jsp:include page="/WEB-INF/views/header.jsp" />

      <div class="py-3">
        <div class="container">

          <div class="row mb-2 align-items-end">
            <div class="col-md-12 d-flex justify-content-between align-items-center">
              <h2 class="m-0">Liste des dossiers transmis</h2>

              <form method="post" action="dossiers.do" class="m-0">
                <input type="hidden" name="connexionId" value="${connexionId}" />
                <button class="refresh-btn" title="RafraÃ®chir">
                  <img src="img/refresh.png" alt="Refresh" class="refresh-icon" />
                </button>
              </form>
            </div>
          </div>
<<<<<<< HEAD
        </div>
        <div class="row">
          <div class="col-md-12">
            <div class="table-responsive">
              <table id="StudentList" class="table table-striped table-md sortable">
                <thead>
                  <tr>
                   <th style="display:none">priority</th>
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
                    <th scope="col" class="text-center">Informations</th>
                    <th scope="col" class="text-center">Actions</th>
                  </tr>
                </thead>
                <tbody>
                  <!-- Loop through Formulaire objects -->
                  <c:forEach var="formulaire" items="${forms}">
                    <tr>
                      <td style="display:none" class="priority">1</td>
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
                        <td class="text-center" data-etat="${etat}" data-search="${etat == 'traite_complet' ? 'traite complet' : (etat == 'dossier_non_conforme' ? 'non conforme' : (etat == 'a_traiter' ? 'a traiter' : 'non transmis'))}">
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
=======

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
                    <c:forEach var="formulaire" items="${forms}">
                      <tr>
                        <td class="text-center">${formulaire.numeroScei}</td>
                        <td class="text-center">${formulaire.personneId.nom}</td>
                        <td class="text-center">${formulaire.personneId.prenom}</td>
                        <td class="text-center">
                          <c:choose>
                            <c:when test="${formulaire.estConforme}">
                              <img src="img/coche.png" alt="coche" class="icon" />
                            </c:when>
                            <c:when test="${(!formulaire.estValide) && (! empty formulaire.commentairesVe)}">
                              <img
                                onclick="afficherTexte(${formulaire.estBoursier},${formulaire.estPmr},${formulaire.genreId.genreId},${formulaire.genreAttendu.genreId});"
                                src="img/red-x-icon.png" alt="refus" class="icon" />
                            </c:when>
                            <c:when
                              test="${(formulaire.estPmr) || (formulaire.estBoursier) || (formulaire.genreId.genreId!=formulaire.genreAttendu.genreId)}">
                              <img
                                onclick="afficherTexte(${formulaire.estBoursier},${formulaire.estPmr},${formulaire.genreId.genreId},${formulaire.genreAttendu.genreId});"
                                src="img/warning.png" alt="warning" class="icon" />
                            </c:when>
                            <c:otherwise>
                              A traiter
                            </c:otherwise>
                          </c:choose>
                        </td>
                        <td class="text-center">
                          <c:if test="${(! empty formulaire.estBoursier) && (formulaire.estBoursier)}">Boursier<br />
                            <c:if test="${! formulaire.hasBourseFile()}">
                              <span class="text-danger">Preuve manquante</span><br />
                            </c:if>
                          </c:if>
                          <c:if test="${(! empty formulaire.estPmr) && (formulaire.estPmr)}">NÃ©cessite amÃ©nagement<br />
                          </c:if>
                          <c:if test="${(! empty formulaire.paysId) && (formulaire.paysId.paysId != 1)}">Localisation :
                            ${formulaire.paysId.paysNom}<br /></c:if>
                          <c:if test="${(empty formulaire.dateDeNaissance)}"><span class="text-danger">Date de naissance
                              manquante</span><br /></c:if>
                          <c:if test="${(empty formulaire.genreId)}"><span class="text-danger">Genre non
                              indiquÃ©</span><br /></c:if>
                          <c:if test="${(empty formulaire.mail)}"><span class="text-danger">Adresse mail non
                              indiquÃ©</span><br /></c:if>
                          <c:if test="${(empty formulaire.numeroTel)}"><span class="text-danger">NumÃ©ro de tÃ©lÃ©phone non
                              indiquÃ©</span><br /></c:if>
                          <c:if test="${(empty formulaire.ville)}"><span class="text-danger">Ville
                              manquante</span><br /></c:if>
                          <c:if test="${(empty formulaire.paysId)}"><span class="text-danger">Pays manquant</span><br />
                          </c:if>
                          <c:if test="${(empty formulaire.estBoursier)}"><span class="text-danger">Statut boursier
                              incorrect</span><br /></c:if>
                          <c:if test="${(empty formulaire.estPmr)}"><span class="text-danger">Statut PMR
                              incorrect</span><br /></c:if>
                          <c:if test="${(empty formulaire.souhaitId)}"><span class="text-danger">Souhait non
                              formulÃ©</span><br /></c:if>
                          <c:if test="${(! empty formulaire.dateValidation)}"><span class="text-primary">Soumis le :
                              <fmt:formatDate value='${formulaire.dateValidation}' pattern='dd/MM/yyyy HH:mm:ss' />
                            </span><br /></c:if>
>>>>>>> mich
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
                                <button name="reinitialiser" class="btn btn-danger"
                                  onclick="return checkSubmit('check_${formulaire.formulaireId}', 'RÃ©initialiser le mot de passe ?');">
                                  <img src="img/return.png" class="icon" alt="Reinitialiser" />
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
        });
      </script>
    </body>

<<<<<<< HEAD
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
    <script type="text/javascript">
 $(document).ready(function () {
    var table = $('#StudentList').DataTable({
        columnDefs: [
            { targets: 0, visible: false } 
        ],
        order: [[0, 'asc'], [2, 'asc']] 
    });

    function applySorting() {
        var selectedEtats = $('.etat-checkbox:checked').map(function () {
            return $(this).val();
        }).get();

        table.rows().every(function () {
            var row = this.node();
            var etat = $(row).find('td[data-etat]').attr('data-etat');
            
            var index = selectedEtats.indexOf(etat);
            
           
            var priorityValue = (index !== -1) ? index : 99;

            table.cell(this.index(), 0).data(priorityValue);
        });

        table.draw();
    }

    $('#etatFilterBtn').on('click', function (e) {
        e.stopPropagation();
        $('#etatFilterDropdown').toggle();
    });

    $(document).on('click', function () {
        $('#etatFilterDropdown').hide();
    });

    $('#etatFilterDropdown').on('click', function (e) {
        e.stopPropagation(); // EmpÃªche la fermeture quand on clique sur un label
    });

    // Trigger quand on coche/dÃ©coche
    $('.etat-checkbox').on('change', function () {
        applySorting();
    });

    // Appel initial
    applySorting();
});
  </script>
  </body>
</html>
=======
    </html>
>>>>>>> mich
