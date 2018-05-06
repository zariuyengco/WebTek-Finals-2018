
'use strict';

Object.values = Object.values || (obj => Object.keys(obj).map(key => obj[key]));
var express = require('express');
var session = require('express-session');
var bodyParser = require('body-parser');
var sql = require('mysql');


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
	password: '',
	database: 'cargo_database'
});

connection.connect(function(err){
	if(err) {console.error(err); return}
	console.log('Connection to database successful');
});



app.get('/', function (req, res){
	res.sendFile(__dirname + "/" + "index.html"); // to handle home page requests 
});

app.get('/main', function(req, res){

});

app.get('/login', function(req, res){
	res.render('login');
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

app.post('/login', function(req, res){
	var username = req.body.username;
	var password = req.body.password;

	connection.query("SELECT *FROM users JOIN customer on user.userID = customer.custID WHERE username = 'username' AND password = 'password'", function(req, rows){
		if (err) { console.error(err); return }

		var result = false;
		console.log('rows');
		rows.forEach(function (item) {
			result = true;


		})
	}) 

})


var userName = null;
app.get('/password', function(req, res){
	userName = req.query.username;
	res.render('password');
});

app.post('/password', function(req, res){
	var password = req.body.password; 
	var username = username;

	connection.query("SELECT username, password FROM users WHERE status = 1", function(err, rows){
		if (err) { console.error(err); return }

		var valid = false;
		rows.forEach(function(item){
			if(item.username == username && item.password == password){
				var userType = item.userType;
				valid = true;

				req.session.username = username;
				res.redirect('/main');
			}
		});

		if(!valid){
			res.redirect('/error');
		}
	});
});






