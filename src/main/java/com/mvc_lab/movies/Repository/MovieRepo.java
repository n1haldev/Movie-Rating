package com.mvc_lab.movies.Repository;

import com.mvc_lab.movies.Models.Movie;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface MovieRepo extends MongoRepository<Movie, ObjectId> {
    List<Movie> findMovieById(Long id);
}
