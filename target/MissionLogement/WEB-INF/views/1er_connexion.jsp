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
                        <button type="submit" class="btn btn-success">Valider</button>
                        <div class="erreur"> 
                            <script>error(${error});</script>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
