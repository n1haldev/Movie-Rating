package com.mvc_lab.movies.Repository;

import com.mvc_lab.movies.Models.Movie;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MovieRepo extends MongoRepository<Movie, ObjectId> {
    Movie findMovieById(Long id);
    void deleteById(Long id);
}
