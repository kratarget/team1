FROM eclipse-temurin:17
RUN mkdir /opt/app
COPY target/*.jar /opt/app
CMD ["java", "-jar", "/opt/app/oneretail-1.0.0.jar"]
