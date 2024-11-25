from thirdparty.db.models.users import User
from schemas.respones.user_dto import UserOutRoles
class Mapper():
    def mapper_usermodel_to_userwithrole(user:User, role_list:list[str]):
        return UserOutRoles(user_uuid=user.user_uuid,
            username=user.username,
            password=user.password,
            email=user.email,
            phone_number=user.phone_number,
            firstname=user.firstname,
            lastname=user.lastname,
            is_enabled=user.is_enabled, roles=role_list)
