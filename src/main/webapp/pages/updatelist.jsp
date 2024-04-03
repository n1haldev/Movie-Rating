<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chillflex - Movies</title>
    <style>
        /* General styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
            margin-top: 20px;
        }

        /* Form styles */
        form {
            max-width: 400px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        input[type="text"],
        input[type="number"] {
            width: calc(100% - 10px);
            margin-bottom: 10px;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }

        input[type="submit"] {
            width: 100%;
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px;
            border-radius: 3px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
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

        /* Remove button styles */
        .remove-button {
            background-color: #dc3545;
            color: #fff;
            border: none;
            padding: 10px;
            border-radius: 3px;
            cursor: pointer;
            margin-top: 10px;
        }

        .remove-button:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
    <h1>Chillflex - Movies</h1>

    <!-- Add movie form -->
    <form id="addMovieForm">
        <h2>Add Movie</h2>
        <input type="text" name="title" placeholder="Title" required>
        <input type="number" name="releaseYear" placeholder="Release Year" required>
        <input type="text" name="genre" placeholder="Genre" required>
        <input type="text" name="director" placeholder="Director" required>
        <input type="submit" value="Add Movie">
    </form>

    <!-- Movie cards container -->
    <div id="cartContainer"></div>

    <script>
        async function getMovies() {
            try {
                const response = await fetch('<%= request.getContextPath() %>/view');
                const movies = await response.json();

                const cardsHTML = movies.map(movie => {
                    return `
                        <div class="card">
                            <h2>\${movie.title}</h2>
                            <p>Release Year: \${movie.releaseYear}</p>
                            <p>Genre: \${movie.genre}</p>
                            <p>Director: \${movie.director}</p>
                            <p>Average Rating: \${movie.averageRating}</p>
                            <button class="remove-button" onclick="removeMovie(\${movie.id})">Remove Movie</button>
                        </div>
                    `;
                }).join('');

                document.getElementById('cartContainer').innerHTML = cardsHTML;
            } catch(error) {
                console.error('Error fetching movies:', error);
            }
        }

        async function addMovie(event) {
            event.preventDefault();
            const formData = new FormData(document.getElementById('addMovieForm'));
            try {
                const response = await fetch('<%= request.getContextPath() %>/add-movie', {
                    method: 'POST',
                    body: JSON.stringify(Object.fromEntries(formData.entries())),
                    headers: {
                        'Content-Type': 'application/json'
                    }
                });
                const message = await response.text();
                console.log(message);
                getMovies(); // Refresh movie list after adding
            } catch(error) {
                console.error('Error adding movie:', error);
            }
        }

        async function removeMovie(id) {
            try {
                const response = await fetch('<%= request.getContextPath() %>/remove-movie/' + id, {
                    method: 'DELETE'
                });
                const message = await response.text();
                console.log(message);
                getMovies(); // Refresh movie list after removal
            } catch(error) {
                console.error('Error removing movie:', error);
            }
        }

        window.onload = function() {
            getMovies();
            document.getElementById('addMovieForm').addEventListener('submit', addMovie);
        };
    </script>
</body>
</html>
