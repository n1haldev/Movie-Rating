package com.mvc_lab.movies.Models;

import lombok.*;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Movie {
    private Long id;

    private String title;

    private int releaseYear;

    private String genre;

    private String director;

    private double averageRating;
}
