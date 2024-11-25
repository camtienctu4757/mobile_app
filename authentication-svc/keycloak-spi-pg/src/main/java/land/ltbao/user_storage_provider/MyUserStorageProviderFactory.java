package land.ltbao.user_storage_provider;

import org.jboss.logging.Logger;
import org.keycloak.component.ComponentModel;
import org.keycloak.models.KeycloakSession;
import org.keycloak.storage.UserStorageProviderFactory;

/**
 * @author <a href="ltbao@ltbao.land">Lt. Bao</a>
 * @version $Revision: 1 $
 */
public class MyUserStorageProviderFactory implements UserStorageProviderFactory<MyUserStorageProvider> {
    public static final String PROVIDER_ID = "example-user-storage-jpa";

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
    public String getHelpText() {
        return "JPA Example User Storage Provider";
    }

    @Override
    public void close() {
        logger.info("<<<<<< Closing factory");

    }
}
