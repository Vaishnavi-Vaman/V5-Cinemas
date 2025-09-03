<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Super Admin Dashboard</title>

    <!-- ✅ Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- ✅ Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <style>
      body {
    background: linear-gradient(to bottom right, #1c1c1e, #2c2c2e);
    padding: 20px;
    color: #e0e0e0;
    font-family: 'Segoe UI', sans-serif;
}

h1 {
    margin-bottom: 30px;
    color: #f5c518; /* IMDb gold */
}

.msg {
    color: #4caf50;
    font-weight: bold;
    text-align: center;
}

.err {
    color: #f44336;
    font-weight: bold;
    text-align: center;
}

.poster {
    width: 80px;
    border-radius: 6px;
    border: 2px solid #444;
}

.table-responsive {
    margin-bottom: 20px;
}

.form-label {
    font-weight: 500;
    color: #000000;
}

.btn-reject {
    background-color: #d32f2f;
    color: white;
    border: none;
}

.btn-reject:hover {
    background-color: #b71c1c;
}

.button-link {
    background-color: #2196f3;
    color: white;
    padding: 6px 12px;
    border-radius: 5px;
    text-decoration: none;
}

.button-link:hover {
    background-color: #1976d2;
}

.center-cell {
    text-align: center;
    color: #f5f5f5;
}



.modal-title {
    color: #000000;
    font-weight: 600;
}

        
    </style>
</head>
<body>
<div class="container">

    <!-- 🔹 Header with Title & Buttons -->
    <div class="d-flex justify-content-between align-items-center mb-4">
       <h1>
    Super Admin Dashboard 
    <c:if test="${not empty pendingAdmins}">
        <span class="badge bg-danger ms-2" 
              role="button" 
              data-bs-toggle="modal" 
              data-bs-target="#pendingRequestsModal">
            ${fn:length(pendingAdmins)} Pending Requests
        </span>
    </c:if>
</h1>

        <div>
            <!-- 🔹 Add Movie Button (Opens Modal) -->
            <button class="btn btn-primary me-2" data-bs-toggle="modal" data-bs-target="#addMovieModal">
                <i class="bi bi-plus-circle"></i> Add Movie
            </button>
            <a href="Login.jsp" class="btn btn-danger"><i class="bi bi-box-arrow-right"></i> Logout</a>
        </div>
    </div>

    <c:if test="${not empty param.msg}">
        <p class="msg">${param.msg}</p>
    </c:if>
    <c:if test="${not empty param.error}">
        <p class="err">${param.error}</p>
    </c:if>

    <!-- 🔹 Pending Admin Requests Section -->
   <%--  <div class="mb-5" id="pendingRequestsSection">
        <div class="card shadow-sm">
            <div class="card-body">
                <h2 class="card-title"><i class="bi bi-person-lines-fill"></i> Pending Admin Requests</h2>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead class="table-primary">
                            <tr><th>Name</th><th>Email</th><th>License</th><th>Action</th></tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${not empty pendingAdmins}">
                                <c:forEach var="u" items="${pendingAdmins}">
                                    <tr>
                                        <td><c:out value="${u.name}"/></td>
                                        <td><c:out value="${u.email}"/></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty u.licensePath}">
                                                    <a href="${u.licensePath}" target="_blank">View License</a>
                                                </c:when>
                                                <c:otherwise>No license</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="d-flex justify-content-center gap-5 mt-1">
                                                <form action="ApproveRejectAdmin" method="post" class="d-inline">
                                                    <input type="hidden" name="userId" value="${u.userId}" />
                                                    <input type="hidden" name="action" value="approve" />
                                                    <button type="submit" class="btn btn-success btn-sm">Approve</button>
                                                </form>
                                                <form action="ApproveRejectAdmin" method="post" class="d-inline">
                                                    <input type="hidden" name="userId" value="${u.userId}" />
                                                    <input type="hidden" name="action" value="reject" />
                                                    <button type="submit" class="btn btn-reject btn-sm">Reject</button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr><td colspan="4">No pending requests</td></tr>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div> --%>

    <!-- 🎬 Global Movies Section with Search -->
    <div class="mb-5">
        <div class="card shadow-sm">
            <div class="card-body">
                <h2 class="card-title"><i class="bi bi-film"></i> Global Movies</h2>

                <!-- 🔍 Search Bar -->
                <div class="mb-3">
                    <input type="text" id="movieSearch" class="form-control" placeholder="Search by title, language, or genre..." onkeyup="filterMovies()" />
                </div>

                <div class="table-responsive">
                    <table class="table table-bordered table-hover" id="movieTable">
                        <thead class="table-primary">
                            <tr>
                                <th>Poster</th><th>Title</th><th>Language</th><th>Duration</th><th>Genre</th><th>Release</th><th>Trailer</th><th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="m" items="${movies}">
                            <tr>
                                <td><c:if test="${not empty m.posterUrl}"><img class="poster" src="${m.posterUrl}" alt="poster"/></c:if></td>
                                <td><c:out value="${m.title}"/></td>
                                <td><c:out value="${m.language}"/></td>
                                <td><c:out value="${m.duration}"/></td>
                                <td><c:out value="${m.genre}"/></td>
                                <td><c:out value="${m.releaseDate}"/></td>
                                <td><c:if test="${not empty m.trailerUrl}"><a href="${m.trailerUrl}" target="_blank">Watch</a></c:if></td>
                                <td>
                                    <div class="d-flex justify-content-center mt-1">
                                        <a href="DeleteMovie?movieId=${m.movieId}"
                                           class="btn btn-danger btn-sm px-4 py-2"
                                           onclick="return confirm('Delete this movie?');">
                                            Delete
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

</div>

