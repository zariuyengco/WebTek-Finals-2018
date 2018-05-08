
'use strict';

Object.values = Object.values || (obj => Object.keys(obj).map(key => obj[key]));
var express = require('express');
var session = require('express-session');
var bodyParser = require('body-parser');
var mysql = require('mysql');


var app = express();

app.set('view engine', 'ejs');
app.use('/style', express.static('style'));
app.use(bodyParser.urlencoded({extended: false}));

app.use(session({
	secret: 'Shh, its a secret',
	resave: false,
	saveUninitialized: true, 
}));

app.listen(1234, function(){
	console.log('listening to port 1234');
});


var connection = mysql.createConnection({
	host: 'localhost',
	user: 'root',
	port: 3306,
	password: '',
	database: 'cargo database'
});

connection.connect(function(err){
	if(err) {console.error(err); return}
	console.log('Connection to database successful');
});


app.get('/', function (req, res){
	res.sendFile(__dirname + "/index.html"); // to handle home page requests 
});


app.get('/login', function(req, res){
	res.render('login');
});

app.post('/login', function(req, res){
	var username = req.body.username;

	connection.query("SELECT * FROM user JOIN customer on user.userID = customer.custID")
})

app.get('/main', function(req, res){
	res.render('main');
});



app.get('/logout', function(req, res){
	req.session.destroy(function(err){
		if(err){console.error(err); return}
	res.redirect('/');
	});
});


app.get('/error', function(req, res){
	res.render('error');
});

app.get("/create-services", function(req, res){
	res.render('create-services');
});

app.get("/show-reservation", function(req, res){
	res.render('show-reservation');
});






