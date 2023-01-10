FROM alpine/git
WORKDIR /app
RUN git clone https://github.optum.com/sbhaisar/MavenTest.git

FROM maven:3.5-jdk-8-alpine
WORKDIR /app
COPY --from=0 /app/MavenTest /app
RUN mvn clean package install

FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=1 /app/target/test-maven-0.0.1.jar /app
# ADD /target/test-maven-0.0.1.jar /app/app.jar
ENTRYPOINT ["java","-cp","test-maven-0.0.1.jar","com.optum.rxclaim.App"]
