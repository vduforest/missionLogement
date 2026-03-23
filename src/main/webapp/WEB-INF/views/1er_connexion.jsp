<%-- 
    Document   : 1_connexion
    Created on : 10 mars 2025, 14:10:06
    Author     : barbo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>JSP Page</title>
        <link href="css/first_connexion_1.css" type="text/css" rel="stylesheet"/>
        <link href="bootstrap/css/bootstrap-reboot.min.css" type="text/css" rel="stylesheet"/>
    </head>
    <body>
        <div id="centrage">
            <h1>Veuillez entrer votre adresse mail renseigné sur scei</h1>
            <div class="row">
                <div class="col-md-12">
                    <form action="verificationdumail.do" method="GET" id="form">
                        <div class="form-group row">
                            <div class="col-10">
                                <input type="text" class="form-control" id="mail"
                                placeholder="Email" name="mail" required="required">
                            </div>
                        <button type="submit" class="btn btn-success" onclick="this.disabled=true; this.innerHTML='<span class=\"spinner-border spinner-border-sm\" role=\"status\" aria-hidden=\"true\"></span> Validation...'; this.form.submit();">Valider</button>
                        <div class="erreur"> 
                            <script>error(${error});</script>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
