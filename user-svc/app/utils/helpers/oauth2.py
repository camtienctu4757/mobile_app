from datetime import datetime, timedelta
from jose import JWTError,jwt
from fastapi import Depends,HTTPException, status
# from .schemas import schemas
from fastapi.security import OAuth2PasswordBearer
# from .config import settings
# from .models import *
from sqlalchemy.orm import Session
# from beauty_app import database
from thirdparty.db.models import *
from core.enviroment_params import get_env
from schemas.respones.user_dto import TokenUser

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/api/v1/users/login")
Algorithms = get_env().TOKEN_ALGORITHMS
ExpireTime = int(get_env().TOKEN_EXPIRE_TIME_HOURS)
SecretKey = get_env().TOKEN_SECRET_KEY

def create_token(data: dict):
    to_encode = data.copy()
    expire = datetime.utcnow() + timedelta(hours=ExpireTime)
    to_encode.update({"exp":expire})
    jwt_token = jwt.encode(to_encode,SecretKey,algorithm=Algorithms)
    return jwt_token

def verify_token(token: str, credentialsError):
    try:
        payload = jwt.decode(token,SecretKey, algorithms=[Algorithms])
        id: str = payload.get('id_user')
        if not id:
            raise credentialsError
        token_data = TokenUser(user_uuid=id, access_token= token)
    except JWTError:
        raise credentialsError
    return token_data


def get_current_user(token: str = Depends(oauth2_scheme)):
    credentialsError = HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail=" could not valid credentials", headers={"WWW_Authenticate":"Bearer"})
    print (token)
    return verify_token(token, credentialsError)

# #----------------------------------------------------------------
# def is_token_expired(expiration_time: datetime):
#     current_time = datetime.utcnow()
#     return expiration_time < current_time

# # add token expired into database
# def revoke_token(token: str, db: Session = Depends(database.get_db)):
#     try:
#         token_expire = ExpiredToken(TokenString = token)
#         db.add(token_expire)
#         db.commit()
#         db.refresh(token_expire)
#         return True
#     except Exception as e:
#         print (e)
#         return False
# def is_token_revoked(token: str,db: Session = Depends(database.get_db)):
#     token_expired = db.query(ExpiredToken).filter(ExpiredToken.TokenString == token)
#     print(token_expired)
#     if len(token_expired) != 0:
#         return True
#     else:
#         return False
# def revoke_token(token: str, db):
#     try:
#         token_expire = ExpiredToken(TokenString = token)
#         db.add(token_expire)
#         db.commit()
#         db.refresh(token_expire)
#         return True
#     except Exception as e:
#         print (e)
#         return False


# #----------------------------------------------------------------
