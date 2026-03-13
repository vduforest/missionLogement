<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr-fr">
<head>
    <title>Réinitialisation du mot de passe</title>
    <meta charset="UTF-8"/>
    <link href="css/first_connexion.css" type="text/css" rel="stylesheet"/>
    <link href="bootstrap/css/bootstrap-reboot.min.css" type="text/css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <script type="text/javascript" src="js/jquery-3.6.1.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <script type="text/javascript" src="js/errorFirstConnection.js"></script>

    <style>
        .password-field {
            position: relative;
        }

        .password-field input {
            padding-right: 42px;
        }

        .toggle-password {
            position: absolute;
            right: 14px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            font-size: 18px;
            color: #555;
            z-index: 2;
        }
    </style>
</head>
<body>
    <div id="centrage">
        <h1>Réinitialisation du mot de passe</h1>
        <div class="row">
            <div class="col-md-12">
                <form action="submitnewpassword.do" method="post" id="form">
                    <input type="hidden" value="<%= request.getParameter("token") %>" name="token"/>

                    <div class="form-group row">
                        <div class="col-10 password-field">
                            <input type="password" class="form-control" id="password"
                                   placeholder="Nouveau mot de passe" name="password" required="required">
                            <i class="bi bi-eye-slash toggle-password"
                               onclick="togglePassword('password', this)"></i>
                        </div>
                    </div>

                    <p class="space"></p>

                    <div class="form-group row">
                        <div class="col-10 password-field">
                            <input type="password" class="form-control" id="confirmPassword"
                                   placeholder="Confirmer le mot de passe" name="confirmPassword" required="required">
                            <i class="bi bi-eye-slash toggle-password"
                               onclick="togglePassword('confirmPassword', this)"></i>
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

    <script>
        function togglePassword(inputId, icon) {
            const input = document.getElementById(inputId);

            if (input.type === "password") {
                input.type = "text";
                icon.classList.remove("bi-eye-slash");
                icon.classList.add("bi-eye");
            } else {
                input.type = "password";
                icon.classList.remove("bi-eye");
                icon.classList.add("bi-eye-slash");
            }
        }
    </script>
</body>
</html>