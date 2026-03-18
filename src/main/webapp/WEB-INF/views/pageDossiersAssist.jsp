<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang='fr-fr'>

    <head>
        <title>DOSSIERS</title>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <script type="text/javascript" src="js/jquery-3.6.1.min.js"></script>

        <!--Boostrap-->
        <script src="bootstrap/js/bootstrap.js" type="text/javascript"></script>
        <script src="js/alerte.js" type="text/javascript"></script>
        <link href="bootstrap/css/bootstrap.css" type="text/css" rel="stylesheet" />

        <!--Local-->
        <link href="css/default.css" type="text/css" rel="stylesheet" />
        <link href="css/pageDossiers.css" type="text/css" rel="stylesheet" />
        <link href="css/header.css" type="text/css" rel="stylesheet" />


        <!--Datatable-->
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

    </head>

    <body>
        <jsp:include page="/WEB-INF/views/header.jsp" />
        <!-- Main Section -->
        <div class="py-3">
            <div class="container">
                <div class="row mb-2 align-items-end">
                    <div class="col-md-12 d-flex justify-content-between align-items-center">
                        <h2 class="m-0">Liste des dossiers transmis</h2>
                        <form method="post" action="dossiersAssist.do" class="m-0">
                            <input type="hidden" name="connexionId" value="${connexionId}" />
                            <button class="refresh-btn" title="Rafraîchir">
                                <img src="img/refresh.png" alt="Refresh" class="refresh-icon" /> Rafraîchir
                            </button>
                        </form>
                    </div>
                </div>

                <c:if test="${not empty confirmationMessage}">
                    <div id="popupMessage"
                         style="display: block; position: fixed; bottom: 20px; left: 20px; background-color: #4CAF50; color: white; padding: 10px; border-radius: 5px;">
                        ${confirmationMessage}
                    </div>
                    <script type="text/javascript">
                        setTimeout(function () {
                            document.getElementById("popupMessage").style.display = 'none';
                        }, 5000);
                    </script>
                </c:if>

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
                                                <c:if test="${(empty formulaire.genreId)}"><span class="text-danger">Genre non
                                                        indiqu�</span><br /></c:if>
                                                <c:if test="${(empty formulaire.mail)}"><span class="text-danger">Adresse mail non
                                                        indiqu�</span><br /></c:if>
                                                <c:if test="${(empty formulaire.numeroTel)}"><span class="text-danger">Num�ro de t�l�phone
                                                        non indiqu�</span><br /></c:if>
                                                <c:if test="${(empty formulaire.ville)}"><span class="text-danger">Ville
                                                        manquante</span><br /></c:if>
                                                <c:if test="${(empty formulaire.paysId)}"><span class="text-danger">Pays
                                                        manquant</span><br /></c:if>
                                                <c:if test="${(empty formulaire.estBoursier)}"><span class="text-danger">Statut boursier
                                                        incorrect</span><br /></c:if>
                                                <c:if test="${(empty formulaire.estPmr)}"><span class="text-danger">Statut PMR
                                                        incorrect</span><br /></c:if>
                                                <c:if test="${(empty formulaire.souhaitId)}"><span class="text-danger">Souhait non
                                                        formul�</span><br /></c:if>
                                                <c:if test="${(! empty formulaire.dateValidation)}"><span class="text-primary">Soumis le :
                                                        <fmt:formatDate value='${formulaire.dateValidation}' pattern='dd/MM/yyyy HH:mm:ss' />
                                                    </span><br /></c:if>
                                                </td>
                                                <td class="text-center">
                                                    <form action="formulaireVe.do" method="POST">
                                                        <input type="hidden" name="connexionId" value="${connexionId}" />
                                                    <input type="hidden" name="formulaireId" value="${formulaire.formulaireId}" />
                                                    <button name="edit" class="btn btn-primary">
                                                        <img src="img/show.png" alt="show" class="icon" />
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="5"></td>
                                        <td>
                                            <form action="allDossiers.do" method="POST">
                                                <input type="hidden" name="connexionId" value="${connexionId}" />
                                                <button id="allDossiers">Voir tous les dossiers</button>
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
                    if ((theId !== null) && (typeof theId) !== 'undefined') && (theId !== "") {
                        var title = $(this).text();
                        $(this).html('<input type="text" name="search_' + theId + '" placeholder="' + title + '" value=""/>');
                    }
                });
                /*
                 addDataTableButtonNew("Etudiants");
                 setDataTableRemovePaginate();
                 vat table = buildTable(tableName);
                 
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