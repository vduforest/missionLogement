<%@ page contentType="text/html;charset=UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <div id="header">
      <nav class="navbar navbar-expand-md navbar-dark bg-dark">
        <div class="container">

          <form method="POST" class="w-100">
            <input type="hidden" name="connexionId" value="${connexionId}" />

            <div class="d-flex align-items-center justify-content-between w-100">

              <div class="d-flex align-items-center">

                <c:if test="${(empty hideBackButton or not hideBackButton) and not empty backLink}">
                  <button type="submit" class="return-btn" formaction="${backLink}" title="Retour">
                    <img src="img/return.png" alt="Retour" class="return-img" />
                  </button>
                </c:if>

                <button class="p-0 ml-3 bg-transparent border-0"
                  formaction="${not empty homeLink ? homeLink : ((not empty connexion && connexion.isAdmin()) ? 'adminDashboard.do' : ((not empty connexion && connexion.isAssistant()) ? 'dossiersAssist.do' : 'informations.do'))}"
                  style="display:flex; align-items:center;">
                  <img src="img/ecn_blanc.png" alt="logo_ecole_centrale_nantes" class="logo" />
                </button>
              </div>

              <h1 class="m-0 text-warning text-center flex-grow-1 px-1 px-md-3">
                <span class="d-none d-sm-inline">Plateforme </span>Mission Logement
              </h1>

              <button class="p-0 bg-transparent border-0 exit-btn" formaction="index.do"
                style="display:flex; align-items:center; justify-content:center;">
                <img src="img/porteOuverte.png" alt="sortie" class="sortie" />
              </button>

            </div>
          </form>

        </div>
      </nav>
    </div>