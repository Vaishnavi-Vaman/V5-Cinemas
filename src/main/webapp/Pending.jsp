<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <title>V5 CINEMAS - Home</title>
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <style>
    /* ---------- Layout & theme ---------- */
    :root{
      --gold: #d4af37;
      --bg: #0f0f10;
      --card: #171717;
    }
    html { scroll-behavior: smooth; }
    body {
      margin:0;
      font-family: "Poppins", Arial, sans-serif;
      background: var(--bg);
      color: #fff;
    }

    /* ---------- NAVBAR (restored) ---------- */
    .navbar {
      position: sticky;
      top: 0;
      z-index: 200;
      display:flex;
      align-items:center;
      justify-content:space-between;
      gap:16px;
      padding:14px 28px;
      background: rgba(10,10,10,0.85);
      border-bottom: 2px solid rgba(212,175,55,0.08);
      backdrop-filter: blur(6px);
    }
    .nav-left { display:flex; align-items:center; gap:18px; }
    .nav-logo img { height:46px; display:block; }
    .nav-genres { display:flex; align-items:center; gap:12px; color:var(--gold); font-weight:600; }
    .nav-genres-label { color:var(--gold); font-weight:700; margin-right:6px; }
    .nav-genres-links { list-style:none; display:flex; gap:10px; margin:0; padding:0; align-items:center; }
    .nav-genres-links a { color:#f4e4a6; text-decoration:none; padding:8px 10px; border-radius:6px; font-weight:500; }
    .nav-genres-links a:hover { background: rgba(212,175,55,0.12); color: var(--gold); transform: translateY(-2px); }

    .nav-controls { display:flex; align-items:center; gap:12px; }
    .search-container { display:flex; align-items:center; gap:8px; background: rgba(212,175,55,0.06); padding:6px 10px; border-radius:24px; border:1px solid rgba(212,175,55,0.08); }
    .search-input { background:transparent; border:none; outline:none; color:#f4e4a6; width:220px; }
    .search-btn { background:transparent; border:none; color:var(--gold); cursor:pointer; font-size:16px; }
    .signin-btn { background: linear-gradient(135deg,#8b4513 0%,#a0522d 50%); color:#f4e4a6; border:1px solid var(--gold); padding:8px 14px; border-radius:20px; cursor:pointer; }

    /* ---------- Slim carousel (4 at a time) ---------- */
    .carousel-wrapper {
      position: relative;
      padding: 18px 0;
      margin: 16px 12px;
      background: rgba(24,24,24,0.6);
      border-radius: 12px;
      border: 1px solid rgba(212,175,55,0.08);
      overflow: hidden;
    }
    .carousel-viewport {
      overflow: hidden;
      position: relative;
      padding: 12px 40px; /* space for arrows */
    }
    .carousel-track {
      display:flex;
      gap:20px;
      transition: transform 520ms cubic-bezier(.2,.8,.2,1);
      align-items:center;
      will-change: transform;
    }
    .carousel-item {
      flex: 0 0 calc(25% - 15px); /* four items visible (desktop) */
      box-sizing: border-box;
    }
    .poster {
      width:100%;
      height: 200px;
      object-fit: cover;
      border-radius: 12px;
      display:block;
      background:#222;
      box-shadow: 0 8px 24px rgba(0,0,0,0.6);
      transition: transform .25s ease, box-shadow .25s ease;
    }
    .poster:hover { transform: translateY(-6px) scale(1.03); box-shadow: 0 12px 36px rgba(0,0,0,0.7); }
    .carousel-btn {
      position:absolute;
      top:50%;
      transform: translateY(-50%);
      background: rgba(0,0,0,0.6);
      border: 1px solid rgba(212,175,55,0.12);
      color: #fff;
      width:44px;
      height:44px;
      border-radius:50%;
      cursor:pointer;
      display:flex;
      align-items:center;
      justify-content:center;
      z-index:10;
    }
    .carousel-btn.left { left:10px; }
    .carousel-btn.right { right:10px; }

    /* small screens - make fewer visible */
    @media (max-width:1000px) {
      .carousel-item { flex: 0 0 calc(33.333% - 13px); } /* 3 visible */
      .poster { height: 180px; }
    }
    @media (max-width:700px) {
      .carousel-item { flex: 0 0 calc(50% - 10px); } /* 2 visible */
      .poster { height: 160px; }
      .search-input { width:120px; }
    }
    @media (max-width:420px) {
      .carousel-item { flex: 0 0 calc(100% - 10px); } /* 1 visible */
      .poster { height: 180px; }
    }

    /* ---------- Recommended (5 items) ---------- */
    #recommended {
      margin: 18px 16px;
      padding: 14px;
      background: linear-gradient(180deg, rgba(18,18,18,0.6), rgba(14,14,14,0.6));
      border-radius: 12px;
      border: 1px solid rgba(212,175,55,0.06);
    }
    .recommended-header { display:flex; align-items:center; justify-content:space-between; gap:12px; margin-bottom:12px; }
    .recommended-header h2 { color:var(--gold); margin:0; font-size:18px; }
    .see-all { color:var(--gold); font-weight:600; text-decoration:none; }
    .recommended-grid { display:grid; grid-template-columns: repeat(5, 1fr); gap:12px; }
    .rec-card { background:var(--card); border-radius:10px; overflow:hidden; text-align:center; box-shadow:0 8px 24px rgba(0,0,0,0.6); cursor:pointer; transition:transform .2s ease; }
    .rec-card:hover { transform: translateY(-6px) scale(1.02); }
    .rec-card img { width:100%; height:180px; object-fit:cover; display:block; }

    @media (max-width:1100px) { .recommended-grid { grid-template-columns: repeat(4,1fr); } }
    @media (max-width:900px) { .recommended-grid { grid-template-columns: repeat(3,1fr); } }
    @media (max-width:600px) { .recommended-grid { grid-template-columns: repeat(2,1fr); } }

    /* ---------- Genre sections (restored) ---------- */
    .genre-section { margin: 18px 16px; }
    .genre-section h3 { color:var(--gold); margin:6px 0 12px 0; }
    .genre-carousel { display:flex; gap:12px; overflow-x:auto; padding-bottom:8px; }
    .genre-carousel::-webkit-scrollbar{ display:none; }
    .genre-slide { flex:0 0 auto; width:150px; }
    .genre-card { background:var(--card); border-radius:10px; overflow:hidden; text-align:center; box-shadow: 0 8px 20px rgba(0,0,0,0.6); }
    .genre-card img { width:100%; height:200px; object-fit:cover; display:block; }
    .movie-title { padding:8px; font-size:14px; color:#fff; }

    /* ensure sections offset from sticky nav */
    section { scroll-margin-top: 86px; }

  </style>
</head>
<body>

  <!-- NAVBAR (restored style) -->
  <nav class="navbar" role="navigation" aria-label="Main navigation">
    <div class="nav-left">
      <div class="nav-logo">
        <!-- Replace logo path if you have one -->
        <img src="images/v1.png" alt="V5 CINEMAS">
      </div>

      <div class="nav-genres">
        <span class="nav-genres-label">Genres:</span>
        <ul class="nav-genres-links">
          <li><a href="#horror">Horror</a></li>
          <li><a href="#comedy">Comedy</a></li>
          <li><a href="#thriller">Thriller</a></li>
          <li><a href="#suspense">Suspense</a></li>
          <li><a href="#romance">Romance</a></li>
          <li><a href="#action">Action</a></li>
          <li><a href="#scifi">Sci-Fi</a></li>
          <li><a href="#animation">Animation</a></li>
          <li><a href="#drama">Drama</a></li>
          <li><a href="#adventure">Adventure</a></li>
        </ul>
      </div>
    </div>

    <div class="nav-controls">
      <div class="search-container" role="search">
        <input class="search-input" type="text" placeholder="Search movies..." aria-label="Search movies">
        <button class="search-btn" aria-label="Search">🔍</button>
      </div>
      <button class="signin-btn">Sign In</button>
    </div>
  </nav>

  <!-- SLIM CAROUSEL (4 visible normally) -->
  <div class="carousel-wrapper" aria-label="Featured movies">
    <div class="carousel-btn left" aria-hidden="false" id="carouselLeftBtn">&#8592;</div>
    <div class="carousel-viewport" id="top-carousel">
      <div class="carousel-track" id="carouselTrack">
        <!-- Use actual poster URLs or replace with your own assets -->
        <div class="carousel-item"><img class="poster" src="https://m.media-amazon.com/images/I/51s+Q2QpKjL._AC_SY679_.jpg" alt="Inception"></div>
        <div class="carousel-item"><img class="poster" src="https://m.media-amazon.com/images/I/91kFYg4fX3L._AC_SY679_.jpg" alt="Interstellar"></div>
        <div class="carousel-item"><img class="poster" src="https://m.media-amazon.com/images/I/51EbJjlLQmL._AC_SY679_.jpg" alt="The Dark Knight"></div>
        <div class="carousel-item"><img class="poster" src="https://m.media-amazon.com/images/I/81ExhpBEbHL._AC_SY679_.jpg" alt="Avengers"></div>
        <div class="carousel-item"><img class="poster" src="https://m.media-amazon.com/images/I/91oD7GvF1-L._AC_SY679_.jpg" alt="Spider-Man"></div>
        <div class="carousel-item"><img class="poster" src="https://m.media-amazon.com/images/I/81p+xe8cbnL._AC_SY679_.jpg" alt="Inception 2"></div>
        <div class="carousel-item"><img class="poster" src="https://m.media-amazon.com/images/I/81ExhpBEbHL._AC_SY679_.jpg" alt="Dune"></div>
        <div class="carousel-item"><img class="poster" src="https://m.media-amazon.com/images/I/81ExhpBEbHL._AC_SY679_.jpg" alt="Top Gun"></div>
      </div>
    </div>
    <div class="carousel-btn right" id="carouselRightBtn">&#8594;</div>
  </div>

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
      <c:if test="${fn:toLowerCase(m.genre) eq 'horror'}">
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
      <c:if test="${fn:toLowerCase(m.genre) eq 'comedy'}">
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
      <c:if test="${fn:toLowerCase(m.genre) eq 'romance'}">
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
      <c:if test="${fn:toLowerCase(m.genre) eq 'thriller'}">
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
      <c:if test="${fn:toLowerCase(m.genre) eq 'suspense'}">
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
      <c:if test="${fn:toLowerCase(m.genre) eq 'action'}">
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
      <c:if test="${fn:toLowerCase(m.genre) eq 'sci-fi' or fn:toLowerCase(m.genre) eq 'scifi'}">
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
      <c:if test="${fn:toLowerCase(m.genre) eq 'animation'}">
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
      <c:if test="${fn:toLowerCase(m.genre) eq 'drama'}">
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
      <c:if test="${fn:toLowerCase(m.genre) eq 'adventure'}">
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

  <!-- ---------- Carousel JS (pixel-perfect) ---------- -->
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

</body>
</html>