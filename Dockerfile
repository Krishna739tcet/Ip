# Step 1: Build stage
FROM maven:3.9.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Step 2: Runtime stage
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# Expose the port Spring Boot uses
EXPOSE 8080

# Run the app
ENTRYPOINT ["java","-jar","app.jar"]
