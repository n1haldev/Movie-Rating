<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chillflex - Cart</title>
    <style>
        /* General styles */
        body {
            font-family: sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
            margin-top: 20px;
        }

        /* Cart container */
        #cartContainer {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            padding: 20px;
        }

        /* Movie card styles */
        .card {
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin: 10px;
            width: 300px;
            padding: 20px;
            display: flex;
            flex-direction: column;
        }

        .card h2 {
            margin-top: 0;
        }

        .card p {
            margin: 5px 0;
        }

        /* Rating button styles */
        .rating-buttons {
            display: flex;
            justify-content: center;
            margin-bottom: 10px;
        }

        .rating-button {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-right: 10px;
            outline: none; /* Remove button outline on click */
        }

        .rating-button:hover {
            background-color: #0056b3;
        }

        .rating-button:focus {
            box-shadow: 0 0 0 2px #0056b3; /* Add focus border */
        }
    </style>
</head>
<body>
    <h1>Chillflex - Cart</h1>
    <div class="rating-buttons">
        <!-- Rating buttons will be dynamically added here -->
    </div>
    <div id="cartContainer">
        <!-- Movie cards will be dynamically added here -->
    </div>

    <script>

        async function rateMovie(movieId, rating) {
            try {
                const response = await fetch('<%= request.getContextPath() %>/rate?id=' + movieId + '&rating=' + rating);
                const message = await response.text();
                console.log(message);
                // Refresh movie list after rating
                getMovies();
            } catch(error) {
                console.error('Error rating movie:', error);
            }
        }

        async function getMovies() {
            try {
                const response = await fetch('<%= request.getContextPath() %>/view');
                const movies = await response.json();

                const cardsHTML = movies.map(movie => {
                    console.log(movie.averageRating);
                    return `
                        <div class="card">
                            <h2>\${movie.title}</h2>
                            <p>Release Year: \${movie.releaseYear}</p>
                            <p>Genre: \${movie.genre}</p>
                            <p>Director: \${movie.director}</p>
                            <p>Average Rating: \${movie.averageRating}</p>
                            <div class="rating-buttons">
                                <!-- Add a button to rate the movie -->
                                <button class="rating-button" onclick="rateMovie(\${movie.id}, 1)">1</button>
                                <button class="rating-button" onclick="rateMovie(\${movie.id}, 2)">2</button>
                                <button class="rating-button" onclick="rateMovie(\${movie.id}, 3)">3</button>
                                <button class="rating-button" onclick="rateMovie(\${movie.id}, 4)">4</button>
                                <button class="rating-button" onclick="rateMovie(\${movie.id}, 5)">5</button>
                            </div>
                        </div>
                    `;
                }).join('');

                document.getElementById('cartContainer').innerHTML = cardsHTML;
            } catch(error) {
                console.error('Error fetching movies:', error);
            }
        }
        window.onload = getMovies;
    </script>
</body>
</html>
