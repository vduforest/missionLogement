<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html lang="fr-fr">
<head>
  <title>DOSSIERS</title>
  <meta charset="UTF-8"/>

  <!-- jQuery -->
  <script src="${pageContext.request.contextPath}/js/jquery-3.6.1.min.js"></script>

  <!-- Bootstrap -->
  <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.js"></script>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.css">

  <!-- Local -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/default.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pageDossiers.css?v=1">

  <script src="${pageContext.request.contextPath}/js/alerte.js"></script>

  <!-- DataTables -->
  <script src="${pageContext.request.contextPath}/js/mainDataTables.js"></script>

  <link rel="stylesheet" href="${pageContext.request.contextPath}/dataTables/css/jquery.dataTables.css"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dataTables/css/buttons.dataTables.css"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dataTables/css/responsive.dataTables.min.css"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dataTables/css/rowReorder.dataTables.min.css"/>

  <script src="${pageContext.request.contextPath}/dataTables/js/jquery.dataTables.js"></script>
  <script src="${pageContext.request.contextPath}/dataTables/js/dataTables.buttons.js"></script>
  <script src="${pageContext.request.contextPath}/dataTables/js/buttons.html5.js"></script>
  <script src="${pageContext.request.contextPath}/dataTables/js/buttons.print.js"></script>
  <script src="${pageContext.request.contextPath}/dataTables/js/dataTables.select.js"></script>
  <script src="${pageContext.request.contextPath}/dataTables/js/dataTables.responsive.min.js"></script>
  <script src="${pageContext.request.contextPath}/dataTables/js/dataTables.rowReorder.min.js"></script>

  <script>
    function checkSubmit(formId, msg) {
      var result = confirm(msg);
      var formRef = document.getElementById(formId);
      if ((formRef !== null) && (result)) {
        formRef.submit();
        return true;
      }
      return false;
    }
  </script>
</head>

