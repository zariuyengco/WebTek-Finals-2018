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
        <a class="py-2 d-none d-md-inline-block" href="reservation.jsp">Log In</a>
      </div>
    </nav>
        
        
        <div class="grid-container">
        <div>Toyota Sienna<div><img class="im1" src="img/sienna.png"></div><a href="reservation.jsp"><button type="button">RESERVE</button></a></div>
        <div>Toyota 4Runner<div><img class="im2" src="img/4runner.png"></div><a href="reservation.jsp"><button type="button">RESERVE</button></a></div>
        <div>Toyota Sequoia<div><img class="im3" src="img/sequoia.png"></div><a href="reservation.jsp"><button type="button">RESERVE</button></a></div>  
        <div>Toyota Highlander Hybrid<div><img class="im4" src="img/highlanderhybrid.png"></div><a href="reservation.jsp"><button type="button">RESERVE</button></a></div>
        <div>Toyota Corolla Fielder<div><img class="im8" src="img/corollafielder.png"></div><a href="reservation.jsp"><button type="button">RESERVE</button></a></div>
        <div>Toyota Vios<div><img class="im8" src="img/vios.png"></div><a href="reservation.jsp"><button type="button">RESERVE</button></a></div>  
        <div>Toyota Camry<div><img class="im8" src="img/camry.png"></div><a href="reservation.jsp"><button type="button">RESERVE</button></a></div>
        <div>Toyota Hiace<div><img class="iml" src="img/hiace.png"></div><a href="reservation.jsp"><button type="button">RESERVE</button></a></div>
    <!--<div>1</div>
    <div>2</div>
    <div>3</div>  
    <div>4</div>
    <div>5</div>
    <div>6</div>  
    <div>7</div>
    <div>8</div>-->
      </div>
        
    </body>
</html>
