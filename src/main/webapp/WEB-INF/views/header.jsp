<%@ page contentType="text/html;charset=UTF-8" %>

  <div id="header">
    <nav class="navbar navbar-expand-md navbar-dark bg-dark">
      <div class="container">

        <form method="POST" class="w-100">
          <input type="hidden" name="connexionId" value="${connexionId}" />

          <div class="d-flex align-items-center justify-content-between w-100">

            <!-- LEFT: return + Centrale logo -->
            <div class="d-flex align-items-center">

              <!-- RETURN BUTTON -->
              <button type="button" class="return-btn" onclick="history.back()" title="Retour">
                <img src="img/return.png" alt="Retour" class="return-img" />
              </button>

              <!-- LOGO -->
              <button class="p-0 ml-3 bg-transparent border-0" formaction="adminDashboard.do"
                style="display:flex; align-items:center;">
                <img src="img/ecn_blanc.png" alt="logo" class="logo" />
              </button>
            </div>

            <!-- CENTER TITLE -->
            <h1 class="m-0 text-warning text-center flex-grow-1">
              Plateforme Mission Logement
            </h1>

            <!-- RIGHT EXIT -->
            <button class="p-0 bg-transparent border-0 exit-btn" formaction="index.do"
              style="display:flex; align-items:center; justify-content:center;">
              <img src="img/porteOuverte.png" alt="sortie" class="sortie" />
            </button>


          </div>
        </form>

      </div>
    </nav>
  </div>