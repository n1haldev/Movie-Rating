package com.mvc_lab.movies.Controllers;

import com.mvc_lab.movies.Models.Movie;
import com.mvc_lab.movies.Repository.MovieRepo;
import com.mvc_lab.movies.Services.MovieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/")
public class MovieController {
    @Autowired
    private MovieService movieService;
    private MovieRepo movieRepo;

    @GetMapping("/view")
    public ResponseEntity<List<Movie>> viewMovieList() {
         return ResponseEntity.ok().body(movieService.getAllMovies());
    }

    @GetMapping("/rate")
    public ResponseEntity<String> addRating(@RequestParam Long id, @RequestParam double rating) {
        System.out.println(id + " " + rating);
        try {
            movieService.rateMovie(id, rating);
            return ResponseEntity.ok("Rating added successfully!");
        }
        catch (Exception e) {
            return ResponseEntity.internalServerError().body("Error : " + e.getMessage());
        }
    }

    @PostMapping("/add-movie")
    public ResponseEntity<String> addMovie(@RequestBody Movie movie) {
        try {
            if(movieService.findMovieById(movie.getId()).isPresent()) {
                return ResponseEntity.ok("The movie to be added is already present in the list!");
            }
            movieService.addMovie(movie);
            movieRepo.save(movie);
            return ResponseEntity.ok("The movie was added to the database successfully!");
        }
        catch(Exception e) {
            return ResponseEntity.internalServerError().body("Error : " + e.getMessage());
        }
    }

    @DeleteMapping("/remove-movie/{id}")
    public ResponseEntity<String> removeMovie(@PathVariable Long id) {
        try {
            if(!movieService.findMovieById(id).isPresent()) {
                return ResponseEntity.ok("The movie to be removed is not present in the list!");
            }
            movieService.removeMovie(id);

            return ResponseEntity.ok("The movie was removed from the list successfully!");
        }
        catch(Exception e) {
            return ResponseEntity.internalServerError().body("Error : " + e.getMessage());
        }
    }

    @GetMapping("/")
    public String frontend() {
        return "movies";
    }
}
