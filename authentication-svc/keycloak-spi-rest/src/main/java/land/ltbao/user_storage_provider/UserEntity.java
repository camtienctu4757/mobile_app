package land.ltbao.user_storage_provider;

import lombok.Data;
import java.util.List;

@Data
public class UserEntity {
	private String user_uuid;
	private String username;
	private String password;
	private String email;
	private String firstname;
	private String lastname;
	private String phone_number;
	private String is_enabled;
    private List<String> roles;
}

