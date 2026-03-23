<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c"   uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr-fr">
    <head>
        <title>Mission Logement - Gestion Assistant</title>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        
        <!-- Standard Styles -->
        <link href="bootstrap/css/bootstrap.css" type="text/css" rel="stylesheet" />
        <link href="css/default.css" type="text/css" rel="stylesheet" />
        <link href="css/header.css" type="text/css" rel="stylesheet" />
        <link href="css/formulaire.css" type="text/css" rel="stylesheet" />
        <link href="css/changementassistant.css" type="text/css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

        <style>
            .password-field {
                position: relative;
            }

            .password-field input {
                padding-right: 42px;
            }

            .btn-toggle-password {
                position: absolute;
                right: 14px;
                top: 50%;
                transform: translateY(-50%);
                cursor: pointer;
                font-size: 18px;
                color: #555;
                z-index: 2;
                background: none;
                border: none;
                padding: 0;
            }
        </style>
    </head>
    
    <body>
        <c:set var="backLink" value="pageAssistants.do" scope="request" />
        <jsp:include page="/WEB-INF/views/header.jsp" />

        <div class="main-container">
            <div class="info-card">
                
                <div class="form-header mb-5">
                    <c:choose>
                        <c:when test="${(empty user) || (empty user.personneId)}">
                            <h2>Créer un nouvel assistant</h2>
                        </c:when>
                        <c:otherwise>
                            <h2>Modifier l'assistant</h2>
                            <p class="subtitle">${user.prenom} ${user.nom}</p>
                        </c:otherwise>
                    </c:choose>
                </div>

                <form action="saveassistant.do" method="POST">
                    <input type="hidden" name="connexionId" value="${connexionId}" />
                    
                    <c:choose>
                        <c:when test="${(empty user) || (empty user.personneId)}">
                            <input type="hidden" name="id" value="-1" />
                        </c:when>
                        <c:otherwise>
                            <input type="hidden" name="id" value="${user.personneId}" />
                        </c:otherwise>
                    </c:choose>

                    <div class="modern-form-table">
                        
                        <!-- Prénom -->
                        <div class="form-row">
                            <div class="label-col">
                                <label for="FirstName">Prénom</label>
                            </div>
                            <div class="input-col">
                                <input type="text" id="FirstName" name="FirstName" value="${user.prenom}" required="required" placeholder="Prénom de l'assistant">
                            </div>
                        </div>

                        <!-- Nom -->
                        <div class="form-row">
                            <div class="label-col">
                                <label for="LastName">Nom</label>
                            </div>
                            <div class="input-col">
                                <input type="text" id="LastName" name="LastName" value="${user.nom}" required="required" placeholder="Nom de l'assistant">
                            </div>
                        </div>

                        <!-- Login -->
                        <div class="form-row">
                            <div class="label-col">
                                <label for="Login">Login</label>
                            </div>
                            <div class="input-col">
                                <input type="text" id="Login" name="Login" value="${user.login}" required="required" placeholder="Identifiant de connexion">
                            </div>
                        </div>

                        <!-- Mot de passe -->
                        <div class="form-row">
                            <div class="label-col">
                                <label for="Password">Mot de passe</label>
                            </div>
                            <div class="input-col">
                                <c:choose>
                                    <c:when test="${(empty user) || (empty user.personneId)}">
                                        <div class="password-field">
                                            <input type="password" id="Password" name="Password" value="" required="required" placeholder="Définir un mot de passe">
                                            <button type="button" class="btn-toggle-password" onclick="togglePassword('Password', this)" aria-label="Afficher le mot de passe" aria-pressed="false">
                                                <i class="bi bi-eye-slash" aria-hidden="true"></i>
                                            </button>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="alert alert-info py-2 px-3 mb-0" style="font-size: 0.9rem;">
                                            <i class="info-icon">ℹ️</i> Pour changer le mot de passe, créez un nouvel assistant.
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                    </div>

                    <!-- Actions -->
                    <div class="form-actions text-center mt-5">
                        <div class="buttons-container justify-content-center gap-3">
                            <button type="submit" class="custom-button" onclick="showLoading(this, 'Sauvegarde...')">
                                Sauvegarder
                            </button>
                            
                            <button type="button" class="custom-button" style="background-color: #6c757d; box-shadow: 0 4px 15px rgba(108, 117, 125, 0.3);" onclick="window.location.href='pageAssistants.do?connexionId=${connexionId}'">
                                Annuler
                            </button>
                        </div>
                    </div>

                </form>
            </div>
        </div>

        <script>
            function togglePassword(inputId, btn) {
                const input = document.getElementById(inputId);
                const icon = btn.querySelector('i');
                const isVisible = input.type === 'text';

                input.type = isVisible ? 'password' : 'text';
                icon.classList.toggle('bi-eye', isVisible);
                icon.classList.toggle('bi-eye-slash', !isVisible);

                btn.setAttribute('aria-pressed', String(!isVisible));
                btn.setAttribute('aria-label', isVisible ? 'Afficher le mot de passe' : 'Masquer le mot de passe');
            }

            function showLoading(btn, text) {
                if (btn.classList.contains('is-loading')) return false;
                btn.classList.add('is-loading');

                const spinner = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true" style="margin-right: 5px;"></span> ';
                btn.innerHTML = spinner + text;

                // Delay disabling to allow form data capture
                setTimeout(() => {
                    btn.disabled = true;
                }, 10);

                return true;
            }
        </script>
    </body>
</html>
