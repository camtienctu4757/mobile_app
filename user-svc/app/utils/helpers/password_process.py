import bcrypt


def hash_password(password: str) -> str:
    # Generate a salt and hash the password
    salt = bcrypt.gensalt(prefix=b"2a")
    hashed_password = bcrypt.hashpw(password.encode('utf-8'), salt)
    return hashed_password.decode('utf-8')

def verify_password(password, hash_password):
    return hash_password.verify(password, hash_password)

