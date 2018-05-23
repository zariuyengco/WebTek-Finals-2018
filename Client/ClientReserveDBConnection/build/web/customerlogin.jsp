<%-- 
    Document   : login
    Created on : 05 21, 18, 6:54:18 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<head>

		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<meta name="description" content="">
		<meta name="author" content="">

		<title>CarGo</title>

		<!-- Bootstrap core CSS -->
		<link href="landing page/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

		<!-- Custom fonts for this template -->
		<link href="https://fonts.googleapis.com/css?family=Raleway:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css?family=Lora:400,400i,700,700i" rel="stylesheet">

		<!-- Custom styles for this template -->
		<link href="landing page/css/stylereserve.css" rel="stylesheet">
                
                <style>

* {
    margin: 0;
    padding: 0;
    outline: none;
 
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
 
body {
    color: #444;
    -webkit-font-smoothing: antialiased;
    font-family: "Open Sans", Arial, Helvetica, Geneva, sans-serif;
    font-size: 16px;
    font-weight: 400;
    height: auto !important;
    height: 100%;
    line-height: 1.6em;
    min-height: 100%;
}
 
h2 {
    color: rgb(34,34,34);
    font-size: 2.2em;
    font-weight: 200;
    margin: 0 0 24px 0;
}
 
/*BUTTON DESIGN*/
[class*='btn-'] {
    border: none;
    border-bottom: 2px solid rgba(0,0,0,.15);
    border-top: 1px solid rgba(255,255,255,.15);
    border-radius: 3px;
    color: #fff;
    display: inline-block;
    font: -webkit-small-control;
    font-size: .7em;
    letter-spacing: 1px;
    line-height: 140%;
    padding: 10px 20px;
    text-decoration: none;
    text-shadow: 0 1px 1px rgba(0, 0, 0, 0.25);
    text-transform: uppercase;
 
    -webkit-transition: all 0.1s linear;
    -moz-transition: all 0.1s linear;
    -o-transition: all 0.1s linear;
      transition: all 0.1s linear;
}
 
    .btn-minimal {
        background-color: rgb(255,255,255);
        border-radius: 0;
        border: 1px solid rgb( 186, 186, 186 );
        color: rgb( 186, 186, 186 );
        text-shadow: 0 1px 1px rgba(255, 255, 255, 1);
    }
 
        .btn-minimal:hover {
            background-color: #4195fc;
            border: 1px solid rgba(0,0,0,.1);
            color: rgb(255,255,255);
            cursor: pointer;
            text-shadow: 0 1px 1px rgba(0, 0, 0, 0.25);
        }
 
        .btn-minimal:active {
            box-shadow: 0 1px 1px rgba(0,0,0,0.15) inset;
            text-shadow: 0 -1px 1px rgba(0, 0, 0, 0.25);
        }
 
/*SECTION CONTAINER*/
section#loginBox {
    background-color: rgb(255,255,255);
    border: 1px solid rgba(0,0,0,.15);
    border-radius: 4px;
    box-shadow: 0 1px 0 rgba(255,255,255,0.2) inset, 0 0 4px rgba(0,0,0,0.2);
    margin: 40px auto; /*aligns center*/
    padding: 24px;
    width: 500px;
}
 
