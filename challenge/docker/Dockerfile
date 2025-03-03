# Build stage
FROM openjdk:17-jdk-slim AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN ./mvnw package -DskipTests

# Runtime stage
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar

# Add a non-root user for security
RUN useradd -m appuser && chown appuser:appuser /app
USER appuser

# Expose the application port
EXPOSE 8080

# Health check to ensure the application is running
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
    CMD curl -f http://localhost:8080/actuator/health || exit 1

# Entry point to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]