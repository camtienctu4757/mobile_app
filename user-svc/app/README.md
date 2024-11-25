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
docker run --rm --add-host postgres-dev:10.0.0.1 -v `pwd`/pki/postgres:/liquibase/pki  -v `pwd`/migrations:/liquibase/changelog liquibase/liquibase:4.28.0 update  \
  --changelog-file=changelog/wrapper.yaml \
  --url="jdbc:postgresql://postgres-dev:5000/beauti_app_dev_svcs?ssl=true&sslmode=verify-full&sslrootcert=/liquibase/pki/ca-chain.cert.pem" --username=beauti_app_dev_svcs --password=0000000
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

```sh
docker run --rm --name app --add-host postgres-dev.us:10.0.0.1 \
--add-host redis1.us:10.0.0.2 --add-host redis2.us:10.0.0.3 \
--add-host redis3.us:10.0.0.4 --add-host redis4.us:10.0.0.5 \
--add-host redis5.us:10.0.0.6 --add-host redis6.us:10.0.0.7 \
-p 5000:5000 -v /mnt/hgfs/beautyapp/user-svc/app:/app app:v1



DOCKER_BUILDKIT=1  docker buildx build -t app:v1 -f /mnt/hgfs/fastapi/beautyapp/base-svc/app/build/Dockerfile /mnt/hgfs/fastapi/beautyapp/base-svc/app 



#get me
curl -X 'GET' \
  'https://127.0.0.1:5000/api/v1/users' \
  -H 'accept: application/json'\
  -H 'Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJMT0x6RzBENkV3YTBZajlqUWRsMzJEbWpoNEhuWG5vcFZRMnhySXBoalZvIn0.eyJleHAiOjE3MzEzODYyNTcsImlhdCI6MTczMTM4NDQ1NywianRpIjoiZWE3YzUxNjYtMWU5ZS00ZmY0LThmMTYtZmFmNmI0OTllYjdlIiwiaXNzIjoiaHR0cHM6Ly9zc28tZGV2LnZucHRpY3Mudm4vcmVhbG1zL2JlYXV0aWFwcCIsImF1ZCI6ImFjY291bnQiLCJzdWIiOiJmOmZhNjg4MGYwLTQ0MzgtNDdmOS05M2E5LTc5NWVkZDk0NzQ4OTpkMzFkM2RmYy0yNmIyLTRlNTktYjQxNi1iZTJhMzliMTM3YWIiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJiZWF1dGlhcHAiLCJzaWQiOiJmMTBkZjVmMS0xODA3LTRmNDYtODE3ZC03NTg2ZDgxNDE5MDciLCJhY3IiOiIxIiwiYWxsb3dlZC1vcmlnaW5zIjpbIi8qIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJvZmZsaW5lX2FjY2VzcyIsInVtYV9hdXRob3JpemF0aW9uIl19LCJyZXNvdXJjZV9hY2Nlc3MiOnsiYWNjb3VudCI6eyJyb2xlcyI6WyJtYW5hZ2UtYWNjb3VudCIsIm1hbmFnZS1hY2NvdW50LWxpbmtzIiwidmlldy1wcm9maWxlIl19fSwic2NvcGUiOiJwcm9maWxlIGVtYWlsIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJuZ29jbGFuIn0.Goc7YlXtL5SlUwC7nkfcZvtu6BrFgi68Y6HrDoY4zRiYxRhniuDm8S0rVLKN9eTCUgSYAl77mx_1TGexGFPWa16t50Mewe_75o0cTZwG-WMvpSxxqfkql9JsAkJah4DQC0F00HhX4I-04baYdlqDBz0XLVKrv8kEiJhd0eW5aDTqS_wiV47LLO58_59GvARHvmAxHVDE5V26R06vGvuCPZgTwR3gMkFMuV-rDGiHqlMi7R4eL5bNhm21CdQlj0YLtY0pIEwKlozjjJhJHpsQw4sNplEsv9TBspAkXa9_r4LsH15rtrWILduduewNqPdJbfSML47crsWX7rAL36gi8Q'

#delete
curl -X 'DELETE' \
  'https://127.0.0.1:5000/api/v1/users' \
  -H 'accept: application/json' \
  -H 'Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJMT0x6RzBENkV3YTBZajlqUWRsMzJEbWpoNEhuWG5vcFZRMnhySXBoalZvIn0.eyJleHAiOjE3MzA3NzA3MjEsImlhdCI6MTczMDc2ODkyMSwianRpIjoiOWJhZTI5YTMtYzBjNy00MDVkLTljM2EtNzk1OGYwMGRiY2EwIiwiaXNzIjoiaHR0cHM6Ly9zc28tZGV2LnZucHRpY3Mudm4vcmVhbG1zL2JlYXV0aWFwcCIsImF1ZCI6ImFjY291bnQiLCJzdWIiOiJmOmZhNjg4MGYwLTQ0MzgtNDdmOS05M2E5LTc5NWVkZDk0NzQ4OTo3MWI2MjIxMi0xNzZkLTQ2M2EtYWZkNi1iNTJiYmM4NGE3OWIiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJiZWF1dGlhcHAiLCJzaWQiOiI5ZDQzZGYxMy1lYWE3LTQ4MjktODA1MC03ZGRlZTRhMTBjNDAiLCJhY3IiOiIxIiwiYWxsb3dlZC1vcmlnaW5zIjpbIi8qIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJvZmZsaW5lX2FjY2VzcyIsInVtYV9hdXRob3JpemF0aW9uIl19LCJyZXNvdXJjZV9hY2Nlc3MiOnsiYWNjb3VudCI6eyJyb2xlcyI6WyJtYW5hZ2UtYWNjb3VudCIsIm1hbmFnZS1hY2NvdW50LWxpbmtzIiwidmlldy1wcm9maWxlIl19fSwic2NvcGUiOiJwcm9maWxlIGVtYWlsIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJyb2xlcyI6WyJwdWJsaWMiXSwicHJlZmVycmVkX3VzZXJuYW1lIjoibWFpYW5oMjAwMiIsImVtYWlsIjoibWFpYW5oQGdtYWlsLmNvbSJ9.KKw8NG2BqSKenH7b3mPTD35gtYmTSw2rFX5XyfWKkXOhDQY00ylKGg88wY-jebDCf2Yq3StzBJ6ijMFH9cdrKiiDegngZwSjkzS7AsgtnzljuIuY159cTEaOczvWWH5mP3CMnu6tthWvMRhuMEqVHCyYNtDcdNPQiZuYQSmyNlXWwB6RAsONYTurPu4P2l_Capo1lJr8J00YsHsfRBBZLBAV-9EwnRrU691ZXvssUOrA4JqS3nC5P4Ip0QjpPzCvzaSV42L3SbApbKUv474Oe3UNVCmcKEHHIrLygHv_jt-04ZsFLbsp2NTQ_AoRyAYOtNAdoo7AhMBNtcK2-r1Img' 

# update user
curl -X 'PATCH' \
  'http://127.0.0.1:5000/api/v1/users/bced3786-5809-43fd-9366-55ee82799cc1' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJMT0x6RzBENkV3YTBZajlqUWRsMzJEbWpoNEhuWG5vcFZRMnhySXBoalZvIn0.eyJleHAiOjE3MzAxMjQwMjYsImlhdCI6MTczMDEyMjIyNiwianRpIjoiMzAyOWIxNDAtY2Y3Yi00ODBiLTk5OGMtNTVmYTBmYWRjOTA5IiwiaXNzIjoiaHR0cHM6Ly9zc28tZGV2LnZucHRpY3Mudm4vcmVhbG1zL2JlYXV0aWFwcCIsImF1ZCI6ImFjY291bnQiLCJzdWIiOiJmOmZhNjg4MGYwLTQ0MzgtNDdmOS05M2E5LTc5NWVkZDk0NzQ4OTpiY2VkMzc4Ni01ODA5LTQzZmQtOTM2Ni01NWVlODI3OTljYzEiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJiZWF1dGlhcHAiLCJzaWQiOiIxZjk4ZTNjOS0wMjVjLTRhMzQtOTUwOC0xZGJkYjYwNmJmZWYiLCJhY3IiOiIxIiwiYWxsb3dlZC1vcmlnaW5zIjpbIi8qIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJvZmZsaW5lX2FjY2VzcyIsInVtYV9hdXRob3JpemF0aW9uIl19LCJyZXNvdXJjZV9hY2Nlc3MiOnsiYWNjb3VudCI6eyJyb2xlcyI6WyJtYW5hZ2UtYWNjb3VudCIsIm1hbmFnZS1hY2NvdW50LWxpbmtzIiwidmlldy1wcm9maWxlIl19fSwic2NvcGUiOiJwcm9maWxlIGVtYWlsIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJuYW1lIjoiVGllbiBOZ3V5ZW4iLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJjYW10aWVuIn0.CU1K_RE7wnnc6D8S3q_7A6AMWikLhDcFJTYdDUN9_BX5XmkXIXs5eUYiLkhaBJ_4cnAjMLwQtWRFzWmaRfgTl3VBcgIhPSmgquitizRJYzHpioG215QaKPeUVJh74cxCUN5YskXhKcDXss3NsyBfpmLupnKkNDVvLoaNcyWpqRmC9IWt3kxZWGAy15HEXITuICZJ45aQDCUuFlDVliSxSn7b59OHjYlOt9jx3js27jQZbLy120sAs259v8qjI16nHsSr2gyjQeoc6Ef-sTQzJVsFL7ZkQYzwj4rwHX9dcHNSTDolbKM4nXPyhldA-dOuFtBvJXgmXSzIEYBDIAxRiw'\
  -d 'username=&phone=&firstname=&lastname=&email=test%40gmail.com'

#update password
curl -X 'PATCH' \
  'http://127.0.0.1:5000/api/v1/users/pass/bced3786-5809-43fd-9366-55ee82799cc1' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJMT0x6RzBENkV3YTBZajlqUWRsMzJEbWpoNEhuWG5vcFZRMnhySXBoalZvIn0.eyJleHAiOjE3MzAxMjYxODMsImlhdCI6MTczMDEyNDM4MywianRpIjoiMmZiYTZkNDMtZThjMy00Nzc0LWIyMGQtZjg1OWM2MTNhYmQ3IiwiaXNzIjoiaHR0cHM6Ly9zc28tZGV2LnZucHRpY3Mudm4vcmVhbG1zL2JlYXV0aWFwcCIsImF1ZCI6ImFjY291bnQiLCJzdWIiOiJmOmZhNjg4MGYwLTQ0MzgtNDdmOS05M2E5LTc5NWVkZDk0NzQ4OTpiY2VkMzc4Ni01ODA5LTQzZmQtOTM2Ni01NWVlODI3OTljYzEiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJiZWF1dGlhcHAiLCJzaWQiOiJmNzMxODBiOC03MjZmLTQwMTktOGRhYy0yNjQ4NjcxOTUxZTMiLCJhY3IiOiIxIiwiYWxsb3dlZC1vcmlnaW5zIjpbIi8qIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJvZmZsaW5lX2FjY2VzcyIsInVtYV9hdXRob3JpemF0aW9uIl19LCJyZXNvdXJjZV9hY2Nlc3MiOnsiYWNjb3VudCI6eyJyb2xlcyI6WyJtYW5hZ2UtYWNjb3VudCIsIm1hbmFnZS1hY2NvdW50LWxpbmtzIiwidmlldy1wcm9maWxlIl19fSwic2NvcGUiOiJwcm9maWxlIGVtYWlsIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJyb2xlcyI6WyJhZG1pbiIsInB1YmxpYyIsInNob3AiXSwibmFtZSI6IlRpZW4gTmd1eWVuIiwicHJlZmVycmVkX3VzZXJuYW1lIjoiY2FtdGllbiIsImdpdmVuX25hbWUiOiJUaWVuIiwiZmFtaWx5X25hbWUiOiJOZ3V5ZW4iLCJlbWFpbCI6ImNhbXRpZW5AZ21haWwuY29tIn0.jf_6QAE2puM8TUTHrWQN7uSG-kfTGvee9dbmW3ioQ11o735F4eYmPXGN5MSaiTuOoSpDH63pjOVprWAFfDh4n4IzSSoyIpqot4vXEfEn5LcsJTJUSO-gVCUu9szPGC52aaiW47j-qsyv7NmEUtxJVfjTOBHg75nBaiJxAKhS2nzkRVkNJZTJep3rdiq5-5_nNHV4lioUm6CtKqmzeucpg1myW5kknJ4J5avyuXF-MO6lkGqsEX1XxWh0H2Rq0n2LuMX9uApaQ6Kqd8zFA5_QcG-2gR1TawWmh-lFn1L0s9JpL73UiMznNrtxj0GLaGHrgvFPGiV5f9uh3lEpCmhpww'\
  -d 'user_pass=camtien'

  curl -X 'POST' \
  'http://127.0.0.1:5000/api/v1/users' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -d 'email=test56%40gmail.com&username=test56&password=000000&phone=012345678'




```
