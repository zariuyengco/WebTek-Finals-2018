<%-- 
    Document   : registreation
    Created on : May 18, 2018, 8:32:58 AM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html class="gr__localhost">
    <head>
        <title>carGo</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="css.css">
        <link type="text/css" rel="stylesheet" href="css/style.css">    
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Oswald">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open Sans">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="css/bootstrap-theme.min.css" rel="stylesheet" type="text/css" />
        <link href="css/style.css" rel="stylesheet" type="text/css" />
        
        <script src="//code.jquery.com/jquery-1.10.2.js"></script>
        <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script> 
        <script src="jquery.min.js"></script>    
        
        <style>
            h1,h2,h3,h4,h5,h6 {
                font-family: "Oswald";
            }
            
            body {
               font-family: "Open Sans";            }  
            
            .select-boxes {
                text-align: center;
            }
            
            select {
                background-color: #F5F5F5;
                border: 1px double #15a6c7;
                color: #1d93d1;
                font-family: Georgia;
                font-weight: bold;
                font-size: 14px;
                height: 39px;
                padding: 7px 8px;
                width: 250px;
                outline: none;
                margin: 10px 0 10px 0;
            }
            
            select option {
                font-family: Georgia;
                font-size: 14px;
            }

            /* Basic reset */
            
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;

                /* Better text styling */
                font: bold 14px Arial, sans-serif;
            }

            /* Finally adding some IE9 fallbacks for gradients to finish things up */

            /* A nice BG gradient */
            
            html {
                height: 100%;
                background: white;
                background: radial-gradient(circle, #fff 20%, #ccc);
                background-size: cover;
            }

            /* Using box shadows to create 3D effects */
            
            #calculator {
                width: 325px;
                height: auto;
                margin: 0px auto;
                padding: 20px 20px 9px;
                background: #9dd2ea;
                background: linear-gradient(rgba(171, 183, 241, 0.87), #8bceec);
                border-radius: 20px;
                box-shadow: 0px 4px rgba(0, 104, 136, 0.53), 0px 10px 15px rgba(0, 0, 0, 0.2);
            }

            /* Top portion */
            .top span.clear {
                float: left;
            }

            /* Inset shadow on the screen to create indent */
            .top .screen {
                height: 40px;
                width: 212px;

                float: right;

                padding: 0 10px;

                background: rgba(0, 0, 0, 0.2);
                border-radius: 3px;
                box-shadow: inset 0px 4px rgba(0, 0, 0, 0.2);

                /* Typography */
                font-size: 17px;
                line-height: 40px;
                color: white;
                text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2);
                text-align: right;
                letter-spacing: 1px;
            }

            /* Clear floats */
            .keys, .top {
                overflow: hidden;
            }

            /* Applying same to the keys */
            .keys span, .top span.clear {
                float: left;
                position: relative;
                top: 0;
                cursor: pointer;
                width: 66px;
                height: 36px;
                background: white;
                border-radius: 3px;
                box-shadow: 0px 4px rgba(0, 0, 0, 0.2);
                margin: 0 7px 11px 0;
                color: #888;
                line-height: 36px;
                text-align: center;
                /* prevent selection of text inside keys */
                user-select: none;
                /* Smoothing out hover and active states using css3 transitions */
                transition: all 0.2s ease;
            }

            /* Remove right margins from operator keys */
            /* style different type of keys (operators/evaluate/clear) differently */
            
            .keys span.operator {
                background: #FFF0F5;
                margin-right: 0;
            }

            .keys span.eval {
                background: #f1ff92;
                box-shadow: 0px 4px #9da853;
                color: #888e5f;
            }

            .top span.clear {
                background: #ff9fa8;
                box-shadow: 0px 4px #ff7c87;
                color: white;
            }

            /* Some hover effects */
            .keys span:hover {
                background: #1d91d0;
                box-shadow: 0px 4px #0676b3;
                color: #f1f1f1;
            }

            .keys span.eval:hover {
                background: #abb850;
                box-shadow: 0px 4px #717a33;
                color: #ffffff;
            }

            .top span.clear:hover {
                background: #f68991;
                box-shadow: 0px 4px #d3545d;
                color: white;
            }

            /* Simulating "pressed" effect on active state of the keys by removing the box-shadow and moving the keys down a bit */
            .keys span:active {
                box-shadow: 0px 0px #6b54d3;
                top: 4px;
            }

            .keys span.eval:active {
                box-shadow: 0px 0px #717a33;
                top: 4px;
            }

            .top span.clear:active {
                top: 4px;
                box-shadow: 0px 0px #d3545d;
            }

        </style>

    </head>
    
    <body class="w3-light-grey" data-gr-c-s-loaded="true">

        <!-- w3-content defines a container for fixed size centered content, 
        and is wrapped around the whole page content, except for the footer in this example -->
     
        <div class="w3-content" style="max-width:1600px">

        <!-- Header -->
        <header class="w3-container w3-center w3-padding-48 w3-white">
            <center><h1><a href="#home"><span>carGo</span></span></a></h1>
            <h6>Registration Page <span class="w3-tag">Register Me!</span></h6> <br>
            <a class="py-2 d-none d-md-inline-block" href="#home">Home</a>
            <a class="py-2 d-none d-md-inline-block" href="#about">About</a>
            <a class="py-2 d-none d-md-inline-block" href="#contact">Contact Us</a></center>
        </header>

        <!-- Image header -->

        <!-- Grid -->
        <div class="w3-row w3-padding w3-border">
            <!-- Blog entries -->
            <div class="w3-col l12 s12">
                <!-- Blog entry -->
                <div class="w3-container w3-white w3-margin w3-padding-large">
                    <h2 style="text-align: center" ;=""> Registration Form </h2><br>
                    <div class="select-boxes">
                        <div class="container">
                            <div class="col-lg-9"><br><br>

                                <form class="form-horizontal" action="reservation.jsp " method="post"  id="reg_form">
                                    <fieldset>

                                        <!-- Form Name -->
                                        <legend> Personal Information </legend>

                                        <!-- Text input-->

                                        <div class="form-group">
                                            <label class="col-md-4 control-label">First Name</label>
                                            <div class="col-md-6  inputGroupContainer">
                                                <div class="input-group"><span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                                    <input  name="first_name" placeholder="First Name" class="form-control"  type="text">
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Text input-->

                                        <div class="form-group">
                                            <label class="col-md-4 control-label" >Last Name</label>
                                            <div class="col-md-6  inputGroupContainer">
                                                <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                                    <input name="last_name" placeholder="Last Name" class="form-control"  type="text">
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Text input-->
                                        
                                        <!-- Text input-->

                                        <div class="form-group">
                                            <label class="col-md-4 control-label" > License Number</label>
                                            <div class="col-md-6  inputGroupContainer">
                                                <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                                    <input name="license_number" placeholder="A00-00-000000" stringLength="11" class="form-control"  type="text" required>       
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Text input-->

                                        <div class="form-group">
                                            <label class="col-md-4 control-label">Phone</label>
                                            <div class="col-md-6  inputGroupContainer">
                                                <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-earphone"></i></span>
                                                    <input name="phone" placeholder="(+639)000-000-0000"  class="form-control" type="text" required>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Text input-->

                                        <div class="form-group">
                                            <label class="col-md-4 control-label">Address</label>
                                            <div class="col-md-6  inputGroupContainer">
                                                <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
                                                    <input name="address" placeholder="Address" class="form-control" type="text">
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label class="col-md-4 control-label">Birthday:</label>
                                                     <select class="fb-select" name="birthday_month" id="birthday_month">
                                                     <option value="0">Month:</option>
                                                     <option value="1">Jan</option>
                                                     <option value="2">Feb</option>
                                                     <option value="3">Mar</option>
                                                     <option value="4">Apr</option>
                                                     <option value="5">May</option>
                                                     <option value="6">Jun</option>
                                                     <option value="7">Jul</option>
                                                     <option value="8">Aug</option>
                                                     <option value="9">Sep</option>
                                                     <option value="10">Oct</option>
                                                     <option value="11">Nov</option>
                                                     <option value="12">Dec</option>
                                                </select>
                                             <select class="fb-select" name="birthday_day" id="birthday_day">
                                                            <option value="0">Day:</option>
                                                            <option value="1">1</option>
                                                            <option value="2">2</option>
                                                            <option value="3">3</option>
                                                            <option value="4">4</option>
                                                            <option value="5">5</option>
                                                            <option value="6">6</option>
                                                            <option value="7">7</option>
                                                            <option value="8">8</option>
                                                            <option value="9">9</option>
                                                            <option value="10">10</option>
                                                            <option value="11">11</option>
                                                            <option value="12">12</option>
                                                            <option value="13">13</option>
                                                            <option value="14">14</option>
                                                            <option value="15">15</option>
                                                            <option value="16">16</option>
                                                            <option value="17">17</option>
                                                            <option value="18">18</option>
                                                            <option value="19">19</option>
                                                            <option value="20">20</option>
                                                            <option value="21">21</option>
                                                            <option value="22">22</option>
                                                            <option value="23">23</option>
                                                            <option value="24">24</option>
                                                            <option value="25">25</option>
                                                            <option value="26">26</option>
                                                            <option value="27">27</option>
                                                            <option value="28">28</option>
                                                            <option value="29">29</option>
                                                            <option value="30">30</option>
                                                            <option value="31">31</option>  
                                                        </select>
                                                        <select class="fb-select" name="birthday_year" id="birthday_year">
                                                    <option value="0">Year:</option>
                                                    <option value="2011">2011</option>
                                                    <option value="2010">2010</option>
                                                    <option value="2009">2009</option>
                                                    <option value="2008">2008</option>
                                                    <option value="2007">2007</option>
                                                    <option value="2006">2006</option>
                                                    <option value="2005">2005</option>
                                                    <option value="2004">2004</option>
                                                    <option value="2003">2003</option>
                                                    <option value="2002">2002</option>
                                                    <option value="2001">2001</option>
                                                    <option value="2000">2000</option>
                                                    <option value="1999">1999</option>
                                                    <option value="1998">1998</option>
                                                    <option value="1997">1997</option>
                                                    <option value="1996">1996</option>
                                                    <option value="1995">1995</option>
                                                    <option value="1994">1994</option>
                                                    <option value="1993">1993</option>
                                                    <option value="1992">1992</option>
                                                    <option value="1991">1991</option>
                                                    <option value="1990">1990</option>
                                                    <option value="1989">1989</option>
                                                    <option value="1988">1988</option>
                                                    <option value="1987">1987</option>
                                                    <option value="1986">1986</option>
                                                    <option value="1985">1985</option>
                                                    <option value="1984">1984</option>
                                                    <option value="1983">1983</option>
                                                    <option value="1982">1982</option>
                                                    <option value="1981">1981</option>
                                                    <option value="1980">1980</option>
                                                    <option value="1979">1979</option>
                                                    <option value="1978">1978</option>
                                                    <option value="1977">1977</option>
                                                    <option value="1976">1976</option>
                                                    <option value="1975">1975</option>
                                                    <option value="1974">1974</option>
                                                    <option value="1973">1973</option>
                                                    <option value="1972">1972</option>
                                                    <option value="1971">1971</option>
                                                    <option value="1970">1970</option>
                                                    <option value="1969">1969</option>
                                                    <option value="1968">1968</option>
                                                    <option value="1967">1967</option>
                                                    <option value="1966">1966</option>
                                                    <option value="1965">1965</option>
                                                    <option value="1964">1964</option>
                                                    <option value="1963">1963</option>
                                                    <option value="1962">1962</option>
                                                    <option value="1961">1961</option>
                                                    <option value="1960">1960</option>
                                                    <option value="1959">1959</option>
                                                    <option value="1958">1958</option>
                                                    <option value="1957">1957</option>
                                                    <option value="1956">1956</option>
                                                    <option value="1955">1955</option>
                                                    <option value="1954">1954</option>
                                                    <option value="1953">1953</option>
                                                    <option value="1952">1952</option>
                                                    <option value="1951">1951</option>
                                                    <option value="1950">1950</option>
                                                    <option value="1949">1949</option>
                                                    <option value="1948">1948</option>
                                                    <option value="1947">1947</option>
                                                    <option value="1946">1946</option>
                                                    <option value="1945">1945</option>
                                                    <option value="1944">1944</option>
                                                    <option value="1943">1943</option>
                                                    <option value="1942">1942</option>
                                                    <option value="1941">1941</option>
                                                    <option value="1940">1940</option>
                                                    <option value="1939">1939</option>
                                                    <option value="1938">1938</option>
                                                    <option value="1937">1937</option>
                                                    <option value="1936">1936</option>
                                                    <option value="1935">1935</option>
                                                    <option value="1934">1934</option>
                                                    <option value="1933">1933</option>
                                                    <option value="1932">1932</option>
                                                    <option value="1931">1931</option>
                                                    <option value="1930">1930</option>
                                                    <option value="1929">1929</option>
                                                    <option value="1928">1928</option>
                                                    <option value="1927">1927</option>
                                                    <option value="1926">1926</option>
                                                    <option value="1925">1925</option>
                                                    <option value="1924">1924</option>
                                                    <option value="1923">1923</option>
                                                    <option value="1922">1922</option>
                                                    <option value="1921">1921</option>
                                                    <option value="1920">1920</option>
                                                    <option value="1919">1919</option>
                                                    <option value="1918">1918</option>
                                                    <option value="1917">1917</option>
                                                    <option value="1916">1916</option>
                                                    <option value="1915">1915</option>
                                                    <option value="1914">1914</option>
                                                    <option value="1913">1913</option>
                                                    <option value="1912">1912</option>
                                                    <option value="1911">1911</option>
                                                    <option value="1910">1910</option>
                                                    <option value="1909">1909</option>
                                                    <option value="1908">1908</option>
                                                    <option value="1907">1907</option>
                                                    <option value="1906">1906</option>
                                                    <option value="1905">1905</option>
                                                </select>
                                            </div>


                                        <!-- Text input-->

                                    <legend> Account information </legend>

                                    <fieldset>

                                        <!-- Text input-->

                                        <div class="form-group">
                                            <label class="col-md-4 control-label">E-Mail</label>
                                            <div class="col-md-6  inputGroupContainer">
                                                <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
                                                    <input name="email" placeholder="E-Mail Address" class="form-control"  type="text">
                                                </div>
                                            </div>
                                        </div>


                                        <div class="form-group has-feedback">
                                            <label for="password"  class="col-md-4 control-label">
                                                Password
                                            </label>

                                            <div class="col-md-6  inputGroupContainer">
                                                <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
                                                    <input class="form-control" id="userPw" type="password" placeholder="password" name="password" data-minLength="5" data-error="some error" required/>
                                                    <span class="glyphicon form-control-feedback"></span>
                                                    <span class="help-block with-errors"></span>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group has-feedback">
                                            <label for="confirmPassword"  class="col-md-4 control-label">
                                                Confirm Password
                                            </label>

                                            <div class="col-md-6  inputGroupContainer">
                                                <div class="input-group"> <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
                                                    <input class="form-control {$borderColor}" id="userPw2" type="password" placeholder="Confirm password" name="confirmPassword" data-match="#confirmPassword" data-minLength="5" data-match-error="some error 2" required/>
                                                    <span class="glyphicon form-control-feedback"></span>
                                                    <span class="help-block with-errors"></span>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Button -->
                                        <div class="form-group">
                                            <label class="col-md-4 control-label"></label>
                                            <div class="col-md-4">
                                                <button type="submit" class="btn btn-warning" >Register <span class="glyphicon glyphicon-send"></span></button>
                                            </div>
                                        </div>
                                        <p> Already Have an Account? <a href="Login_v16/index.html"> Log in </a>
                                    </fieldset>
                                </form>
                            </div>
                        </div>

                        <!-- PrefixFree -->
                        <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
                        <script src='http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js'></script>
                        <script src='http://cdnjs.cloudflare.com/ajax/libs/bootstrap-validator/0.4.5/js/bootstrapvalidator.min.js'></script>

                        <script src="js/index.js"></script>
                        <script type="text/javascript">

                           $(document).ready(function() {
                            $('#reg_form').bootstrapValidator({
                                // To use feedback icons, ensure that you use Bootstrap v3.1.0 or later
                                feedbackIcons: {
                                    valid: 'glyphicon glyphicon-ok',
                                    invalid: 'glyphicon glyphicon-remove',
                                    validating: 'glyphicon glyphicon-refresh'
                                },
                                fields: {
                                    first_name: {
                                        validators: {
                                                stringLength: {
                                                min: 2, 
                                            },
                                                notEmpty: {
                                                message: 'Please supply your first name'
                                            }
                                        }
                                    },
                                     last_name: {
                                        validators: {
                                             stringLength: {
                                                min: 2,
                                            },
                                            notEmpty: {
                                                message: 'Please supply your last name'
                                            }
                                        }
                                    },

                                    phone: {
                                        validators: {
                                           notEmpty: {
                                                message: 'Please supply your phone number'
                                            },
                                            phone: {
                                                country: 'Philippines',
                                                message: 'Please supply a vaild phone number with area code'
                                            }
                                        }
                                    },
                                            
                             email: {
                                        validators: {
                                            notEmpty: {
                                                message: 'Please supply your email address'
                                            },
                                            emailAddress: {
                                                message: 'Please supply a valid email address'
                                            }
                                        }
                                    },
                                confirmPassword: {
                                    validators: {
                                        identical: {
                                            field: 'password',
                                            message: 'The password and its confirm are not the same'
                                        }
                                    }
                                 },


                                    }
                                })
                                .on('success.form.bv', function(e) {
                                    $('#success_message').slideDown({ opacity: "show" }, "slow") // Do something ...
                                        $('#reg_form').data('bootstrapValidator').resetForm();

                                    // Prevent form submission
                                    e.preventDefault();

                                    // Get the form instance
                                    var $form = $(e.target);

                                    // Get the BootstrapValidator instance
                                    var bv = $form.data('bootstrapValidator');

                                    // Use Ajax to submit form data
                                    $.post($form.attr('action'), $form.serialize(), function(result) {
                                        console.log(result);
                                    }, 'json');
                                });
                                });
                                

                         </script>

                    </div>

                </div>

            </div>

          </div>

    </body>
</html>