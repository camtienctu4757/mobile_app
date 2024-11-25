# Create, running, build fast api on linux ( deb )

# Create new project

## Create virtual env

```sh
sudo apt-get install -y python3-venv
mkdir -p ./venv
cd  ./venv
python3 -m venv venv
source venv/bin/activate
pip install -r ./build/requirements.txt
```

## Migrate db

```sh
docker run --rm --add-host postgres-dev.us-west.ltbao.land:10.82.24.79 -v `pwd`/pki/postgres:/liquibase/pki  -v `pwd`/migrations:/liquibase/changelog liquibase/liquibase:4.28.0 update  \
  --changelog-file=changelog/wrapper.yaml \
  --url="jdbc:postgresql://postgres-dev.us-west.ltbao.land:5000/beauti_app_dev_svcs?ssl=true&sslmode=verify-full&sslrootcert=/liquibase/pki/ca-chain.cert.pem" --username=beauti_app_dev_svcs --password=Password12345!
```

## Check connections

pool_size: nums of available connections
max_overflow: nums of connections will be created new when increase requests

```sql
SELECT
    pid
    ,datname
    ,usename
    ,client_addr
    ,client_hostname
    ,client_port
    ,backend_start
    ,query_start
    ,query
    ,state
FROM pg_stat_activity;



SELECT
    query
    ,state
FROM pg_stat_activity;
```

Run app

```sh
docker run --rm --name app --add-host postgres-dev.us-west.ltbao.land:10.82.24.79 \
--add-host redis1.us-west.ltbao.land:10.82.24.94 --add-host redis2.us-west.ltbao.land:10.82.24.95 \
--add-host redis3.us-west.ltbao.land:10.82.24.96 --add-host redis4.us-west.ltbao.land:10.82.24.97 \
--add-host redis5.us-west.ltbao.land:10.82.24.98 --add-host redis6.us-west.ltbao.land:10.82.24.99 \
--add-host minio.us-west.ltbao.land:10.82.24.79 --add-host sso-dev.vnptics.vn:113.161.225.241 \
--add-host kafka-broker1.us-west.ltbao.land:10.82.24.70 --add-host kafka-broker2.us-west.ltbao.land:10.82.24.71 \
-p 5000:5000 -v /home/ltbao/working/thesis/beautyapp/base-svc/app:/app crelease.devops.vnpt.vn:10141/app/base-svc:v1
```

Get token

```sh
curl -X POST "http://192.168.168.250:8080/realms/my-realm/protocol/openid-connect/token" \
     -d "grant_type=password" \
     -d "client_id=my-pri-client" \
     -d "client_secret=c45c5UmLzvO5LdDtl5e86ozz7ktOI9NB" \
     -d "username=test" \
     -d "password=test"

curl -X POST "https://sso-dev.vnptics.vn/realms/beautiapp/protocol/openid-connect/token" \
 -d "grant_type=password" \
 -d "client_id=beautiapp" \
 -d "client_secret=GY5Cth9NlZqFzZnWxRwxxfrM9SK0NUaA" \
 -d "username=camtien" \
 -d "password=letribao"

curl -X POST "https://sso-dev.vnptics.vn/realms/beautiapp/protocol/openid-connect/token" \
 -d "grant_type=password" \
 -d "client_id=beautiapp" \
 -d "client_secret=GY5Cth9NlZqFzZnWxRwxxfrM9SK0NUaA" \
 -d "username=ngoclinh" \
 -d "password=ngoclinh"
```

get token keycloak

