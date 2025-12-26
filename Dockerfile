# STAGE 1: The Builder
# This stage pulls a heavy image with Maven and the JDK installed.
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app

# Copy the pom.xml and source code into the builder
COPY . .

# Run the Maven command to create the /target folder and the .jar file
RUN mvn clean package -DskipTests

# STAGE 2: The Final Image (Your original base)
# We switch to the lightweight Alpine image for production.
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /usr/src/app

# IMPORTANT: We copy the jar FROM the 'build' stage above, 
# instead of looking for it on your computer.
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]