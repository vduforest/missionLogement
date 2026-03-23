<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr-fr">

<head>
    <title>Lien Expiré - Mission Logement</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- External CSS -->
    <link href="bootstrap/css/bootstrap.css" type="text/css" rel="stylesheet" />
    <link href="css/default.css" type="text/css" rel="stylesheet" />
    <link href="css/header.css" type="text/css" rel="stylesheet" />
    
    <style>
        .expiry-container {
            text-align: center;
            padding: 2rem 1rem;
        }
        
        .expiry-icon {
            width: 80px;
            height: 80px;
            margin-bottom: 2rem;
            opacity: 0.8;
        }
        
        .expiry-title {
            color: var(--brand-blue);
            font-weight: 700;
            margin-bottom: 1.5rem;
        }
        
        .expiry-message {
            font-size: 1.15rem;
            color: #4a5568;
            line-height: 1.7;
            margin-bottom: 2.5rem;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
        }
        
        .action-links {
            display: flex;
            justify-content: center;
            gap: 15px;
            flex-wrap: wrap;
        }

        .btn-home {
            background-color: var(--brand-blue) !important;
            color: white !important;
            min-width: 200px;
        }

        .btn-home:hover {
            background-color: var(--brand-yellow) !important;
            color: var(--brand-blue) !important;
        }
    </style>
</head>

<body>
    <!-- Simple Header (No navigation if session might be dead) -->
    <header class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap p-0 shadow">
        <div class="navbar-brand col-md-3 col-lg-2 mr-0 px-3 d-flex align-items-center">
            <img src="img/ecn_blanc.png" alt="ECN Logo" style="height: 30px; margin-right: 15px;">
            <span style="font-family: 'Titillium Web', sans-serif; font-weight: 700; letter-spacing: 1px;">MISSION LOGEMENT</span>
        </div>
    </header>

    <div class="main-container">
        <div class="info-card">
            <div class="expiry-container">
                <img src="img/warning.png" alt="Expiré" class="expiry-icon" />
                
                <h2 class="expiry-title">Lien de connexion expiré</h2>
                
                <div class="expiry-message">
                    <p>Désolé, votre jeton de sécurité (token) a expiré pour des raisons de sécurité.</p>
                    <p>Veuillez <strong>réinitialiser votre mot de passe</strong> pour recevoir un nouveau lien ou contactez la <strong>Mission Logement</strong> pour obtenir de l'aide.</p>
                </div>
                
                <div class="action-links">
                    <a href="index.do" class="custom-button btn-home text-decoration-none">
                        Retour à l'accueil
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer or contact info if needed -->
    <div class="text-center mt-4 text-muted" style="font-size: 0.85rem;">
        &copy; 2026 Ecole Centrale Nantes - Mission Logement
    </div>

</body>

</html>
