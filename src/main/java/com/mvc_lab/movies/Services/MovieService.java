package com.mvc_lab.movies.Services;

import com.mvc_lab.movies.Models.Movie;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class MovieService {
    private final List<Movie> movieList;
    public MovieService() {
         movieList = new ArrayList<>();
         movieList.add(new Movie(1L, "Movie 1", 2022, "Action", "Director 1", 4.5));
         movieList.add(new Movie(2L, "Movie 2", 2019, "Comedy", "Director 2", 3.8));
         movieList.add(new Movie(3L, "Movie 3", 2020, "Drama", "Director 3", 4.2));
    }
    public List<Movie> getAllMovies() {
        return movieList;
    }
    public void rateMovie(Long id, double rating) {
        for (Movie movie : movieList) {
            if (movie.getId().equals(id)) {
                movie.setAverageRating((movie.getAverageRating() + rating) / 2);
                break;
            }
        }
    }

    public Optional<Movie> findMovieById(Long id) {
        if(movieList != null) {
            for(Movie movie : movieList) {
                if(movie.getId() == id) {
                    return Optional.of(movie);
                }
            }
        }
        return Optional.empty();
    }

    public void addMovie(Movie movie) {
        movieList.add(movie);
    }

    public void removeMovie(Long id) {
        Optional<Movie> movie = findMovieById(id);
        movie.ifPresent(movieList::remove);
    }
}
