<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Movie | V5 Cinemas</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #121212;
            color: #fff;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }
        h2 {
            color: #ff3c3c;
            margin-bottom: 20px;
        }
        form {
            background: #1e1e1e;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(255, 60, 60, 0.4);
            display: flex;
            flex-direction: column;
            width: 400px;
        }
        label {
            margin-top: 15px;
            margin-bottom: 5px;
        }
        input[type="text"],
        input[type="number"] {
            padding: 10px;
            border-radius: 6px;
            border: none;
            width: 100%;
        }
        input[type="submit"] {
            margin-top: 25px;
            background-color: #ff3c3c;
            color: #fff;
            padding: 12px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
        }
        input[type="submit"]:hover {
            background-color: #e73333;
        }
    </style>
</head>
<body>
    <h2>Add New Movie</h2>
    <form action="AddMovieServlet" method="post">
        <label for="title">Movie Title</label>
        <input type="text" name="title" id="title" required>

        <label for="language">Language</label>
        <input type="text" name="language" id="language" required>

        <label for="timing">Timing (e.g., 2:30 PM)</label>
        <input type="text" name="timing" id="timing" required>

        <label for="price">Price</label>
        <input type="number" step="0.01" name="price" id="price" required>

        <label for="theaterId">Theater ID</label>
        <input type="number" name="theaterId" id="theaterId" required>

        <label for="posterUrl">Poster URL</label>
        <input type="text" name="posterUrl" id="posterUrl" required>

        <label for="trailerUrl">Trailer URL</label>
        <input type="text" name="trailerUrl" id="trailerUrl" required>

        <input type="submit" value="Add Movie">
    </form>
</body>
</html>
