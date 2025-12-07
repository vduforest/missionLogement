<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr-fr">
<head>
    <title>Réinitialisation du mot de passe</title>
    <meta charset="UTF-8"/>
    <link href="css/first_connexion.css" type="text/css" rel="stylesheet"/>
    <link href="bootstrap/css/bootstrap-reboot.min.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="js/jquery-3.6.1.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <script type="text/javascript" src="js/errorFirstConnection.js"></script>
</head>
<body>
    <div id="centrage">
        <h1>Réinitialisation du mot de passe</h1>
        <div class="row">
            <div class="col-md-12">
                <form action="submitnewpassword.do" method="post" id="form">
                    <input type="hidden" value="<%= request.getParameter("token") %>" name="token"/>

                    <div class="form-group row">
                        <div class="col-10">
                            <input type="password" class="form-control" id="password"
                                   placeholder="Nouveau mot de passe" name="password" required="required">
                        </div>
                    </div>
                    <p class="space"></p>
                    <div class="form-group row">
                        <div class="col-10">
                            <input type="password" class="form-control" id="confirmPassword"
                                   placeholder="Confirmer le mot de passe" name="confirmPassword" required="required">
                        </div>
                    </div>
                    <p class="space"></p>
                    
                    <div id="boiteMessageAttention">
                        <p id="messageAttention">
                            Assurez-vous de choisir un mot de passe sécurisé.
                        </p>
                    </div>

                    <button type="submit" class="btn btn-success">Valider</button>

                    <div class="erreur">
                        <script>
                            function validateForm() {
                                var password = document.getElementById("password").value;
                                var confirmPassword = document.getElementById("confirmPassword").value;
                                if (password !== confirmPassword) {
                                    document.getElementById("messageAttention").innerText = "Les mots de passe ne correspondent pas.";
                                    return false;
                                }
                                return true;
                            }
                            document.getElementById("form").onsubmit = validateForm;
                        </script>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
