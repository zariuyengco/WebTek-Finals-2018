<%-- 
    Document   : customerhome
    Created on : May 21, 2018, 10:42:11 AM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CarGo 2018</title>
        
        <link href="style/bootstrap.min.css" rel="stylesheet">
        <link href="style/product.css" rel="stylesheet">
    </head>
        <style>
.grid-container {
  display: grid;
  grid-template-columns: auto auto auto auto;
  grid-gap: 10px;
  background-color: black;
  padding: 10px;
}
.grid-container > div {
  background-color: rgba(255, 255, 255, 0.8);
  text-align: center;
  padding: 50px 0;
  font-size: 30px;
}

.iml{height:300px;}

.im1, .im2, .im3, .im4{height:150px;}

.zoompic {
    padding: 100px;
    transition: transform .2s;
    width: 200px;
    height: 200px;
    margin: 0 auto;
}

.zoompic:hover {
    -ms-transform: scale(1.5); 
    -webkit-transform: scale(1.5); 
    transform: scale(1.5); 
}
</style>
    </head>
    <body>
        <nav class="site-header sticky-top py-1">
      <div class="container d-flex flex-column flex-md-row justify-content-between">
        <a class="navbar-brand" href="/">CarGo</a>
       
        <a class="py-2 d-none d-md-inline-block" href="index.jsp">Home</a>
        <a class="py-2 d-none d-md-inline-block" href="registration.jsp">Register</a>
        <a class="py-2 d-none d-md-inline-block" href="Login_v16/index.html">Log In</a>
      </div>
    </nav>
        
        
        <div class="grid-container">
            <div>Toyota Sienna<br><p>4 Door				7-seater<br>
									 A/C				Manual<br>
									 1 Large Bag		1 Small Bag
								</p><div><img class="im1" src="img/sienna.png"></div><a href="reservation.jsp"></a></div>
        <div>Toyota 4Runner<div><p>4 Door				7-seater<br>
								   A/C					Manual<br>
								   1 Large Bag			2 Small Bags
								</p><img class="im2" src="img/4runner.png"></div><a href="reservation.jsp"></a></div>
        <div>Toyota Sequoia<div><p>4 Door				8-seater<br>
								   A/C					Manual<br>
								   1 Large Bag			1 Small Bag
								</p><img class="im3" src="img/sequoia.png"></div><a href="reservation.jsp"></a></div>  
        <div>Toyota Highlander Hybrid<div><p>4 Door				7-seater<br>
											 A/C				Manual<br>
											 1 Large Bag		1 Small Bag
								</p><img class="im4" src="img/highlanderhybrid.png"></div><a href="reservation.jsp"></a></div>
        <div>Toyota Corolla Fielder<div><p>4 Door				5-seater<br>
										   A/C				Manual<br>
										   2 Large Bags		3 Small Bags
								</p><img class="im8" src="img/corollafielder.png"></div><a href="reservation.jsp"></a></div>
        <div>Toyota Vios<div><p>4 Door				5-seater<br>
								A/C					Manual<br>
								1 Large Bag			2 Small Bags
								</p><img class="im8" src="img/vios.png"></div><a href="reservation.jsp"></a></div>  
        <div>Toyota Camry<div><p>4 Door				5-seater<br>
								 A/C				Manual<br>
								 1 Large Bag		2 Small Bags
								</p><img class="im8" src="img/camry.png"></div><a href="reservation.jsp"></a></div>
        <div>Toyota Hiace<div><p>4 Door				15-seater<br>
								 A/C				Manual<br>
								 3 Large Bags		2 Small Bags
								</p><img class="iml" src="img/hiace.png"></div><a href="reservation.jsp"></a></div>
      </div>
        
    </body>
</html>
