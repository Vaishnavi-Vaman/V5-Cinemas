<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <title>V5 CINEMAS - Home</title>
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    :root{
      --gold: #d4af37;
      --bg: #0f0f10;
      --card: #171717;
    }
    
    body {
      margin:0;
      font-family: "Poppins", Arial, sans-serif;
      background: var(--bg);
      color: #fff;
    }
    html { scroll-behavior: smooth; }

    /* NAVBAR */
    .navbar {
      position: sticky;
      top: 0;
      z-index: 200;
      display:flex; align-items:center; justify-content:space-between;
      padding:14px 28px;
      background: rgba(10,10,10,0.85);
      border-bottom: 2px solid rgba(212,175,55,0.08);
      backdrop-filter: blur(6px);
    }
    .nav-left { display:flex; align-items:center; gap:18px; }
    .nav-logo img { height:75px; display:block; }
    .nav-genres { display:flex; align-items:center; gap:12px; color:var(--gold); font-weight:600; }
    .nav-genres-label { margin-right:6px; }
    .nav-genres-links { list-style:none; display:flex; gap:10px; margin:0; padding:0; }
    .nav-genres-links a { color:#f4e4a6; text-decoration:none; padding:8px 10px; border-radius:6px; font-weight:500; }
    .nav-genres-links a:hover { background: rgba(212,175,55,0.12); color: var(--gold); }

    .nav-controls { display:flex; align-items:center; gap:12px; }
    .search-container { display:flex; align-items:center; gap:8px; background: rgba(212,175,55,0.06); padding:6px 10px; border-radius:24px; border:1px solid rgba(212,175,55,0.08); }
    .search-input { background:transparent; border:none; outline:none; color:#f4e4a6; width:220px; }
    .search-btn { background:transparent; border:none; color:var(--gold); cursor:pointer; font-size:16px; }
    .signin-btn { background: linear-gradient(135deg,#8b4513 0%,#a0522d 50%); color:#f4e4a6; border:1px solid var(--gold); padding:8px 14px; border-radius:20px; cursor:pointer; }

    /* Footer */
    #carouselExample img {
    height: 600px;   /* adjust as per your need */
    object-fit: cover; /* ensures image is cropped nicely */
  }
    footer {
      background:#111;
      padding:16px;
      text-align:center;
      color:#aaa;
      font-size:14px;
      margin-top:40px;
      border-top:1px solid rgba(212,175,55,0.1);
    }
    footer a { color:var(--gold); text-decoration:none; margin:0 8px; }
    footer a:hover { text-decoration:underline; }

    /* --- KEEPING YOUR STYLES UNCHANGED FOR CAROUSELS / RECOMMENDED / GENRES --- */
    .carousel-wrapper { position: relative; padding: 18px 0; margin: 16px 12px; background: rgba(24,24,24,0.6); border-radius: 12px; border: 1px solid rgba(212,175,55,0.08); overflow: hidden; }
    .carousel-viewport { overflow: hidden; position: relative; padding: 12px 40px; }
    .carousel-track { display:flex; gap:20px; transition: transform 520ms cubic-bezier(.2,.8,.2,1); align-items:center; }
    .carousel-item { flex: 0 0 calc(25% - 15px); }
    .poster { width:100%; height: 200px; object-fit: cover; border-radius: 12px; display:block; box-shadow: 0 8px 24px rgba(0,0,0,0.6); transition: transform .25s; }
    .poster:hover { transform: translateY(-6px) scale(1.03); box-shadow: 0 12px 36px rgba(0,0,0,0.7); }
    .carousel-btn { position:absolute; top:50%; transform: translateY(-50%); background: rgba(0,0,0,0.6); border: 1px solid rgba(212,175,55,0.12); color: #fff; width:44px; height:44px; border-radius:50%; cursor:pointer; display:flex; align-items:center; justify-content:center; z-index:10; }
    .carousel-btn.left { left:10px; }
    .carousel-btn.right { right:10px; }

    #recommended {
    margin: 18px 16px;
    padding: 14px;
    background: rgba(18,18,18,0.6);
    border-radius: 12px;
    border: 1px solid rgba(212,175,55,0.06);
}

.recommended-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 12px;
    margin-bottom: 12px;
}

.recommended-header h2 {
    color: var(--gold);
    margin: 0;
    font-size: 18px;
}

.see-all {
    color: var(--gold);
    font-weight: 600;
    text-decoration: none;
}

/* Flex version instead of grid */
.recommended-grid {
    display: flex;
    gap: 16px;              /* space between cards */
    overflow-x: auto;       /* enable horizontal scroll */
    overflow-y: hidden;     /* prevent vertical scroll */
    padding-bottom: 8px;    /* avoid scrollbar overlap */
    scroll-behavior: smooth;
    scrollbar-width: thin;  /* Firefox */
}

.recommended-grid::-webkit-scrollbar {
    height: 8px;            /* slim scrollbar */
}
.recommended-grid::-webkit-scrollbar-thumb {
    background: rgba(212,175,55,0.4);
    border-radius: 4px;
}
.recommended-grid::-webkit-scrollbar-track {
    background: transparent;
}


.rec-card {
    flex: 0 0 180px;        /* fixed width */
    max-width: 180px;
    background: var(--card);
    border-radius: 10px;
    overflow: hidden;
    text-align: center;
    box-shadow: 0 8px 24px rgba(0,0,0,0.6);
    cursor: pointer;
    transition: transform .2s ease;
}

.rec-card img {
    width: 100%;
    height: 240px;
    object-fit: cover;
    display: block;
}


.rec-card:hover {
    transform: translateY(-6px) scale(1.02);
}


    .genre-section { margin: 18px 16px; }
    .genre-section h3 { color:var(--gold); margin:6px 0 12px 0; }
    .genre-carousel { display:flex; gap:12px; overflow-x:auto; padding-bottom:8px; }
    .genre-carousel::-webkit-scrollbar{ display:none; }
    .genre-slide { flex:0 0 auto; width:150px; }
    .genre-card { background:var(--card); border-radius:10px; overflow:hidden; text-align:center; box-shadow: 0 8px 20px rgba(0,0,0,0.6); }
    .genre-card img { width:100%; height:200px; object-fit:cover; display:block; }
    .movie-title { padding:8px; font-size:14px; color:#fff; }
    /* Netflix-style Search */
.search-container {
    position: relative;
}
.search-box {
    display: flex;
    align-items: center;
    background: rgba(0,0,0,0.75);
    border: 1px solid #555;
    border-radius: 4px;
    padding: 5px 10px;
    transition: width 0.4s ease;
    width: 40px;
    overflow: hidden;
}
.search-box input {
    background: transparent;
    border: none;
    outline: none;
    color: white;
    font-size: 14px;
    width: 0;
    transition: width 0.4s ease;
}
.search-box.active {
    width: 250px;
}
.search-box.active input {
    width: 200px;
}
.search-icon {
    color: #aaa;
    cursor: pointer;
    font-size: 18px;
}
/* Autocomplete dropdown */
.autocomplete-results {
    position: absolute;
    background: #181818;
    width: 250px;
    border-radius: 4px;
    margin-top: 5px;
    display: none;
    max-height: 200px;
    overflow-y: auto;
    z-index: 999;
}
.autocomplete-results div {
    padding: 10px;
    cursor: pointer;
    border-bottom: 1px solid #333;
}
.autocomplete-results div:hover {
    background: #333;
}
.signin-select {
      padding: 10px 20px;
      border-radius: 8px;
      background: linear-gradient(45deg, #ff3d00, #ff9100);
      color: #fff;
      font-size: 16px;
      font-weight: bold;
      border: none;
      cursor: pointer;
      appearance: none; /* hide default arrow */
      outline: none;
      transition: 0.3s ease;
    }

    .signin-select:hover {
      background: linear-gradient(45deg, #ff9100, #ff3d00);
      box-shadow: 0 0 8px rgba(255, 61, 0, 0.7);
    }

    option {
      background: #222;
      color: #fff;
      padding: 10px;
    }

    
  </style>
</head>
<body>

  <!-- ✅ NAVBAR with Search Bar already -->
  <nav class="navbar">
    <div class="nav-left">
      <div class="nav-logo"><img src="images/V1.png" alt="V5 CINEMAS"></div>
      <div class="nav-genres">
        <span class="nav-genres-label">Genres:</span>
        <ul class="nav-genres-links">
          <li><a href="#horror">Horror</a></li>
          <li><a href="#comedy">Comedy</a></li>
          <li><a href="#thriller">Thriller</a></li>
          <li><a href="#suspense">Suspense</a></li>
          <li><a href="#romance">Romantic</a></li>
          <li><a href="#action">Action</a></li>
          <li><a href="#scifi">Sci-Fi</a></li>
          <li><a href="#animation">Animation</a></li>
          <li><a href="#drama">Drama</a></li>
          <li><a href="#adventure">Adventure</a></li>
        </ul>
      </div>
    </div>
    <div class="nav-controls">
     <div class="search-container">
    <div class="search-box" id="searchBox">
        <span class="search-icon" onclick="toggleSearch()">&#128269;</span>
        <input type="text" id="movieSearch" placeholder="Search movies...">
    </div>
    <div id="autocompleteResults" class="autocomplete-results"></div>

    <label for="signin"></label>
  <select id="signin" class="signin-select" onchange="goToPage(this.value)">
    <option selected disabled>Sign In</option>
    <option value="Login.jsp">Login</option>
    <option value="Register.jsp">Register</option>
  </select>
  </nav>
  <!-- Sign In Modal -->


  <!-- ✅ YOUR CAROUSEL, RECOMMENDED, GENRE SECTIONS (kept unchanged) -->
  <!-- paste of your same HTML continues here... -->
  <!-- ... (all your carousels & genre sections as you provided) ... -->
  <!-- SLIM CAROUSEL (4 visible normally) -->
  <!-- Bootstrap Carousel -->
<div id="carouselExample" class="carousel slide" data-bs-ride="carousel">
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="https://occ-0-8407-90.1.nflxso.net/dnm/api/v6/E8vDc_W8CLv7-yMQu8KMEC7Rrr8/AAAABZqNYNYjO787Lhv-39YvyHa3Fkx_abLU5PkPO_EEnKpCCzY2K4dK7_HBX8K9mUQ7E2DkcuXOQXofK0Mey6E2PK5tCkaAIUonlT3D.jpg?r=8f1" class="d-block w-100" alt="Poster 1">
    </div>
    <div class="carousel-item">
      <img src="https://www.onlykollywood.com/wp-content/uploads/2025/02/vidaamuyarchi-movie-review.jpg" class="d-block w-100" alt="Poster 2">
    </div>
    <div class="carousel-item">
      <img src="https://www.deccanchronicle.com/h-upload/2025/07/10/1936523-kantara-2.jpg" class="d-block w-100" alt="Poster 3">
    </div>
    <div class="carousel-item">
      <img src="https://static.toiimg.com/thumb/msid-121610048,imgsize-180132,width-400,resizemode-4/NP.jpg" class="d-block w-100" alt="Poster 4">
    </div>
  </div>

  <!-- Controls -->
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>

<!-- Bootstrap CSS + JS -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  

  <!-- RECOMMENDED (5 items + See All) -->
  <section id="recommended">
    <div class="recommended-header">
      <h2>Recommended for you</h2>
      <a class="see-all" href="#recommended">See All</a>
    </div>

<div class="recommended-grid" role="list">

    <div class="recommended-grid" role="list">
    <c:forEach var="m" items="${movies}">
        <div class="rec-card">
            <a href="movieDetails?id=${m.movieId}">
               <img src="${m.posterUrl}" alt="${m.title}">
                <div class="movie-title">${m.title} (${m.language})</div>
            </a>
        </div>
    </c:forEach>
</div>

</div>

 <!-- HORROR -->
<!-- HORROR -->
<section id="horror" class="genre-section">
  <h3>Horror</h3>
  <div class="genre-carousel">
    <c:forEach var="m" items="${movies}">
            <c:if test="${fn:contains(fn:toLowerCase(m.genre), 'horror')}">
                <div class="genre-slide">
                    <div class="genre-card">
                        <a href="movieDetails?id=${m.movieId}">
                            <img src="${m.posterUrl}" alt="${m.title} poster">
                            <div class="movie-title">${m.title}</div>
                        </a>
                    </div>
                </div>
            </c:if>
        </c:forEach>
  </div>
</section>

<!-- COMEDY -->
<section id="comedy" class="genre-section">
  <h3>Comedy</h3>
  <div class="genre-carousel">
    <c:forEach var="m" items="${movies}">
            <c:if test="${fn:contains(fn:toLowerCase(m.genre), 'comedy')}">
                <div class="genre-slide">
                    <div class="genre-card">
                        <a href="movieDetails?id=${m.movieId}">
                            <img src="${m.posterUrl}" alt="${m.title} poster">
                            <div class="movie-title">${m.title}</div>
                        </a>
                    </div>
                </div>
            </c:if>
        </c:forEach>
  </div>
</section>

<!-- ROMANCE -->
<section id="romance" class="genre-section">
  <h3>Romance</h3>
  <div class="genre-carousel">
    <c:forEach var="m" items="${movies}">
            <c:if test="${fn:contains(fn:toLowerCase(m.genre), 'romantic')}">
                <div class="genre-slide">
                    <div class="genre-card">
                        <a href="movieDetails?id=${m.movieId}">
                            <img src="${m.posterUrl}" alt="${m.title} poster">
                            <div class="movie-title">${m.title}</div>
                        </a>
                    </div>
                </div>
            </c:if>
        </c:forEach>
  </div>
</section>

<!-- THRILLER -->
<section id="thriller" class="genre-section">
  <h3>Thriller</h3>
  <div class="genre-carousel">
     <c:forEach var="m" items="${movies}">
            <c:if test="${fn:contains(fn:toLowerCase(m.genre), 'thriller')}">
                <div class="genre-slide">
                    <div class="genre-card">
                        <a href="movieDetails?id=${m.movieId}">
                            <img src="${m.posterUrl}" alt="${m.title} poster">
                            <div class="movie-title">${m.title}</div>
                        </a>
                    </div>
                </div>
            </c:if>
        </c:forEach>
  </div>
</section>

<!-- SUSPENSE -->
<section id="suspense" class="genre-section">
  <h3>Suspense</h3>
  <div class="genre-carousel">
     <c:forEach var="m" items="${movies}">
            <c:if test="${fn:contains(fn:toLowerCase(m.genre), 'thriller')}">
                <div class="genre-slide">
                    <div class="genre-card">
                        <a href="movieDetails?id=${m.movieId}">
                            <img src="${m.posterUrl}" alt="${m.title} poster">
                            <div class="movie-title">${m.title}</div>
                        </a>
                    </div>
                </div>
            </c:if>
        </c:forEach>
  </div>
</section>

<!-- ACTION -->
<section id="action" class="genre-section">
  <h3>Action</h3>
  <div class="genre-carousel">
     <c:forEach var="m" items="${movies}">
            <c:if test="${fn:contains(fn:toLowerCase(m.genre), 'action')}">
                <div class="genre-slide">
                    <div class="genre-card">
                        <a href="movieDetails?id=${m.movieId}">
                            <img src="${m.posterUrl}" alt="${m.title} poster">
                            <div class="movie-title">${m.title}</div>
                        </a>
                    </div>
                </div>
            </c:if>
        </c:forEach>
  </div>
</section>

<!-- SCI-FI -->
<section id="scifi" class="genre-section">
  <h3>Sci-Fi</h3>
  <div class="genre-carousel">
     <c:forEach var="m" items="${movies}">
            <c:if test="${fn:contains(fn:toLowerCase(m.genre), 'sci')}">
                <div class="genre-slide">
                    <div class="genre-card">
                        <a href="movieDetails?id=${m.movieId}">
                            <img src="${m.posterUrl}" alt="${m.title} poster">
                            <div class="movie-title">${m.title}</div>
                        </a>
                    </div>
                </div>
            </c:if>
        </c:forEach>
  </div>
</section>

<!-- ANIMATION -->
<section id="animation" class="genre-section">
  <h3>Animation</h3>
  <div class="genre-carousel">
      <c:forEach var="m" items="${movies}">
            <c:if test="${fn:contains(fn:toLowerCase(m.genre), 'animation')}">
                <div class="genre-slide">
                    <div class="genre-card">
                        <a href="movieDetails?id=${m.movieId}">
                            <img src="${m.posterUrl}" alt="${m.title} poster">
                            <div class="movie-title">${m.title}</div>
                        </a>
                    </div>
                </div>
            </c:if>
        </c:forEach>
  </div>
</section>

<!-- DRAMA -->
<section id="drama" class="genre-section">
  <h3>Drama</h3>
  <div class="genre-carousel">
    <c:forEach var="m" items="${movies}">
            <c:if test="${fn:contains(fn:toLowerCase(m.genre), 'drama')}">
                <div class="genre-slide">
                    <div class="genre-card">
                        <a href="movieDetails?id=${m.movieId}">
                            <img src="${m.posterUrl}" alt="${m.title} poster">
                            <div class="movie-title">${m.title}</div>
                        </a>
                    </div>
                </div>
            </c:if>
        </c:forEach>
  </div>
</section>

<!-- ADVENTURE -->
<section id="adventure" class="genre-section">
  <h3>Adventure</h3>
  <div class="genre-carousel">
     <c:forEach var="m" items="${movies}">
            <c:if test="${fn:contains(fn:toLowerCase(m.genre), 'adventure')}">
                <div class="genre-slide">
                    <div class="genre-card">
                        <a href="movieDetails?id=${m.movieId}">
                            <img src="${m.posterUrl}" alt="${m.title} poster">
                            <div class="movie-title">${m.title}</div>
                        </a>
                    </div>
                </div>
            </c:if>
        </c:forEach>
  </div>
</section>

  <!-- ✅ FOOTER -->
  <footer>
    <p>&copy; 2025 V5 CINEMAS. All rights reserved.</p>
    <p>
      <a href="#">Privacy Policy</a> |
      <a href="#">Terms of Service</a> |
      <a href="#">Contact</a>
    </p>
  </footer>

  <!-- ✅ Search Bar JS -->
  <script>
    document.getElementById("movieSearch").addEventListener("keyup", function() {
      let filter = this.value.toLowerCase();
      document.querySelectorAll(".rec-card, .genre-slide").forEach(card => {
        let title = card.innerText.toLowerCase();
        card.style.display = title.includes(filter) ? "" : "none";
      });
    });
  </script>

  <!-- ✅ Carousel JS (unchanged from your version) -->
  <script>
  (function () {
      const viewport = document.getElementById('top-carousel');
      const track = document.getElementById('carouselTrack');
      const items = Array.from(track.querySelectorAll('.carousel-item'));
      const leftBtn = document.getElementById('carouselLeftBtn');
      const rightBtn = document.getElementById('carouselRightBtn');

      let visible = calcVisible();     // number of visible items (changes on resize)
      let index = 0;                   // index of leftmost visible item
      let autoTimer = null;

      function calcVisible() {
        const w = viewport.clientWidth;
        if (w < 420) return 1;
        if (w < 700) return 2;
        if (w < 1000) return 3;
        return 4;
      }

      function itemSizePx() {
        // width + gap (gap is 20px)
        if (!items[0]) return 0;
        const style = getComputedStyle(items[0]);
        const marginRight = parseFloat(style.marginRight || '20');
        return items[0].getBoundingClientRect().width + marginRight;
      }

      function maxIndex() {
        return Math.max(0, items.length - visible);
      }

      function update() {
        const shift = index * itemSizePx();
        track.style.transform = translateX(-${shift}px);
      }

      function clampIndex() {
        if (index < 0) index = 0;
        if (index > maxIndex()) index = maxIndex();
      }

      function move(delta) {
        index += delta;
        // wrap-around behavior (optional): if you prefer loop uncomment below:
        // if (index > maxIndex()) index = 0;
        // if (index < 0) index = maxIndex();
        clampIndex();
        update();
        restartAuto();
      }

      function restartAuto() {
        if (autoTimer) clearInterval(autoTimer);
        autoTimer = setInterval(()=> {
          index = index + 1;
          if (index > maxIndex()) index = 0;
          update();
        }, 3500);
      }

      // wire up
      leftBtn.addEventListener('click', ()=> move(-1));
      rightBtn.addEventListener('click', ()=> move(1));

      // recalc on resize
      window.addEventListener('resize', ()=> {
        visible = calcVisible();
        // ensure index within bounds
        if (index > maxIndex()) index = maxIndex();
        update();
      });

      // initial set
      // ensure items have layout before calc: run after next tick
      setTimeout(()=> {
        visible = calcVisible();
        update();
        restartAuto();
      }, 50);

    })();
  </script>
  <script>
    (function () {
      const viewport = document.getElementById('top-carousel');
      const track = document.getElementById('carouselTrack');
      const items = Array.from(track.querySelectorAll('.carousel-item'));
      const leftBtn = document.getElementById('carouselLeftBtn');
      const rightBtn = document.getElementById('carouselRightBtn');
      let visible = 4, index = 0;

      function update() {
        let itemWidth = items[0].getBoundingClientRect().width + 20;
        track.style.transform = `translateX(${-index * itemWidth}px)`;
      }
      function move(delta) {
        index += delta;
        if (index < 0) index = 0;
        if (index > items.length - visible) index = items.length - visible;
        update();
      }
      leftBtn.addEventListener("click", ()=>move(-1));
      rightBtn.addEventListener("click", ()=>move(1));
      update();
    })();
  </script>
  <script>
    const searchBox = document.getElementById("searchBox");
    const searchInput = document.getElementById("movieSearch");
    const resultsBox = document.getElementById("autocompleteResults");

    function toggleSearch() {
        searchBox.classList.toggle("active");
        if (searchBox.classList.contains("active")) {
            searchInput.focus();
        } else {
            resultsBox.style.display = "none";
            searchInput.value = "";
        }
    }

    

    searchInput.addEventListener("input", () => {
        const query = searchInput.value.toLowerCase();
        resultsBox.innerHTML = "";
        if (query.length === 0) {
            resultsBox.style.display = "none";
            return;
        }
        const filtered = movies.filter(m => m.toLowerCase().includes(query));
        if (filtered.length > 0) {
            resultsBox.style.display = "block";
            filtered.forEach(m => {
                const div = document.createElement("div");
                div.textContent = m;
                div.onclick = () => {
                    searchInput.value = m;
                    resultsBox.style.display = "none";
                };
                resultsBox.appendChild(div);
            });
        } else {
            resultsBox.style.display = "none";
        }
    });
</script>
<script>
  function goToPage(page) {
    if (page && page !== "Sign In") {
      window.location.href = page;  // Redirect to the JSP page
    }
  }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

  
</body>
</html>
