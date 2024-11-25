package land.ltbao.user_storage_provider;

import org.jboss.logging.Logger;
import org.keycloak.component.ComponentModel;
import org.keycloak.models.KeycloakSession;
import org.keycloak.storage.UserStorageProviderFactory;

import land.ltbao.user_storage_provider.httpclient.HttpClientSingleton;

import org.keycloak.provider.ProviderConfigProperty;
import org.keycloak.provider.ProviderConfigurationBuilder;
import java.util.List;
/**
 * @author <a href="ltbao@ltbao.land">Lt. Bao</a>
 * @version $Revision: 1 $
 */
public class MyUserStorageProviderFactory implements UserStorageProviderFactory<MyUserStorageProvider> {
    public static final String PROVIDER_ID = "user-storage-provider";
	static final String USER_API_BASE_URL = "apiUrl";
	static final String USERNAME = "username";
	static final String PASSWORD = "password";
	static final String HTTPVERSION = "httpVersion";
    static final String REQUEST_TIMEOUT = "requestTimeout";
    static final String RESPONE_TIMEOUT = "responseTimeout";
    static final String MAX_RETRY = "maxRetry";
    static final String RETRY_INTERVAL = "retryInterval";
    static final String MAX_CONNECTION = "maxConnection";
    static final String CONN_PER_ROUTE = "connPerRoute";
    static final String CONNECTION_TIMEOUT = "connectionTimeout";
    private static final Logger logger = Logger.getLogger(MyUserStorageProviderFactory.class);

    @Override
    public MyUserStorageProvider create(KeycloakSession session, ComponentModel model) {
        return new MyUserStorageProvider(session, model);
    }

    @Override
    public String getId() {
        return PROVIDER_ID;
    }

	@Override
	public List<ProviderConfigProperty> getConfigProperties() {
		return ProviderConfigurationBuilder.create()
			.property(USER_API_BASE_URL, "Api url", "The Url Base for user api", ProviderConfigProperty.STRING_TYPE, "http://localhost:8000", null)
			.property(USERNAME, "Username", "Username for basic auth", ProviderConfigProperty.STRING_TYPE, "username", null)
			.property(PASSWORD, "Password", "Password for basic auth", ProviderConfigProperty.STRING_TYPE, "password", null)
            .property(HTTPVERSION, "Http version", "Http protocol version", ProviderConfigProperty.STRING_TYPE, "HTTP/1.0", null)
            .property(REQUEST_TIMEOUT, "Request timeout", "Request timeout", ProviderConfigProperty.STRING_TYPE, "2", null)
            .property(RESPONE_TIMEOUT, "Respone timeout", "Respone timeout", ProviderConfigProperty.STRING_TYPE, "3", null)
            .property(MAX_RETRY, "Max retry", "Max retry", ProviderConfigProperty.STRING_TYPE, "3", null)
            .property(RETRY_INTERVAL, "Retry interval", "Retry interval", ProviderConfigProperty.STRING_TYPE, "2", null)
            .property(MAX_CONNECTION, "Max connection", "Max connection ", ProviderConfigProperty.STRING_TYPE, "1000", null)
            .property(CONN_PER_ROUTE, "Connection per route", "Connection per route", ProviderConfigProperty.STRING_TYPE, "200", null)
            .property(CONNECTION_TIMEOUT, "Connection timeout", "Time to delete idle connection in second", ProviderConfigProperty.STRING_TYPE, "3600", null)
			.build();
	}

    @Override
    public String getHelpText() {
        return "User Storage Provider";
    }

    @Override
    public void close() {
        HttpClientSingleton.closeClient();
    }
}
