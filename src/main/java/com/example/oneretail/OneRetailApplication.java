package com.example.oneretail;

import io.opentelemetry.api.GlobalOpenTelemetry;
import io.opentelemetry.api.OpenTelemetry;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.util.logging.Level;
import java.util.logging.Logger;

@SpringBootApplication
public class OneRetailApplication {
    private static final Logger LOGGER = Logger.getLogger(OneRetailApplication.class.getName());

    public static void main(String[] args) {
        try {
            SpringApplication.run(OneRetailApplication.class, args);
            LOGGER.info("✅ Application started successfully.");
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "❌ Application failed to start: " + e.getMessage(), e);
        }

        // Try to initialize OpenTelemetry and catch errors
        try {
            GlobalOpenTelemetry.get();
            LOGGER.info("✅ OpenTelemetry initialized successfully.");
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "⚠️ OpenTelemetry could not initialize. Tracing/logging may be disabled. " + e.getMessage());
        }
    }
}
