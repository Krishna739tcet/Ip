# ---------- BUILD STAGE ----------
# Use Maven with JDK 21 to build your Spring Boot project
FROM maven:3.9.9-eclipse-temurin-21 AS build
WORKDIR /app

# Copy everything and build (skip tests for faster builds)
COPY . .
RUN mvn clean package -DskipTests

# ---------- RUNTIME STAGE ----------
# Use a lightweight JDK image just to run the jar
FROM eclipse-temurin:21-jre
WORKDIR /app

# Copy the jar from build stage to runtime stage
COPY --from=build /app/target/*.jar app.jar

# Expose the port Spring Boot uses
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java","-jar","app.jar"]
