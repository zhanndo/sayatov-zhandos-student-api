# ---------- Stage 1: build the jar with Gradle on a full JDK ----------
FROM eclipse-temurin:21-jdk AS build
WORKDIR /app

# Copy Gradle files first so dependencies are cached in their own layer
COPY gradlew settings.gradle build.gradle ./
COPY gradle ./gradle
RUN chmod +x gradlew && ./gradlew dependencies --no-daemon > /dev/null

# Copy the source code and build the executable jar (tests run in Jenkins)
COPY src ./src
RUN ./gradlew bootJar --no-daemon -x test

# ---------- Stage 2: small runtime image with only the JRE ----------
FROM eclipse-temurin:21-jre
LABEL author="Zhandos Sayatov" group="IT2-2309"
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
