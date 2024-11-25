```sh
DOCKER_BUILDKIT=1  docker buildx build -t auth:v1 -f ./build/Dockerfile .
DOCKER_BUILDKIT=1  docker buildx build -t auth:v4 -f ./source-build/Dockerfile . > /tmp/log.txt  2>&1
```

```sh
docker run -p 8080:8080 -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=admin auth:v1
```

````sh
docker run --name some-mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=admin -d mysql:8.0
mysql -h 10.82.119.21 -u root -padmin
```insert into customer (username,emainsert into customer (username,email,first_name,last_name,active) VALUES ('user1','user1@gmail.com','User','One',1);il,first_name,last_name,active) VALUES ('user1','user1@gmail.com','User','One',1);

```sh
create table users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  username VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  phone VARCHAR(255) NOT NULL,
  firstName VARCHAR(255) NOT NULL,
  lastName VARCHAR(255) NOT NULL
);
insert into users (username, email, password, phone, firstName, lastName) VALUES ('user6','user6@gmail.com','$2a$12$EvQxPT0LplFRYA2tR1WzKeyOmWn2aEtIu2zRKDfJlj98P1uKDJzdy','123456788','lt','bao');

UPDATE users
SET password = '$2a$12$EvQxPT0LplFRYA2tR1WzKeyOmWn2aEtIu2zRKDfJlj98P1uKDJzdy'
WHERE username = 'camtien';
````

```sh
mvn io.quarkus.platform:quarkus-maven-plugin:3.14.3:create \
    -DprojectGroupId=org.acme \
    -DprojectArtifactId=quarkus-postgres-orm \
    -DclassName="org.acme.entity.UserResource" \
    -Dpath="/users" \
    -Dextensions="hibernate-orm, jdbc-postgresql, resteasy-reactive"




docker run -p 8080:8080 -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=admin -e KC_DB=postgres -e KC_DB_USERNAME=postgres -e KC_DB_PASSWORD=admin -e KC_DB_URL=jdbc:postgresql://10.82.119.21:3002/keycloak btest:v1

```
