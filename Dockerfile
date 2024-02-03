FROM maven:3.9.6-eclipse-temurin-21-alpine AS build
WORKDIR /app
ADD . /app
RUN --mount=type=cache,target=/root/.m2 mvn -f /app/pom.xml clean package
RUN ls -l /app

FROM openjdk:11-jre-slim
WORKDIR /app
COPY - from=build /app/target/my-application.jar .
CMD ["java", "-jar", "my-application.jar"]
