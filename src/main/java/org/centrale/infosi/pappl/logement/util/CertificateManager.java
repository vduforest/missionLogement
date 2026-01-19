/* -----------------------------------------
 * Projet Kepler
 *
 * Ecole Centrale Nantes
 * Jean-Yves MARTIN
 * ----------------------------------------- */
package org.centrale.infosi.pappl.logement.util;

import java.net.Socket;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.cert.X509Certificate;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLEngine;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509ExtendedTrustManager;

/**
 *
 * @author kwyhr
 */
public class CertificateManager {

    private static SSLContext sslContext = null;

    public static SSLContext getSSLContext() {
        if (sslContext == null) {
            X509ExtendedTrustManager trustManager = new X509ExtendedTrustManager() {
                @Override
                public X509Certificate[] getAcceptedIssuers() {
                    return new X509Certificate[]{};
                }

                @Override
                public void checkClientTrusted(X509Certificate[] chain, String authType) {
                }

                @Override
                public void checkServerTrusted(X509Certificate[] chain, String authType) {
                }

                @Override
                public void checkClientTrusted(X509Certificate[] chain, String authType, Socket socket) {
                }

                @Override
                public void checkServerTrusted(X509Certificate[] chain, String authType, Socket socket) {
                }

                @Override
                public void checkClientTrusted(X509Certificate[] chain, String authType, SSLEngine engine) {
                }

                @Override
                public void checkServerTrusted(X509Certificate[] chain, String authType, SSLEngine engine) {
                }
            };

            try {
                sslContext = SSLContext.getInstance("TLS");
                sslContext.init(null, new TrustManager[]{trustManager}, new SecureRandom());
            } catch (NoSuchAlgorithmException | KeyManagementException ex) {
                System.getLogger(CertificateManager.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
            }
        }

        return sslContext;
    }
}
