package land.ltbao.user_storage_provider.httpclient;
import org.apache.hc.client5.http.impl.DefaultHttpRequestRetryStrategy;
import org.apache.hc.core5.http.HttpResponse;
import org.apache.hc.core5.http.protocol.HttpContext;
import org.apache.hc.core5.util.TimeValue;
import org.jboss.logging.Logger;

import land.ltbao.user_storage_provider.UserClientSimpleHttp;

import org.apache.hc.core5.http.HttpRequest;
import java.util.concurrent.TimeUnit;

import java.io.IOException;


// retryInterval not woking for all exeptions
public class CustomHanlerHttpRequest extends DefaultHttpRequestRetryStrategy {
    private static final Logger logger = Logger.getLogger(UserClientSimpleHttp.class);
	private final int maxRetry;
	private final int retryInterval;
    public CustomHanlerHttpRequest(int maxRetry, TimeValue retryInterval) {
        super(maxRetry, retryInterval);
        this.maxRetry = maxRetry;
        this.retryInterval = (int) retryInterval.toSeconds();
    }
    
    @Override
    public boolean retryRequest(HttpRequest request, IOException exception, int executionCount, HttpContext context) {
        if (executionCount <= maxRetry) {
            logger.warn("Retry when call api: " + executionCount);
            try {
                TimeUnit.SECONDS.sleep(retryInterval);
            } catch (InterruptedException e) {
                logger.error("The retry thread was interrupted");
            }
            return true;
        }
        return false;
    }

    @Override
    public boolean retryRequest(HttpResponse response,int executionCount, HttpContext context) {
        if (response.getCode() != 200) {
            if (executionCount <= maxRetry) {
                logger.warn("Retry when call api: " + executionCount);
                try {
                    TimeUnit.SECONDS.sleep(retryInterval);
                } catch (InterruptedException e) {
                    logger.error("The retry thread was interrupted");
                }
                return true;
            }
        }
        return false;
    }
}

