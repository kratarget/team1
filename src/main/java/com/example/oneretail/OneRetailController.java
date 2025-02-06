package com.example.oneretail;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Collections;
import java.util.Map;

@RestController
public class OneRetailController {

    @Value("${app.version:1.0.0}")
    private String version;

    @GetMapping("/healthcheck")
    public Map<String, String> healthcheck() {
        return Collections.singletonMap("version", version);
    }

    @GetMapping("/")
    public Map<String, String> greet(@RequestParam(name="name", defaultValue="World") String name) {
        return Collections.singletonMap("greeting", "Hello " + name);
    }
}