<body>
  <!-- Header -->
  <jsp:include page="/WEB-INF/views/header.jsp"/>

  <!-- Main -->
  <div class="py-3">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <h2 style="position:relative">
            Liste des dossiers transmis

            <form method="post"
                  action="${pageContext.request.contextPath}/dossiers.do"
                  style="position:absolute; right:0; top:0;">
              <input type="hidden" name="connexionId" value="${connexionId}" />
              <button class="btn btn-secondary" type="submit">Refresh</button>
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
                <c:forEach var="formulaire" items="${forms}">
                  <tr>
                    <td class="text-center">${formulaire.numeroScei}</td>
                    <td class="text-center">${formulaire.personneId.nom}</td>
                    <td class="text-center">${formulaire.personneId.prenom}</td>

                    <td class="text-center">
                      <c:choose>
                        <c:when test="${formulaire.estConforme}">
                          <img src="${pageContext.request.contextPath}/img/coche.png" alt="coche" class="icon"/>
                        </c:when>

                        <c:when test="${(!formulaire.estValide) && (! empty formulaire.commentairesVe)}">
                          <img
                            onclick="afficherTexte(${formulaire.estBoursier},${formulaire.estPmr},${formulaire.genreId.genreId},${formulaire.genreAttendu.genreId});"
                            src="${pageContext.request.contextPath}/img/red-x-icon.png"
                            alt="refus"
                            class="icon"
                          />
                        </c:when>

                        <c:when test="${(formulaire.estPmr) || (formulaire.estBoursier) || (formulaire.genreId.genreId!=formulaire.genreAttendu.genreId)}">
                          <img
                            onclick="afficherTexte(${formulaire.estBoursier},${formulaire.estPmr},${formulaire.genreId.genreId},${formulaire.genreAttendu.genreId});"
                            src="${pageContext.request.contextPath}/img/warning.png"
                            alt="warning"
                            class="icon"
                          />
                        </c:when>

                        <c:otherwise>
                          A traiter
                        </c:otherwise>
                      </c:choose>
                    </td>

                    <td class="text-center">
                      <c:if test="${(! empty formulaire.estBoursier) && (formulaire.estBoursier)}">
                        Boursier<br/>
                        <c:if test="${! formulaire.hasBourseFile()}">
                          <span class="text-danger">Preuve manquante</span><br/>
                        </c:if>
                      </c:if>

                      <c:if test="${(! empty formulaire.estPmr) && (formulaire.estPmr)}">
                        Nécessite aménagement<br/>
                      </c:if>

                      <c:if test="${(! empty formulaire.paysId) && (formulaire.paysId.paysId != 1)}">
                        Localisation : ${formulaire.paysId.paysNom}<br/>
                      </c:if>

                      <c:if test="${(empty formulaire.dateDeNaissance)}"><span class="text-danger">Date de naissance manquante</span><br/></c:if>
                      <c:if test="${(empty formulaire.genreId)}"><span class="text-danger">Genre non indiqué</span><br/></c:if>
                      <c:if test="${(empty formulaire.mail)}"><span class="text-danger">Adresse mail non indiqué</span><br/></c:if>
                      <c:if test="${(empty formulaire.numeroTel)}"><span class="text-danger">Numéro de téléphone non indiqué</span><br/></c:if>
                      <c:if test="${(empty formulaire.ville)}"><span class="text-danger">Ville manquante</span><br/></c:if>
                      <c:if test="${(empty formulaire.paysId)}"><span class="text-danger">Pays manquant</span><br/></c:if>
                      <c:if test="${(empty formulaire.estBoursier)}"><span class="text-danger">Statut boursier incorrect</span><br/></c:if>
                      <c:if test="${(empty formulaire.estPmr)}"><span class="text-danger">Statut PMR incorrect</span><br/></c:if>
                      <c:if test="${(empty formulaire.souhaitId)}"><span class="text-danger">Souhait non formulé</span><br/></c:if>

                      <c:if test="${(! empty formulaire.dateValidation)}">
                        <span class="text-primary">
                          Soumis le :
                          <fmt:formatDate value='${formulaire.dateValidation}' pattern='dd/MM/yyyy HH:mm:ss'/>
                        </span><br/>
                      </c:if>
                    </td>

                    <td class="text-center">
                      <div class="row">
                        <div class="col-md-6">
                          <form action="${pageContext.request.contextPath}/formulaireVe.do" method="POST">
                            <input type="hidden" name="connexionId" value="${connexionId}" />
                            <input type="hidden" name="formulaireId" value="${formulaire.formulaireId}" />
                            <button name="edit" class="btn btn-primary" type="submit">
                              <img src="${pageContext.request.contextPath}/img/show.png" alt="show" class="icon"/>
                            </button>
                          </form>
                        </div>

                        <div class="col-md-6">
                          <form action="${pageContext.request.contextPath}/AnnulerPwd2.do"
                                id="check_${formulaire.formulaireId}"
                                method="POST">
                            <input type="hidden" name="connexionId" value="${connexionId}" />
                            <input type="hidden" name="formulaireId" value="${formulaire.formulaireId}" />
                            <input type="hidden" name="id" value="${formulaire.formulaireId}" />

                            <button name="reinitialiser"
                                    class="btn btn-danger"
                                    type="submit"
                                    onclick="return checkSubmit('check_${formulaire.formulaireId}', 'Réinitialiser le mot de passe ?');">
                              <img src="${pageContext.request.contextPath}/img/return.png" class="icon" alt="Reinitialiser"/>
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
                  <td></td><td></td><td></td><td></td>

                  <td class="text-center">
                    <form action="${pageContext.request.contextPath}/allDossiers.do" method="POST">
                      <input type="hidden" name="connexionId" value="${connexionId}" />
                      <button id="allDossiers" type="submit">Voir tous les dossiers</button>
                    </form>
                  </td>

                  <td class="text-center">
                    <form action="${pageContext.request.contextPath}/export.do" method="POST">
                      <input type="hidden" name="connexionId" value="${connexionId}" />
                      <button id="export" type="submit">Exporter les dossiers</button>
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
      // ton code DataTables si tu veux le réactiver, sinon laisse vide
    });
  </script>
</body>
</html>
