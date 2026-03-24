<%@page contentType="text/html" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
      <!DOCTYPE html>
      <html lang="fr-fr">

      <head>
        <title>Demande de Logement</title>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="bootstrap/css/bootstrap.css" type="text/css" rel="stylesheet" />
        <link href="css/header.css" type="text/css" rel="stylesheet" />
        <link href="css/default.css" type="text/css" rel="stylesheet" />
        <link href="css/formulaire.css" type="text/css" rel="stylesheet" />

        <script src="js/formulaire.js"></script>
      </head>

      <body>
        <jsp:include page="/WEB-INF/views/header.jsp" />

        <div class="main-container">
          <div class="info-card">

            <c:if test="${not empty confirmationMessage}">
                <div id="popupMessage"
                    style="display: block; position: fixed; bottom: 20px; left: 20px; background-color: #4CAF50; color: white; padding: 10px; border-radius: 5px; z-index: 1000;">
                    ${confirmationMessage}
                </div>
                <script type="text/javascript">
                    setTimeout(function () {
                        const popup = document.getElementById("popupMessage");
                        if (popup) popup.style.display = 'none';
                    }, 5000);
                </script>
            </c:if>

            <div class="form-header">
              <h2>Demande de Logement</h2>
              <p class="subtitle">Résidence Max Schmit</p>
            </div>

            <form id="logementForm" action="SauvegardeFormulaire.do" method="POST" enctype="multipart/form-data">
              <input type="hidden" name="connexionId" value="${connexionId}" />
              <input type="hidden" name="id" value="${item.formulaireId}" />

              <c:if test="${item.estValide == true}">
                <div class="alert alert-success">
                  <b>Dossier soumis.</b> Le formulaire ne peut plus être modifié. La Mission Logement vous contactera.
                </div>
              </c:if>

              <c:if test="${(! empty item.commentairesVe) && (! item.estValide)}">
                <div class="alert alert-danger">
                  <b>Votre dossier doit être complété :</b><br />
                  ${item.commentairesVe}
                </div>
              </c:if>
              <c:if test="${not empty erreurBourse}">
                <div class="alert alert-danger">
                  <b>Pièce justificative manquante :</b><br />
                  ${erreurBourse}
                </div>
              </c:if>

              <div class="modern-form-table">

                <div class="form-row">
                  <div class="label-col">Nom <c:if test="${not empty tooltip_nom}"><span
                          class="tooltip-icon">i<span class="tooltip-text">${tooltip_nom}</span></span></c:if>
                  </div>
                    <div class="input-col"><label for="nom">Nom</label><input type="text" id="nom" name="nom" value="${item.personneId.nom}" readonly
                      class="readonly-input" /></div>
                </div>

                <div class="form-row">
                  <div class="label-col">Prénom <c:if test="${not empty tooltip_prenom}"><span
                          class="tooltip-icon">i<span class="tooltip-text">${tooltip_prenom}</span></span></c:if>
                    </div>
                    <div class="input-col"><label for="prenom">Prénom</label><input type="text" id="prenom" name="prenom" value="${item.personneId.prenom}" readonly
                      class="readonly-input" /></div>
                </div>

                <div class="form-row">
                  <div class="label-col">Date de naissance <c:if test="${not empty tooltip_date_naissance}"><span
                          class="tooltip-icon">i<span class="tooltip-text">${tooltip_date_naissance}</span></span></c:if>
                  </div>
                  <div class="input-col">
                    <label for="date">Date de naissance</label>
                    <input type="text" id="date" value="<fmt:formatDate value='${item.dateDeNaissance}' pattern='dd/MM/yyyy' />"
                      readonly class="readonly-input" />
                    <input type="hidden"  name="dateDeNaissance" value="${item.dateDeNaissance}" />
                  </div>
                </div>

                <div class="form-row">
                  <div class="label-col">Genre <c:if test="${not empty tooltip_genre}"><span
                          class="tooltip-icon">i<span class="tooltip-text">${tooltip_genre}</span></span></c:if>
                  </div>
                  <div class="input-col">
                      <label for="genre">Genre</label>
                    <select name="Genre" id="genre" <c:if test="${item.estValide}"> disabled="disabled"</c:if> required="required"
                      class="monitor-change">
                      <option value=0 ${(empty item.genreId) || (item.genreId.genreId <=0) ? 'selected="selected"' : ''
                        }>Sélectionner...</option>
                      <c:forEach var="genre" items="${genresList}">
                        <option value="${genre.genreId}" ${(! empty item.genreId) &&
                          (genre.genreId==item.genreId.genreId) ? 'selected="selected"' : '' }>${genre.genreNom}
                        </option>
                      </c:forEach>
                    </select>
                  </div>
                </div>

                <div class="form-row">
                  <div class="label-col">Adresse E-mail <c:if test="${not empty tooltip_mail}"><span
                          class="tooltip-icon">i<span class="tooltip-text">${tooltip_mail}</span></span></c:if>
                  </div>
                  <div class="input-col">
                      <label for="mail">mail</label>
                    <input type="text" id="mail" name="mail" value="${item.mail}" placeholder="exemple@ec-nantes.fr"
                      <c:if test="${item.estValide == true}">readonly="readonly" class="readonly-input"</c:if> required="required"
                      oninput="verifMail('mail', 'Confirmmail')" class="monitor-change"/>
                      
                  </div>
                </div>

                <div class="form-row">
                  <div class="label-col">Confirmation E-mail <c:if test="${not empty tooltip_confirm_mail}"><span
                          class="tooltip-icon">i<span class="tooltip-text">${tooltip_confirm_mail}</span></span></c:if>
                    </div>
                  <div class="input-col">
                    <label for="Confirmmail">confirme mail</label>
                    <input type="text" id="Confirmmail" name="Confirmmail" value="${item.mail}"
                      placeholder="Confirmez l'adresse" <c:choose>
                    <c:when test="${item.estValide == true}">readonly="readonly" class="readonly-input"</c:when>
                    <c:otherwise>oninput="verifMail('mail', 'Confirmmail');"</c:otherwise>
                    </c:choose> class="monitor-change"/>
                  </div>
                </div>

                <div class="form-row">
                  <div class="label-col">Téléphone <c:if test="${not empty tooltip_tel}"><span
                          class="tooltip-icon">i<span class="tooltip-text">${tooltip_tel}</span></span></c:if>
                  </div>
                  <div class="input-col">
                    <label for="tel">Téléphone</label>
                        <input type="text" id="tel" name="tel" value="${item.numeroTel}" <c:if
                          test="${item.estValide == true}">readonly="readonly" class="readonly-input"</c:if> required="required"
                        class="monitor-change"/>
                    
                  </div>
                </div>

                <div class="form-row">
                  <div class="label-col">Téléphone 2 (Optionnel) <c:if test="${not empty tooltip_tel2}"><span
                          class="tooltip-icon">i<span class="tooltip-text">${tooltip_tel2}</span></span></c:if>
                  </div>
                  <div class="input-col">
                      <label for="tel2">Téléphone 2</label>
                    <input type="text" name="tel2" id="tel2" value="${item.tel2}" <c:if
                      test="${item.estValide == true}">readonly="readonly" class="readonly-input"</c:if> class="monitor-change"/>
                  </div>
                </div>

                <div class="form-row">
                  <div class="label-col">Ville <c:if test="${not empty tooltip_ville}"><span
                          class="tooltip-icon">i<span class="tooltip-text">${tooltip_ville}</span></span></c:if>
                  </div>
                    
                  <div class="input-col">
                      <label for="ville">Ville</label>
                      <input type="text" id="ville" name="ville" value="${item.ville}" readonly
                      class="readonly-input" /></div>
                </div>
                <div class="form-row">
                  <div class="label-col">Code Postal <c:if test="${not empty tooltip_code_postal}"><span
                          class="tooltip-icon">i<span class="tooltip-text">${tooltip_code_postal}</span></span></c:if>
                    </div>
                  <div class="input-col">
                      <label for="codePostal">Code postal</label>
                      <input type="text" id="codePostal" name="codePostal" value="${item.codePostal}" readonly
                      class="readonly-input" /></div>
                </div>

                <div class="form-row">
                    <div class="label-col">Pays <c:if test="${not empty tooltip_pays}"><span
                            class="tooltip-icon">i<span class="tooltip-text">${tooltip_pays}</span></span></c:if>
                    </div>

                    <div class="input-col">
                      <label for="paysAffichage">Pays</label>
                      <input type="text" id="paysAffichage"
                             value="${not empty item.paysId ? item.paysId.paysNom : ''}"
                             readonly class="readonly-input" />

                      <!-- important : champ envoyé au backend -->
                      <input type="hidden" id="pays" name="pays"
                             value="${not empty item.paysId ? item.paysId.paysId : ''}" />
                    </div>
                </div>

                <div class="form-row">
                  <div class="label-col">Êtes-vous boursier ? <c:if test="${not empty tooltip_bourse}"><span
                          class="tooltip-icon">i<span class="tooltip-text">${tooltip_bourse}</span></span></c:if>
                    </div>
                  <div class="input-col">
                    <div class="radio-options">
                        <label
                        for="ouiB">Oui</label>
                      <input onload="sendDocument()" onclick="sendDocument()" type="radio" name="bourse" id="ouiB"
                        value="true" ${item.estBoursier=='true' ? 'checked' : '' } <c:if
                        test="${item.estValide}">disabled</c:if> required class="monitor-change"/> 
                    <label
                        for="nonB">Non</label>
                      <input onload="sendDocument()" onclick="sendDocument()" type="radio" name="bourse" id="nonB"
                        value="false" ${item.estBoursier=='false' ? 'checked' : '' } <c:if
                        test="${item.estValide}">disabled</c:if> required class="monitor-change"/> 
                    </div>
                    <div id="bourseUploadSection" class="mt-2">
                      <c:if test="${(item.estBoursier) && (item.hasBourseFile())}"><span class="badge badge-success">✓
                          Fichier bourse transmis</span><br /></c:if>
                      <label for="preuveBourse">preuve</label>
                      <input type="file" id="preuveBourse" name="preuveBourse"
                      class="form-control-file mt-2 monitor-change" accept="image/png,image/jpeg,application/pdf"
                      style="display: none;" />
                    </div>
                  </div>
                </div>

                <div class="form-row">
                  <div class="label-col">Préférence logement <c:if test="${not empty tooltip_souhait}"><span
                          class="tooltip-icon">i<span class="tooltip-text">${tooltip_souhait}</span></span></c:if>
                    </div>
                  <div class="input-col">
                      <label for ="pref_logement">préférence logement</label>
                    <select name="Souhait" id="pref_logement" <c:if test="${item.estValide}"> disabled="disabled"</c:if>
                      required="required" class="monitor-change">
                      <option value=0 ${(empty item.souhaitId) || (item.souhaitId.souhaitId <=0) ? 'selected="selected"'
                        : '' }>Choisir une préférence...</option>
                      <c:forEach var="souhait" items="${souhaitsList}">
                        <option value="${souhait.souhaitId}" ${(! empty item.souhaitId) &&
                          (souhait.souhaitId==item.souhaitId.souhaitId) ? 'selected="selected"' : '' }>
                          ${souhait.souhaitType}</option>
                      </c:forEach>
                    </select>
                  </div>
                </div>

                <div class="form-row">
                  <div class="label-col">Dispositions particulières <br>(PMR, Handicap...) ? <c:if
                        test="${not empty tooltip_pmr}"><span class="tooltip-icon">i<span
                            class="tooltip-text">${tooltip_pmr}</span></span></c:if></div>
                  <div class="input-col radio-options">
                    <input type="radio" name="pmr" id="ouip" value="true" ${item.estPmr=='true' ? 'checked' : '' } <c:if
                      test="${item.estValide}">disabled</c:if> required
                    onclick="document.getElementById('infoSupplementaires').setAttribute('required', 'required');"
                    class="monitor-change"/> <label for="ouip">Oui</label>
                    <input type="radio" name="pmr" id="nonp" value="false" ${item.estPmr=='false' ? 'checked' : '' }
                      <c:if test="${item.estValide}">disabled</c:if> required
                    onclick="document.getElementById('infoSupplementaires').removeAttribute('required');"
                    class="monitor-change"/> <label for="nonp">Non</label>
                  </div>
                </div>

                <div class="form-row">
                  <div class="label-col">Informations Complémentaires <c:if test="${not empty tooltip_infos}"><span
                          class="tooltip-icon">i<span class="tooltip-text">${tooltip_infos}</span></span></c:if>
                  </div>
                  <div class="input-col">
                      <label for="infoSupplementaires">infos supplémentaires</label>
                    <textarea id="infoSupplementaires" name="infoSupplementaires" rows="5" <c:if
                      test="${item.estValide}">readonly class="readonly-input"</c:if> <c:if test="${item.estPmr == 'true'}"> required="required"</c:if> class="monitor-change">${item.commentairesEleve}</textarea>
                  </div>
                </div>

              </div>

              <div class="form-actions text-center">
                <c:choose>
                  <c:when test="${item.estValide == true}">
                  </c:when>
                  <c:otherwise>
                    <div class="warning-message">
                      ⚠️ ATTENTION : Si vous soumettez, vous ne pourrez plus modifier le formulaire.
                    </div>

                    <div class="buttons-container">
                      <button type="submit" name="enregistrer" id="btnSave" class="custom-button btn-save" value="enregistrer">
                        Sauvegarder
                      </button>

                      <button type="submit" id="btnSubmit" name="soumettre" class="custom-button btn-submit-active"
                        value="soumettre">
                        Soumettre
                      </button>
                    </div>
                  </c:otherwise>
                </c:choose>
              </div>

            </form>
          </div>
        </div>

        <script>
          window.onload = function () {
            if (typeof sendDocument === "function") { sendDocument(); }
          };

          function saveScrollPosition() {
            localStorage.setItem("formulaireScrollPos", window.scrollY);
          }

          function showLoading(btn, text) {
            if (btn.classList.contains('is-loading')) return false;

            saveScrollPosition();
            btn.classList.add('is-loading');

            const spinner = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true" style="margin-right: 5px;"></span> ';
            btn.innerHTML = spinner + text;

            // Delay disabling to allow form data capture
            setTimeout(() => {
              const buttons = document.querySelectorAll(".custom-button");
              buttons.forEach(b => {
                if (b !== btn) b.disabled = true;
              });
              btn.disabled = true;
            }, 10);
            
            return true;
          }

          // --- NOUVELLE LOGIQUE JS ---
          document.addEventListener("DOMContentLoaded", function () {
            const scrollPos = localStorage.getItem("formulaireScrollPos");
            if (scrollPos) {
              window.scrollTo(0, parseInt(scrollPos));
              localStorage.removeItem("formulaireScrollPos");
            }

            const btnSubmit = document.getElementById("btnSubmit");
            const btnSave = document.getElementById("btnSave");
            const inputs = document.querySelectorAll(".monitor-change");

            if (btnSave) {
              btnSave.addEventListener("click", function() {
                showLoading(btnSave, "Sauvegarde...");
              });
            }

            if (!btnSubmit) return;

            function disableSubmit() {
              btnSubmit.classList.remove("btn-submit-active");
              btnSubmit.classList.add("btn-submit-disabled");
              btnSubmit.disabled = true;
              btnSubmit.title = "Veuillez sauvegarder avant de soumettre.";
            }

            inputs.forEach(function (input) {
              input.addEventListener("input", disableSubmit);
              input.addEventListener("change", disableSubmit);
            });

            btnSubmit.addEventListener("click", function (event) {
            if (btnSubmit.disabled) {
              event.preventDefault();
              return false;
            }

            const ouiB = document.getElementById("ouiB");
            const preuveBourse = document.getElementById("preuveBourse");
            const dejaTransmis = ${item.hasBourseFile() ? "true" : "false"};

            if (ouiB && ouiB.checked && !dejaTransmis && (!preuveBourse || !preuveBourse.files || preuveBourse.files.length === 0)) {
              event.preventDefault();
              alert("Vous avez indiqué être boursier. Veuillez ajouter une preuve (PDF ou image) avant de soumettre le formulaire.");
              return false;
            }

            const confirmation = confirm("Êtes-vous sûr de vouloir soumettre ?\n\nVous ne pourrez plus modifier vos informations après cette action.");
            if (!confirmation) {
              event.preventDefault();
            } else {
              showLoading(btnSubmit, "Envoi en cours...");
            }
          });
        });
        </script>
      </body>

      </html>