/*FORM*/
form.minimal label {
    display: block;
    margin: 6px 0;
}
 
    form.minimal input[type="text"],
    form.minimal input[type="email"],
    form.minimal input[type="number"],
    form.minimal input[type="search"],
    form.minimal input[type="password"],
    form.minimal textarea {
        background-color: rgb(255,255,255);
        border: 1px solid rgb( 186, 186, 186 );
        border-radius: 2px;
        -webkit-box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.08);
        -moz-box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.08);
          box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.08);
        display: block;
        font-size: 14px;
        margin: 6px 0 12px 0;
        padding: 8px;
        text-shadow: 0 1px 1px rgba(255, 255, 255, 1);
        width: 90%;
 
        -webkit-transition: all 0.1s linear;
        -moz-transition: all 0.1s linear;
        -o-transition: all 0.1s linear;
          transition: all 0.1s linear;
    }
 
    form.minimal input[type="text"]:focus,
    form.minimal input[type="email"]:focus,
    form.minimal input[type="number"]:focus,
    form.minimal input[type="search"]:focus,
    form.minimal input[type="password"]:focus,
    form.minimal textarea:focus,
    form.minimal select:focus {
        border-color: #4195fc;
        -webkit-box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.1), 0 0 8px #4195fc;
        -moz-box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.1), 0 0 8px #4195fc;
        box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.1), 0 0 8px #4195fc;
        color: rgb(0,0,0);
    }
 
        form.minimal input[type="text"]:invalid:focus,
        form.minimal input[type="email"]:invalid:focus,
        form.minimal input[type="number"]:invalid:focus,
        form.minimal input[type="search"]:invalid:focus,
        form.minimal input[type="password"]:invalid:focus,
        form.minimal textarea:invalid:focus,
        form.minimal select:invalid:focus {
            border-color: rgb(248,66,66);
            -webkit-box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.1), 0 0 8px rgb(248,66,66);
            -moz-box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.1), 0 0 8px rgb(248,66,66);
              box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.1), 0 0 8px rgb(248,66,66);
        }

     </style>

	</head>

	<body>

		<h1 class="site-heading text-center text-gray d-none d-lg-block">
			<span class="site-heading-upper text-gray mb-3">CarGo</span>
			<span class="site-heading-lower">"Rent a CAR now!"</span>
		</h1>

		<!-- Navigation -->
		<nav class="navbar navbar-expand-lg navbar-dark py-lg-4" id="mainNav">
			<div class="container">
				<a class="navbar-brand text-uppercase text-expanded font-weight-bold d-lg-none" href="#">Start Bootstrap</a>
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				
				<div class="collapse navbar-collapse" id="navbarResponsive">
					<ul class="navbar-nav mx-auto">
					
						<li class="nav-item px-lg-4">
							<a class="nav-link text-uppercase text-expanded" href="index.jsp">Home
								<span class="sr-only">(current)</span>
							</a>
						</li>
						
						<li class="nav-item px-lg-4">
							<a class="nav-link text-uppercase text-expanded" href="landing page/about.jsp">About</a>
						</li>
						
						<li class="nav-item px-lg-4">
							<a class="nav-link text-uppercase text-expanded" href="landing page/contactus.html">Contact Us</a>
						</li>
						
						<li class="nav-item active px-lg-4">
							<a class="nav-link text-uppercase text-expanded" href="customerhome.jsp">Customer</a>
						</li>
						
					</ul>
				</div>
			</div>
		</nav>
		
		<section class="page-section cta">
			<div class="container">
				<div class="row">
					<div class="col-xl-9 mx-auto">
						<div class="cta-inner text-center rounded">
							<h2 class="section-heading mb-5">
								<span class="section-heading-upper">Login</span>
							</h2>
								
							<section id="loginBox">
							
<form method="post" class="minimal">
        <label for="username">
            Username:
            <input type="text" name="username" id="username" placeholder="Username" required="required" />
        </label>
        <label for="password">
            Password:
            <input type="password" name="password" id="password" placeholder="Password" required="required" />
        </label>
    
    <input class="btn-minimal" type="submit" value="login">

    </form>
</section>
						</div>
					</div>
				</div>
			</div>
		</section>

		<footer class="footer text-faded text-center py-5">
			<div class="container">
				<p class="m-0 small">Copyright &copy; CarGo 2018</p>
			</div>
			
			<div class="list-inline">
				<a class="icon-link"><img class="socialmed" src="landing page/img/icons/fbicon.png" alt="icon"></a>
				<a class="icon-link"><img class="socialmed" src="landing page/img/icons/twittericon.png" alt="icon"></a>
				<a class="icon-link"><img class="socialmed" src="landing page/img/icons/igicon.png" alt="icon"></a>
			</div>
		</footer>

		<!-- Bootstrap core JavaScript -->
		<script src="vendor/jquery/jquery.min.js"></script>
		<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>


	</body>

</html>