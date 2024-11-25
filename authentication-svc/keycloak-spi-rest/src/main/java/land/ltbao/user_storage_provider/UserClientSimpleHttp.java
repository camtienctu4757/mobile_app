package land.ltbao.user_storage_provider;
import lombok.extern.slf4j.Slf4j;

import org.apache.hc.client5.http.classic.methods.HttpGet;
import org.apache.hc.client5.http.impl.classic.CloseableHttpClient;
import org.apache.hc.core5.http.io.entity.EntityUtils;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.hc.core5.net.URIBuilder;
import org.jboss.logging.Logger;
import org.keycloak.component.ComponentModel;

import java.net.URI;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.List;
import org.apache.hc.core5.http.HttpVersion;
import land.ltbao.user_storage_provider.httpclient.HttpClientSingleton;

public class UserClientSimpleHttp {
	
	private final ObjectMapper objectMapper = new ObjectMapper();
	private String httpVersion = null;
	private String auth = null;
	private String authHeader = null;
	private String baseUrl = null;
    private static final Logger logger = Logger.getLogger(UserClientSimpleHttp.class);
	CloseableHttpClient httpClient = null;	
	public UserClientSimpleHttp(ComponentModel model) {
		this.baseUrl = model.get(MyUserStorageProviderFactory.USER_API_BASE_URL);
		this.httpVersion = model.get(MyUserStorageProviderFactory.HTTPVERSION);
		this.auth = model.get(MyUserStorageProviderFactory.USERNAME) + ":" + model.get(MyUserStorageProviderFactory.PASSWORD);
		this.authHeader = "Basic " + Base64.getEncoder().encodeToString(this.auth.getBytes(StandardCharsets.UTF_8));
		this.httpClient = HttpClientSingleton.getInstance(
			Integer.parseInt(model.get(MyUserStorageProviderFactory.REQUEST_TIMEOUT))
			,Integer.parseInt(model.get(MyUserStorageProviderFactory.RESPONE_TIMEOUT))
			,Integer.parseInt(model.get(MyUserStorageProviderFactory.MAX_RETRY))
			,Integer.parseInt(model.get(MyUserStorageProviderFactory.RETRY_INTERVAL))
			,Integer.parseInt(model.get(MyUserStorageProviderFactory.MAX_CONNECTION))
			,Integer.parseInt(model.get(MyUserStorageProviderFactory.CONN_PER_ROUTE))
			,Integer.parseInt(model.get(MyUserStorageProviderFactory.CONNECTION_TIMEOUT)));
	}

	public List<UserEntity> getUsers() {
		List<UserEntity> users = null;
		try {
			HttpGet request = new HttpGet(baseUrl + "/api/v1/users");
			request.setHeader("Authorization", authHeader);
			request.setVersion(HttpVersion.parse(httpVersion));
			users = this.httpClient.execute(request,
			response -> {
				if (response.getCode() == 200) {
					JsonNode data = objectMapper.readTree(EntityUtils.toString(response.getEntity())).at("/data"); 
					return objectMapper.treeToValue(data, objectMapper.getTypeFactory().constructCollectionType(List.class, UserEntity.class));
                } else {
                    logger.error("Failed to get users, status code is: " + response.getCode());
					return null;
                }
            }
			);
        } catch (Exception e) {
            logger.error("Failed to call /api/v1/users: " + e);
        }
		return users;
	}


	public Integer countUsers() {
		Integer data = null;
			try {
				HttpGet request = new HttpGet(baseUrl + "/api/v1/users/count");
				request.setHeader("Authorization", authHeader);
				request.setVersion(HttpVersion.parse(httpVersion));
				data = this.httpClient.execute(request,
				response -> {
					if (response.getCode() == 200) {
						return objectMapper.readTree(EntityUtils.toString(response.getEntity())).at("/data").asInt();
					} else {
						logger.error("Failed to count users, status code is: " + response.getCode());
						return null;
					}
				}
				);
        } catch (Exception e) {
            logger.error("Failed to call /api/v1/users: " + e);
        }
		return data;
	}

	public UserEntity getUserByEmail(String email) {
		UserEntity user = null;
			try {
				URI uri = new URIBuilder(baseUrl + "/api/v1/users/find_by_email").setParameter("email", email).build();
				HttpGet request = new HttpGet(uri);
				request.setHeader("Authorization", authHeader);
				request.setVersion(HttpVersion.parse(httpVersion));
				user = this.httpClient.execute(request,
				response -> {
					if (response.getCode() == 200) {
						JsonNode data = objectMapper.readTree(EntityUtils.toString(response.getEntity())).at("/data").get(0); 
						return objectMapper.treeToValue(data, UserEntity.class);
					} else {
						logger.error("Failed to get user by email, status code is: " + response.getCode());
						return null;
					}
				}
				);
        } catch (Exception e) {
            logger.error("Failed to call /api/v1/users/find_by_email: " + e);
        }
		return user;
	}
	public UserEntity getUserByUsername(String username) {
		UserEntity user = null;
		
		try {
			URI uri = new URIBuilder(baseUrl + "/api/v1/users/find_by_username").setParameter("username", username).build();
			HttpGet request = new HttpGet(uri);
			request.setHeader("Authorization", authHeader);
			request.setVersion(HttpVersion.parse(httpVersion));
			user = this.httpClient.execute(request,
			response -> {
				if (response.getCode() == 200) {
					JsonNode data = objectMapper.readTree(EntityUtils.toString(response.getEntity())).at("/data").get(0); 
					return objectMapper.treeToValue(data, UserEntity.class);
				} else {
					logger.error("Failed to get user by username, status code is: " + response.getCode());
					return null;
				}
			}
			);
        } catch (Exception e) {
            logger.error("Failed to call /api/v1/users/find_by_username: " + e);
        }
		return user;
	}
	public UserEntity getUserById(String user_id) {
		UserEntity user = null;
		
		try {
			URI uri = new URIBuilder(baseUrl + "/api/v1/users/find_by_id").setParameter("user_id", user_id).build();
			HttpGet request = new HttpGet(uri);
			request.setHeader("Authorization", authHeader);
			request.setVersion(HttpVersion.parse(httpVersion));
			user = this.httpClient.execute(request,
			response -> {
				if (response.getCode() == 200) {
					JsonNode data = objectMapper.readTree(EntityUtils.toString(response.getEntity())).at("/data").get(0); 
					return objectMapper.treeToValue(data, UserEntity.class);
				} else {
					logger.error("Failed to get user by id, status code is: " + response.getCode());
					return null;
				}
			}
			);
        } catch (Exception e) {
            logger.error("Failed to call /api/v1/users/find_by_id: " + e);
        }
		return user;
	}

}

