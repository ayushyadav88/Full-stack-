# STAGE 1: Build the JAR file
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY . .
# This command creates the 'target/' directory that was missing
RUN mvn clean package -DskipTests

# STAGE 2: Run the application
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /usr/src/app
# Copy the built jar from the 'build' stage
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]