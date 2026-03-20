<%-- 
    Document   : pageAttente
    Created on : 6 févr. 2025, 10:56:45
    Author     : Amolz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr-fr">
    <head>
        <title>Mission Logement - Information</title>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="bootstrap/css/bootstrap.css" type="text/css" rel="stylesheet"/>
        <link href="css/header.css" type="text/css" rel="stylesheet" />
        <link href="css/default.css" type="text/css" rel="stylesheet"/>
        <link href="css/page_attente.css" type="text/css" rel="stylesheet"/>
    </head>

    <body>
        <c:set var="backLink" value="informations.do" scope="request" />
        <jsp:include page="/WEB-INF/views/header.jsp" />
        
        <div class="main-container d-flex justify-content-center align-items-center" style="min-height: 80vh;">
            <div class="info-card text-center p-5">
                <p class="texteAttente">${message}</p>
                <form action="informations.do" method="POST" class="mt-4">
                    <input type="hidden" name="connexionId" value="${connexionId}" />
                    <button type="submit" class="custom-button">Retour</button>
                </form>
            </div>
        </div>    
    </body>
</html>
