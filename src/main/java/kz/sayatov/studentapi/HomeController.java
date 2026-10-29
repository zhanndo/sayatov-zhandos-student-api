package kz.sayatov.studentapi;

import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HomeController {

    @Value("${app.author}")
    private String author;

    @Value("${app.version}")
    private String version;

    @GetMapping("/")
    public Map<String, String> home() {
        return Map.of(
                "application", "Student API",
                "author", author,
                "group", "IT2-2309",
                "version", version);
    }
}
