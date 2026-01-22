<%-- 
    Document   : pageAssistant
    Created on : 16 déc. 2024, 15:24:40
    Author     : clesp
--%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang='fr-fr'>
    <head>
        <title>ASSITANTS</title>
        <meta charset="UTF-8"/>

        <script src="js/default.js"type="text/javascript"></script>
        <script src="js/jquery-3.6.1.min.js"type="text/javascript"></script>
        <script src="bootstrapt/js/bootstrap.js"tpye="text/javascript"></script>

        <link href="bootstrap/css/bootstrap.css"type="text/css"rel="stylesheet"/>
        <link href="css/pageAssistants.css"type="text/css"rel="stylesheet"/>
        <link href="css/default.css"type="text/css"rel="stylesheet"/>
        <link href="css/header.css" type="text/css" rel="stylesheet"/>

    </head>

    <body>

        <jsp:include page="/WEB-INF/views/header.jsp"/>

        <div class="py-3">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <h2 class="">Liste des assistants</h2>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th scope="col"class="text-center">Numero</th>
                                        <th scope="col"class="text-center">Nom</th>
                                        <th scope="col"class="text-center">Prenom</th>
                                        <th scope="col"class="text-center">Login</th>
                                        <th scope="col"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="assist" items="${assistants}">
                                    <tr>
                                        <td scope="col"class="text-center">${assist.personneId}</td>
                                        <td class="text-center">${assist.nom}</td>
                                        <td class="text-center">${assist.prenom}</td>
                                        <td class="text-center">${assist.login}</td>
                                        <td class="text-center">

                                            
                                                

                                            <form action="editAssistant.do"method="POST">
                                                <input type="hidden" name="connexionId" value="${connexionId}" />
                                                <input type="hidden" name="id" value="${assist.personneId}" />

                                                <button name="edit"class="btn"><img src="img/edit.png"alt="edit"class="icon"/></button>
                                                <button name="delete"class="btn" onClick="deleteAssistant(1,this);return false;"><img src="img/delete.png"alt="delete"class="icon"/></button>
                                            </form>
                                        </td>
                                    </tr>
                                    </c:forEach>
                                </tbody>
                                <tfoot>
                                    <form action="creatuser.do" >
                                        <input type="hidden" name="connexionId" value="${connexionId}" />
                                        <td class="text-center"scope="col"colspan=4><button type="submit" name="create" class="btn">Créer un nouvel assistant</a></button></td>
                                    </form>
                                    </tr>
                                </tfoot>
</html>

