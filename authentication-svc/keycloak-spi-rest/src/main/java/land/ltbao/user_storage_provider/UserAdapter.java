package land.ltbao.user_storage_provider;

import org.jboss.logging.Logger;
import org.keycloak.common.util.MultivaluedHashMap;
import org.keycloak.component.ComponentModel;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.RealmModel;
import org.keycloak.storage.StorageId;
import org.keycloak.storage.adapter.AbstractUserAdapterFederatedStorage;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.stream.Stream;

/**
 * @author <a href="ltbao@ltbao.land">Lt. Bao</a>
 * @version $Revision: 1 $
 */
public class UserAdapter extends AbstractUserAdapterFederatedStorage {
    private static final Logger logger = Logger.getLogger(UserAdapter.class);
    protected UserEntity entity;
    protected String keycloakId;
    ObjectMapper objectMapper = new ObjectMapper();

    public UserAdapter(KeycloakSession session, RealmModel realm, ComponentModel model, UserEntity entity) {
        super(session, realm, model);
        this.entity = entity;
        keycloakId = StorageId.keycloakId(model, entity.getUser_uuid());
    }

    public String getPassword() {
        return entity.getPassword();
    }

    public void setPassword(String password) {
        entity.setPassword(password);
    }

    @Override
    public String getUsername() {
        return entity.getUsername();
    }

    @Override
    public void setUsername(String username) {
        entity.setUsername(username);

    }

    @Override
    public void setEmail(String email) {
        entity.setEmail(email);
    }

    @Override
    public String getEmail() {
        return entity.getEmail();
    }

    @Override
    public String getId() {
        return keycloakId;
    }

    @Override
    public String getFirstName() {
        return entity.getFirstname();
    }

    @Override
    public void setFirstName(String firstName) {
        entity.setFirstname(firstName);

    }

    @Override
    public String getLastName() {
        return entity.getLastname();
    }

    @Override
    public void setLastName(String lastName) {
        entity.setLastname(lastName);

    }

    
	@Override
	public boolean isEnabled() {
		return Boolean.parseBoolean(entity.getIs_enabled());
    }

    @Override
    public void setSingleAttribute(String name, String value) {
        if (name.equals("phone")) {
            entity.setPhone_number(value);
        } else {
            super.setSingleAttribute(name, value);
        }
    }

    @Override
    public void removeAttribute(String name) {
        if (name.equals("phone")) {
            entity.setPhone_number(null);
        } else {
            super.removeAttribute(name);
        }
    }

    @Override
    public void setAttribute(String name, List<String> values) {
        if (name.equals("phone")) {
            entity.setPhone_number(values.get(0));
        }
        else {
            super.setAttribute(name, values);
        }
    }

    @Override
    public String getFirstAttribute(String name) {
        if (name.equals("phone")) {
            return entity.getPhone_number();
        } else {
            return super.getFirstAttribute(name);
        }
    }

    @Override
    public Map<String, List<String>> getAttributes() {
        MultivaluedHashMap<String, String> all = new MultivaluedHashMap<>();
        all.add("username",entity.getUsername());
        all.add("email",entity.getEmail());
        all.add("lastName",entity.getLastname());
        all.add("firstName",entity.getFirstname());
        all.add("phone", entity.getPhone_number());
        try {
            all.add("roles",objectMapper.writeValueAsString(entity.getRoles()));
        } catch (JsonProcessingException e) {
            logger.error("Error parse roles from object to to the string json");
        }
        return all;
    }

    @Override
    public Stream<String> getAttributeStream(String name) {
        if (name.equals("phone")) {
            List<String> phone = new LinkedList<>();
            phone.add(entity.getPhone_number());
            return phone.stream();
        } else {
            return super.getAttributeStream(name);
        }
    }
}
