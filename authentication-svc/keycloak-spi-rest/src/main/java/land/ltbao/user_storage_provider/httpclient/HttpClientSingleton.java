package land.ltbao.user_storage_provider.httpclient;

import org.apache.hc.client5.http.impl.classic.CloseableHttpClient;
import org.apache.hc.client5.http.impl.classic.HttpClients;
import org.jboss.logging.Logger;
import java.io.IOException;

import org.apache.hc.client5.http.config.RequestConfig;
import org.apache.hc.core5.util.TimeValue;
import org.apache.hc.core5.util.Timeout;


import org.apache.hc.client5.http.impl.io.PoolingHttpClientConnectionManager;

public class HttpClientSingleton {
    private static final Logger logger = Logger.getLogger(HttpClientSingleton.class);
    private static volatile CloseableHttpClient httpClient;
    private static RequestConfig requestConfig = null;
    private static PoolingHttpClientConnectionManager pool = null;
    // Private constructor to prevent instantiation
    private HttpClientSingleton() {}

    public static CloseableHttpClient getInstance(int requestTimeout, int responseTimeout, int maxRetry, int retryInterval, int maxConnection, int connPerRoute, int connectionTimeout) {
        if (httpClient == null) {
            synchronized (HttpClientSingleton.class) {
                if (httpClient == null) {
                    requestConfig = RequestConfig.custom()
                    .setConnectionRequestTimeout(Timeout.ofSeconds(requestTimeout))
                    .setResponseTimeout(Timeout.ofSeconds(responseTimeout))
                    .build();
                    pool = new PoolingHttpClientConnectionManager();
                    pool.setMaxTotal(maxConnection);
                    pool.setDefaultMaxPerRoute(connPerRoute);
                    httpClient = HttpClients.custom().setConnectionManager(pool)
                    .evictIdleConnections(TimeValue.ofSeconds(connectionTimeout))
                    .setRetryStrategy(new CustomHanlerHttpRequest(maxRetry,TimeValue.ofSeconds(retryInterval)))
                    .setDefaultRequestConfig(requestConfig).build();
                }
            }
        }
        return httpClient;
    }    
    public static CloseableHttpClient getInstance() {
        if (httpClient == null) {
            throw new IllegalStateException("HttpClient not yet initialized. Call getInstance with parameters first.");
        }
        return httpClient;
    }

    public static void closeClient() {
        if (httpClient != null) {
            try {
                httpClient.close();
                logger.info("HttpClient has been closed.");
            } catch (IOException e) {
                logger.info("Failed to closed HttpClient: " + e);
            } 
        }
    }
}
