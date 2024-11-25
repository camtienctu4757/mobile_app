# syntax=docker/dockerfile:1.3

FROM maven:3.8.7-openjdk-18 as build-code

LABEL maintainer="tribao"

WORKDIR /tmp/build

COPY . /tmp/build

RUN --mount=type=cache,target=/root/.m2 mvn -f /tmp/build/pom.xml clean package -Pextensions -DskipTests=true

# FROM registry.access.redhat.com/ubi8/openjdk-17:1.19

# ENV LANGUAGE='en_US:en'

# # We make four distinct layers so if there are application changes the library layers can be re-used
# COPY --from=build-code --chown=185 /tmp/build/target/quarkus-app/lib/ /deployments/lib/
# COPY --from=build-code --chown=185 /tmp/build/target/quarkus-app/*.jar /deployments/
# COPY --from=build-code --chown=185 /tmp/build/target/quarkus-app/app/ /deployments/app/
# COPY --from=build-code --chown=185 /tmp/build/target/quarkus-app/quarkus/ /deployments/quarkus/

# EXPOSE 8080
# USER 185
# ENV JAVA_OPTS_APPEND="-Dquarkus.http.host=0.0.0.0 -Djava.util.logging.manager=org.jboss.logmanager.LogManager"
# ENV JAVA_APP_JAR="/deployments/quarkus-run.jar"

# ENTRYPOINT [ "/opt/jboss/container/java/run/run-java.sh" ]

FROM quay.io/keycloak/keycloak:25.0.6

COPY --from=build-code /tmp/build/target/user-storage-provider-keycloak-jar-with-dependencies.jar /opt/keycloak/providers

RUN /opt/keycloak/bin/kc.sh build

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start-dev"]
