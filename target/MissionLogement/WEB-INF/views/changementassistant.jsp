
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c"   uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr-fr">
    <head>
        <title> Create / Edit User page </title>
        <meta charset="UTF-8"/>
        <link href="css/changementassistant.css" type="text/css" rel="stylesheet" />

        
    </head>
    <body>
        <h1>Create / Edit Assistant</h1>
        <form action="saveassistant.do" method="POST">
            <input type="hidden" name="connexionId" value="${connexionId}" />
        <table>
            <tr>
                <th>assistant </th>
                <td>
                    <c:choose>
                        <c:when test="${(empty user) || (empty user.personneId)}">
                            <input type="hidden" name="id" value="-1" />
                        </c:when>
                        <c:otherwise>
                            <input type="hidden" name="id" value="${user.personneId}" />
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            
            <tr>
                <th>Prenom</th>
                <td><input type="text" class="form-control" name="FirstName" value="${user.prenom}"></td>
            </tr>
            <tr>
                <th>Nom</th>
                <td><input type="text" class="form-control" name="LastName" value="${user.nom}"></td>
            </tr>
            <tr>
                <th>Login</th>
                <td><input type="text" class="form-control" name="Login" value="${user.login}"></td>
            </tr>

            <tr>
                <th>Mot de passe</th>
                <td>
                    <c:choose>
                        <c:when test="${(empty user) || (empty user.personneId)}">
                            <input type="text" class="form-control" name="Password" value="${user.password}">
                        </c:when>
                        <c:otherwise>
                            <span style="font-style: italic;">Créer un nouvel assistant pour changer le mot de passe</span>
                        </c:otherwise>
                    </c:choose>                                                          
                </td>
            </tr>

            <tr>
                <th colspan="2" >                 
                    <button>
                        Save
                    </button>
                </th>               
            </tr> 
    </body> 
</html>