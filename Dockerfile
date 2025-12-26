FROM eclipse-temurin:17-jdk-alpine

# Port the app runs on
EXPOSE 8080

# Define the working directory
WORKDIR /usr/src/app

# Copy the jar into the current WORKDIR
# Using *.jar is fine as long as there is only one jar in the target folder
COPY target/*.jar app.jar

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
