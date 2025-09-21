# Stage 1: Build
FROM maven:3.9.9-eclipse-temurin-21 AS build

WORKDIR /app

# Copy only the files needed for build
COPY journal/pom.xml .
COPY journal/src ./src

# Package the Spring Boot application without running tests
RUN mvn clean package -DskipTests

# Stage 2: Runtime
FROM eclipse-temurin:21-jre

WORKDIR /app

# Copy the built JAR from the build stage
COPY --from=build /app/target/*.jar app.jar

# Create a non-root user for security
RUN addgroup --system --gid 1001 spring && \
    adduser --system --uid 1001 --gid 1001 spring
USER spring

EXPOSE 8080

# Use Render's PORT environment variable if provided
ENTRYPOINT ["java", "-jar", "-Dserver.port=${PORT:-8080}", "/app/app.jar"]
