package kz.sayatov.studentapi;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface StudentRepository extends JpaRepository<Student, Long> {

    // Find students whose last name contains the given text (case-insensitive)
    List<Student> findByLastNameContainingIgnoreCase(String lastName);
}