<!-- 🎬 Add Movie Modal -->
<div class="modal fade" id="addMovieModal" tabindex="-1" aria-labelledby="addMovieModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content">
      
      <div class="modal-header">
        <h5 class="modal-title"><i class="bi bi-plus-circle"></i> Add New Movie</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <div class="modal-body">
        <form id="addMovieForm" action="AddMovie" method="post">
            <div class="mb-2">
                <label class="form-label">Title:</label>
                <input type="text" id="title" name="title" class="form-control" required />
                <small id="titleError" class="text-danger"></small>
            </div>
            <div class="mb-2">
                <label class="form-label">Language:</label>
                <input type="text" id="language" name="language" class="form-control" required/>
                <small id="languageError" class="text-danger"></small>
            </div>
            <div class="mb-2">
                <label class="form-label">Duration:</label>
               <input type="number" name="duration" min="1" placeholder="Enter duration in minutes"
               required/>
            </div>
            <div class="mb-2">
                <label class="form-label">Genre:</label>
                <input type="text" name="genre" class="form-control" required/>
            </div>
            <div class="mb-2">
                <label class="form-label">Release Date:</label>
                <input type="date" name="release_date" class="form-control" required/>
            </div>
            <div class="mb-2">
                <label class="form-label">Poster URL:</label>
                <input type="text" name="poster_url" class="form-control"/>
            </div>
            <div class="mb-2">
                <label class="form-label">Trailer URL:</label>
                <input type="text" name="trailer_url" class="form-control"/>
            </div>
            <button type="submit" class="btn btn-primary w-100">Add Movie</button>
        </form>
      </div>

    </div>
  </div>
</div>
<!-- Pending Requests Modal -->
<!-- Pending Requests Modal -->
<div class="modal fade" id="pendingRequestsModal" tabindex="-1" aria-labelledby="pendingRequestsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            
            <div class="modal-header">
                <h5 class="modal-title" id="pendingRequestsModalLabel">Pending Admin Requests</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <div class="modal-body">
                <c:if test="${not empty pendingAdmins}">
                    <table class="table table-bordered table-striped">
                        <thead class="table-dark">
                            <tr>
                                <th>Name</th>
                                <th>Email</th>
                                <th>License</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="admin" items="${pendingAdmins}">
                                <tr>
                                    <td>${admin.name}</td>
                                    <td>${admin.email}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty admin.licensePath}">
                                                <a href="${admin.licensePath}" target="_blank">View License</a>
                                            </c:when>
                                            <c:otherwise>No license</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <!-- ✅ Approve -->
                                        <form action="ApproveRejectAdmin" method="post" class="d-inline">
                                            <input type="hidden" name="userId" value="${admin.userId}" />
                                            <input type="hidden" name="email" value="${admin.email}" /> <!-- 🔹 Needed -->
                                            <input type="hidden" name="action" value="approve" />
                                            <button type="submit" class="btn btn-success btn-sm">Approve</button>
                                        </form>
                                        <!-- ✅ Reject -->
                                        <form action="ApproveRejectAdmin" method="post" class="d-inline">
                                            <input type="hidden" name="userId" value="${admin.userId}" />
                                            <input type="hidden" name="email" value="${admin.email}" /> <!-- 🔹 Needed -->
                                            <input type="hidden" name="action" value="reject" />
                                            <button type="submit" class="btn btn-reject btn-sm">Reject</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${empty pendingAdmins}">
                    <p class="text-muted">No pending requests found.</p>
                </c:if>
            </div>
        </div>
    </div>
</div>

<!-- ✅ Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- 🔍 Movie Filter Script -->
<script>
function filterMovies() {
    const input = document.getElementById("movieSearch").value.toLowerCase();
    const rows = document.querySelectorAll("#movieTable tbody tr");

    rows.forEach(row => {
        const title = row.cells[1]?.textContent.toLowerCase();
        const language = row.cells[2]?.textContent.toLowerCase();
        const genre = row.cells[4]?.textContent.toLowerCase();

        if (title.includes(input) || language.includes(input) || genre.includes(input)) {
            row.style.display = "";
        } else {
            row.style.display = "none";
        }
    });
}
</script>

<!-- 🚫 Live Duplicate Validation -->
<script>
function getExistingMovies() {
    const rows = document.querySelectorAll("#movieTable tbody tr");
    const movies = [];
    rows.forEach(row => {
        const title = row.cells[1]?.textContent.trim().toLowerCase();
        const language = row.cells[2]?.textContent.trim().toLowerCase();
        if (title && language) {
            movies.push({ title, language });
        }
    });
    return movies;
}

function checkDuplicate() {
    const titleInput = document.getElementById("title");
    const langInput = document.getElementById("language");
    const title = titleInput.value.trim().toLowerCase();
    const language = langInput.value.trim().toLowerCase();
    const existingMovies = getExistingMovies();

    document.getElementById("titleError").textContent = "";
    document.getElementById("languageError").textContent = "";

    if (title && language) {
        const duplicate = existingMovies.some(m =>
            m.title === title && m.language === language
        );
        if (duplicate) {
            document.getElementById("titleError").textContent = "Duplicate Title + Language already exists!";
            document.getElementById("languageError").textContent = "Duplicate Title + Language already exists!";
            titleInput.classList.add("is-invalid");
            langInput.classList.add("is-invalid");
            return false;
        } else {
            titleInput.classList.remove("is-invalid");
            langInput.classList.remove("is-invalid");
        }
    }
    return true;
}

// live check
document.getElementById("title").addEventListener("input", checkDuplicate);
document.getElementById("language").addEventListener("input", checkDuplicate);

// final safeguard on submit
document.getElementById("addMovieForm").addEventListener("submit", function(e){
    if(!checkDuplicate()){
        e.preventDefault();
    }
});
</script>

</body>
</html>