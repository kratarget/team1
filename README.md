### **📜 README for OneRetail API**  

# **OneRetail API**  
OneRetail est une application **Spring Boot** conçue pour être utilisée dans un **Proof of Concept (PoC) / Hackathon** afin de tester et valider des pipelines CI/CD et l’instrumentation avec **OpenTelemetry**.  

---

## **🚀 Fonctionnalités des APIs**  

### **1️⃣ Healthcheck API**  
✅ **Vérifie la version de l’application.**  

- **📌 Endpoint** : `GET /healthcheck`  
- **🔄 Requête** : Aucune  
- **📤 Réponse JSON** :  
```json
{
  "version": "1.0.0"
}
```
- **🛠️ Utilisation (cURL)** :  
```bash
curl -X GET http://localhost:8080/healthcheck
```

---

### **2️⃣ Hello API**  
✅ **Renvoie un message de bienvenue avec un paramètre dynamique.**  

- **📌 Endpoint** : `GET /`  
- **🔄 Paramètre Query** : `name` *(facultatif, valeur par défaut : "World")*  
- **📤 Réponse JSON** :  
```json
{
  "message": "Hello <name>"
}
```
- **🛠️ Utilisation (cURL)** :  
```bash
curl -X GET "http://localhost:8080/?name=OneRetail"
```
- **🔄 Exemples de Réponses** :  
  - 🔹 **Requête** : `GET /?name=OneRetail`  
    **Réponse** :
    ```json
    {"message": "Hello OneRetail"}
    ```
  - 🔹 **Requête** : `GET /` *(sans paramètre)*  
    **Réponse** :
    ```json
    {"message": "Hello World"}
    ```

---

## **⚙️ Build**  

### **1️⃣ Builder l’application avec Maven**  
```bash
mvn clean package
```

### **2️⃣ Lancer l'application avec le SDK OpenTelemetry**  
```bash
curl -sSL -o ./opentelemetry-javaagent.jar https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/latest/download/opentelemetry-javaagent.jar

export OTEL_TRACES_EXPORTER=otlp
export OTEL_METRICS_EXPORTER=otlp
export OTEL_LOGS_EXPORTER=otlp
export OTEL_EXPORTER_OTLP_ENDPOINT=http://otel-collector:4318
export OTEL_SERVICE_NAME="one-retail-app"

java -javaagent:./opentelemetry-javaagent.jar -jar target/oneretail-1.0.0.jar
```

### **3️⃣ Tester l’API avec cURL**  
```bash
curl -X GET http://localhost:8080/healthcheck
```
ou
```bash
curl -X GET http://localhost:8080/?name=Octopus
```

---
