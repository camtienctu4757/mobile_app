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
docker run --rm --add-host postgres-dev.us:10.0.0.1 -v `pwd`/pki/postgres:/liquibase/pki  -v `pwd`/migrations:/liquibase/changelog liquibase/liquibase:4.28.0 update  \
  --changelog-file=changelog/wrapper.yaml \
  --url="jdbc:postgresql://postgres-dev.us:5000/beauti_app_dev_svcs?ssl=true&sslmode=verify-full&sslrootcert=/liquibase/pki/ca-chain.cert.pem" --username=beauti_app_dev_svcs --password=000000
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

# run project
```sh
docker run --rm --name app --add-host postgres-dev.us:10.0.0.1 \
--add-host redis1.us:10.0.0.2 --add-host redis2.us:10.0.0.3 \
--add-host redis3.us:10.0.0.4 --add-host redis4.us:10.0.0.5 \
--add-host redis5.us:10.0.0.6 --add-host redis6.us:10.0.0.7 \
--add-host minio.us:10.0.0.8 --add-host dev.vn:113.100.100.100 \
--add-host kafka-broker1.us:10.0.0.9 --add-host kafka-broker2.us:10.0.0.10 \
-p 5000:5000 -v /mnt/hgfs/fastapi/beautyapp/user-svc/app:/app app:v1

```

# test db
``` sh
psql "host=postgres.us port=5000 user=postgres password=0000000 sslmode=verify-full sslrootcert=pki/postgres/ca-chain.cert.pem sslcert=pki/postgres/postgres_client.cert.pem sslkey=pki/postgres/postgres_client.key.pem"

pg_dump -U postgres -W -h postgres.us -p 5000 -F p -d beauti_app_dev_svcs > mydatabase.sql


```

# cron để xóa time-slot
``` sql
SELECT cron.schedule('0 0 * * *', $$ 
    DELETE FROM time_slots WHERE slot_date < CURRENT_DATE;
    WITH RECURSIVE time_slots_generator AS (
        SELECT '10:00'::time AS start_time, ('10:00'::time + INTERVAL '30 minutes') AS end_time
        UNION ALL
        SELECT end_time AS start_time, (end_time + INTERVAL '30 minutes') AS end_time
        FROM time_slots_generator
        WHERE end_time < '17:00'::time
    ),
    active_employees AS (
        SELECT employee_uuid
        FROM employees
        WHERE employee_uuid NOT IN (
            SELECT employee_uuid FROM employee_absences WHERE absence_date = CURRENT_DATE + INTERVAL '3 days'
        )
    )
    INSERT INTO time_slots (service_uuid, start_time, end_time, available_employees, slot_date)
    SELECT 'service-uuid', tg.start_time, tg.end_time, COUNT(ae.employee_uuid), CURRENT_DATE + INTERVAL '3 days'
    FROM time_slots_generator tg
    CROSS JOIN active_employees ae
    GROUP BY tg.start_time, tg.end_time;
$$);


EXPLAIN ANALYZE SELECT 
    Appointment.appointment_uuid,
    Service.service_name,
    Service.price,
    Service.duration,
    Shop.shop_name,
    Shop.address,
    TimeSlot.slot_date,
    TimeSlot.start_time
FROM 
    appointments AS Appointment
JOIN 
    time_slots AS TimeSlot ON Appointment.timeslot_uuid = TimeSlot.slot_uuid
JOIN 
    services AS Service ON TimeSlot.service_uuid = Service.service_uuid
JOIN 
    shops AS Shop ON Service.shop_uuid = Shop.shop_uuid
WHERE 
    Appointment.appointment_uuid  = '7626ec5e-1807-489c-9f35-5146cf3aa946';

```
# cron để create time-slot
``` sh
pip install APScheduler

```
```sql
SELECT a.*, t.*, s.*, sh.*
FROM appointments a
JOIN time_slots t ON a.timeslot_uuid = t.slot_uuid
JOIN services s ON t.service_uuid = s.service_uuid
JOIN shops sh ON s.shop_uuid = sh.shop_uuid;

SELECT 
    a.appointment_uuid, 
    s.service_name, 
    s.price, 
    s.duration, 
    sh.shop_name, 
    sh.address, 
    t.slot_date, 
    t.start_time 
FROM 
    appointments a
JOIN 
    time_slots t ON a.timeslot_uuid = t.slot_uuid
JOIN 
    services s ON t.service_uuid = s.service_uuid
JOIN 
    shops sh ON s.shop_uuid = sh.shop_uuid
WHERE 
    a.appointment_uuid = '';
```