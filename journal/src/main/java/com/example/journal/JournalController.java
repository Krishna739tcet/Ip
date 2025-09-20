package com.example.journal;

import org.springframework.web.bind.annotation.*;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/journal")
@CrossOrigin(origins = "*")
public class JournalController {

    private List<JournalEntry> entries = new ArrayList<>();
    private int nextId = 1;

    @GetMapping
    public List<JournalEntry> getAll() {
        return entries;
    }

    @PostMapping
    public JournalEntry addEntry(@RequestBody JournalEntry entry) {
        entry.setId(nextId++);
        entries.add(entry);
        return entry;
    }

    @PutMapping("/{id}")
    public void updateEntry(@PathVariable int id, @RequestBody JournalEntry entry) {
        for (int i = 0; i < entries.size(); i++) {
            if (entries.get(i).getId() == id) {
                entry.setId(id);
                entries.set(i, entry);
                return;
            }
        }
    }

    @DeleteMapping("/{id}")
    public void deleteEntry(@PathVariable int id) {
        entries.removeIf(e -> e.getId() == id);
    }
}