```sh
curl -X 'GET' \
  'http://172.18.142.184:5000/api/v1/test/auth' \
  -H 'accept: application/json' \
  -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJMT0x6RzBENkV3YTBZajlqUWRsMzJEbWpoNEhuWG5vcFZRMnhySXBoalZvIn0.eyJleHAiOjE3MjkzOTYxMjksImlhdCI6MTcyOTM5NTgyOSwianRpIjoiZWVkZGM0YjEtY2RkMS00NDJkLWFiNjMtOWE1MTljNTc4NzQ4IiwiaXNzIjoiaHR0cHM6Ly9zc28tZGV2LnZucHRpY3Mudm4vcmVhbG1zL2JlYXV0aWFwcCIsImF1ZCI6ImFjY291bnQiLCJzdWIiOiJmOmZhNjg4MGYwLTQ0MzgtNDdmOS05M2E5LTc5NWVkZDk0NzQ4OTpiY2VkMzc4Ni01ODA5LTQzZmQtOTM2Ni01NWVlODI3OTljYzEiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJiZWF1dGlhcHAiLCJzaWQiOiI5NGM1NTE3Ni03MTUzLTQxZWItYjBkMy1mN2JmZmJiZmExYzkiLCJhY3IiOiIxIiwiYWxsb3dlZC1vcmlnaW5zIjpbIi8qIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJvZmZsaW5lX2FjY2VzcyIsInVtYV9hdXRob3JpemF0aW9uIl19LCJyZXNvdXJjZV9hY2Nlc3MiOnsiYWNjb3VudCI6eyJyb2xlcyI6WyJtYW5hZ2UtYWNjb3VudCIsIm1hbmFnZS1hY2NvdW50LWxpbmtzIiwidmlldy1wcm9maWxlIl19fSwic2NvcGUiOiJwcm9maWxlIGVtYWlsIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJyb2xlcyI6WyJhZG1pbiIsInB1YmxpYyJdLCJuYW1lIjoiVGllbiBOZ3V5ZW4iLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJjYW10aWVuIiwiZ2l2ZW5fbmFtZSI6IlRpZW4iLCJmYW1pbHlfbmFtZSI6Ik5ndXllbiIsImVtYWlsIjoiY2FtdGllbkBnbWFpbC5jb20ifQ.UUc86B0hRpLFilCtlAlelZrfGYNa8XQ9pNfR_cI4Dv-gFDzGta6Ztb9uuHywycXniXWCJUqdOmcEMUey48eOb8hNy6Lo-_oA81NdOaVHtqFEXQ3d8pEvaji2nJHQ2yW4VSz3SNQKD5w2px9ZLWpqYKczgqDE8upNc1TVWrKDXfuI9zmNa-IjefYIDPENTKDu5FeS8KFTP1XfSeBhlM38PUkQthtBtfOh0kpYJhuaV28h-Pga2dLH-izr4hlHdCZYK52HCfU49jcKrlotyODByhb_5bjRn2uSPVcO24oZWsgWeXDwnMtk9pWhZhvCJhztbLeo6-_0xbDwVi50JZgAYw"

curl -X 'GET' \
  'http://10.82.119.21:5000/api/v1/test/auth' \
  -H 'accept: application/json' \
  -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJqWm9seElINml2WG56U1lsN0FHYUQzVS1hdHhrY0dzWlp0WTNJY0dHbzVFIn0.eyJleHAiOjE3MjU3NjEyNzcsImlhdCI6MTcyNTc2MDk3NywianRpIjoiYThhZWIxYmYtOWQ1ZC00NzAzLWI3OWQtMzA4OTBiYTRhM2MyIiwiaXNzIjoiaHR0cHM6Ly9zc28tZGV2LnZucHRpY3Mudm4vcmVhbG1zL2JlYXV0aV9hcHAiLCJhdWQiOiJhY2NvdW50Iiwic3ViIjoiMzgyOTE1OWUtN2RiYS00MmViLThjZWYtZTUzM2VkMzNmMDZjIiwidHlwIjoiQmVhcmVyIiwiYXpwIjoiYmVhdXRpYXBwIiwic2lkIjoiODFmYmY4OTItNDM0OS00NTNhLTk2MzAtMzdmNWIzOTNkYzRjIiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6WyIvKiJdLCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOlsib2ZmbGluZV9hY2Nlc3MiLCJkZWZhdWx0LXJvbGVzLWJlYXV0aV9hcHAiLCJ1bWFfYXV0aG9yaXphdGlvbiJdfSwicmVzb3VyY2VfYWNjZXNzIjp7ImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJtYW5hZ2UtYWNjb3VudC1saW5rcyIsInZpZXctcHJvZmlsZSJdfX0sInNjb3BlIjoiZW1haWwgcHJvZmlsZSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJuYW1lIjoidGVzdCB0ZXN0IiwicHJlZmVycmVkX3VzZXJuYW1lIjoidGVzdCIsImdpdmVuX25hbWUiOiJ0ZXN0IiwiZmFtaWx5X25hbWUiOiJ0ZXN0IiwiZW1haWwiOiJ0ZXN0QG1haWwuY29tIn0.QJLfaihQRLBLx4ritflctJ14SI3hQkgwxl_LGcRChgCS72FUFmmfPD8fWTWDXyiVXZYmFmiG9-9wl_FQ-i_viRhhUNbUx0CbiLgvXEi_hVspuZpJVbssXCLrnrqLAe0h-FJwZdIToQlSY5J6bqs85TNTeESWbyjMyE1ZGpzcoF9yz9eADBGJuAPi4dfwLMtyS5-XdTenhnKN_Fqp1w4L0Ch2pdZjw77fgYx3oDyuxnh_4akI-U7lCW8HvZB5GQYDMPT4r4KQ3DX3-UZtAzrxnLssJVzKKlUMayg3nWL0lYn5JozxfUJ1O7qVZosycpcPJfSxcKbAPcpoIdpA3ugKQQ"
```
