<%-- 
    Document   : passwrodreset
    Created on : 10 Feb 2025, 16:27:44
    Author     : samer
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr-fr">
    <head>
        <title>Réinitialisation du mot de passe</title>
        <meta charset="UTF-8"/>
        <link href="css/index.css" type="text/css" rel="stylesheet"/>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
                position: relative;
            }
            #boite {
                background: #003366; /* Dark blue (Centrale Nantes style) */
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
                text-align: center;
                max-width: 400px;
                color: #ffffff; /* Light text */
            }

            p {
                font-size: 16px;
                color: #f1f1f1; /* Light gray for readability */
                margin: 10px 0;
            }
            .return-btn {
                position: absolute;
                top: 20px;
                left: 20px;
                background-color: #FFD700; /* Yellow button */
                color: #003366; /* Dark blue text */
                border: none;
                padding: 8px 12px;
                border-radius: 5px;
                text-decoration: none;
                font-size: 14px;
                cursor: pointer;
                transition: background 0.3s ease;
                font-weight: bold;
            }
            .return-btn:hover {
                background-color: #e6c200;
            }
        </style>
    </head>
    <body>
    <a href="index.do" class="return-btn">⬅ Retour</a>
    
    <div id="boite">
        <h1>Réinitialisation du mot de passe</h1>

        <!-- Formulaire POST pour le reset -->
        <form method="post" action="submitpasswordreset.do">
            <div class="form-group row">
                <div class="col-10">
                    <input type="text" class="form-control" id="mySCEI"
                           placeholder="Votre numéro SCEI" name="scei" required>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-10">
                    <input type="text" class="form-control" id="myMail"
                           placeholder="Votre mail" name="mail" required>
                </div>
            </div>
            <div class="text-center">
                <button type="submit" class="Enregistrer" 
                        style="background-color:lightgreen; cursor:pointer;">
                    Submit
                </button>
            </div>
        </form>

        <!-- Affichage message d'erreur ou de succès -->
        <c:if test="${param.success != null}">
            <p style="color:green;text-align:center;">${param.success}</p>
        </c:if>
        <c:if test="${param.error != null}">
            <p style="color:red;text-align:center;">${param.error}</p>
        </c:if>
    </div>
</body>
</html>



