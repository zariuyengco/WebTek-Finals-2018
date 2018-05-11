
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


app.get('/main', function(req, res){
	if(req.session.username){

		var user = req.session.username;
		connection.query("SELECT * FROM users JOIN service_provider ON spID=userID", function(err, rows1){
			if(err){console.log(err); return}

			var serviceUsers = [];
			rows1.forEach(function(item){
				if(item.username == user){
					serviceUsers.push({
						userID: item.userID,
						username: item.username,
						spID: item.spID,
						firstName: item.firstName,
						lastName: item.lastName,
						address: item.address,
						email: item.email,
						contactNo: item.contactNo,
					});
				}
			});

			connection.query("SELECT * FROM car", function(err, rows2){
				if(err){console.log(err); return}

				var serviceCars = [];
				rows2.forEach(function(item){
					serviceCars.push({
						carID: item.carID,
						brandCar: item.brandCar,
						typeCar: item.typeCar,
						modelCar: item.modelCar,
						numSeat: item.numSeat,
						transmission: item.transmission,
						mileage: item.mileage,
						yearCar: item.yearCar,
						rate: item.rate,
						carStatus: item.carStatus		
					});
				});
				res.render('main', {serviceUsers: serviceUsers, serviceCars: serviceCars});
			});
		});
	}else {
		res.redirect('/login');
	}
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

	connection.query("SELECT username, password FROM users JOIN service_provider on users.userID = service_provider.spID", function(err, rows){
		if (err) {console.error(err); return}

		var valid = false;
		console.log(rows);
		rows.forEach(function(item){
			if(item.username == username && item.password == password){
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


app.get("/create-services", function(req, res){
	res.render('create-services');
	
});

app.post('/createService', function(req, res){
	var carColumns = ['carID', 'brandCar', 'typeCar', 'yearCar', 'numSeat', 'modelCar', 'mileage', 'transmission', 'rate'];
	var carValues = [res.insertID, req.body.brand, req.body.type, req.body.year, req.body.num, req.body.model, req.body.mileage, req.body.transmission, req.body.rate];
	connection.query('INSERT INTO car (??) VALUES (?)', [carColumns, carValues], function(err, results){
		if (err) { console.error(err); return}

		res.redirect('/createRental-success');
	});
});

app.get('/createRental-success', function(req, res){
	connection.query('SELECT * FROM car ORDER BY 1 desc', function(err, rows){
		if(err) {console.log(err); return}

		var serviceCars = [];
		rows.forEach(function(item){
			serviceCars.push({
				carID: item.carID,
				brandCar: item.brandCar,
				typeCar: item.typeCar,
				modelCar: item.modelCar,
				numSeat: item.numSeat,
				transmission: item.transmission,
				mileage: item.mileage,
				yearCar: item.yearCar,
				rate: item.rate,
				carStatus: item.carStatus		
			});
		});
		res.render('createRental-success', {serviceCars: serviceCars});
	});
});


app.get("/show-reservation", function(req, res){
	if (req.session.username){
		var showReservations = [];
		connection.query('SELECT startDate, endDate, purpose, reservedDate, resStatus, CONCAT(firstName, " ", lastName) AS customerName, address, contactNo FROM reservation JOIN customer ON reservation.custID = customer.custID',function (err, rows1){
			if(err) {console.log(err); return}

			rows1.forEach(function(item){
				showReservations.push({
					startDate: item.startDate,
					endDate: item.endDate,
					purpose: item.purpose,
					reservedDate: item.reservedDate,
					resStatus: item.resStatus,
					customerName: item.customerName,
					address: item.address,
					contactNo: item.contactNo,
				});
			});

				connection.query('SELECT resID, contactNo, CONCAT(firstName, " ", lastName) as serviceName, brandCar, typeCar, modelCar, mileage, rate FROM reservation JOIN service_provider ON reservation.spID = service_provider.spID JOIN car ON reservation.carID = car.carID WHERE resStatus = "Pending"', function(err, rows2){
					if(err) {console.error(err); return}

					var pendReserve = [];
					rows2.forEach(function(item){
						pendReserve.push({
							resID: item.resID,
							serviceName: item.serviceName,
							contactNo: item.contactNo,
							brandCar: item.brandCar,
							typeCar: item.typeCar,
							modelCar: item.modelCar,
							mileage: item.mileage,
							rate: item.rate
						});
					});
						res.render('show-reservation', {showReservations: showReservations, pendReserve: pendReserve});
				});
			});
	}else {
		res.redirect('/login');
	}
});	



app.get('/edit', function(req, res){
	var carID = null;
	carID = req.query.carID;

	connection.query('SELECT * FROM car', function(err, rows){
		if(err) {console.log(err); return}

		var carValues = {};
		rows.forEach(function(item){
			if(item.carID == carID){
				carValues = {
					carID: item.carID,
					brandCar: item.brandCar,
					typeCar: item.typeCar,
					modelCar: item.modelCar,
					numSeat: item.numSeat,
					yearCar: item.yearCar,
					mileage: item.mileage,
					transmission: item.transmission,
					rate: item.rate,
					carStatus: item.carStatus
				};
			}
		});
		res.render('edit', {carValues: carValues});
	});
});

app.post('/editService', function(req, res){


	res.redirect('/edit-success');
});

app.get('/edit-success', function(req, res){
	connection.query('SELECT * FROM car ORDER BY DateModified desc', function(err, rows){
		if(err) {console.log(err); return}

		var editCar = {};
		rows.forEach(function(item){
			editCar = {
				carID: item.carID,
				brandCar: item.brandCar,
				typeCar: item.typeCar,
				modelCar: item.modelCar,
				numSeat: item.numSeat,
				transmission: item.transmission,
				mileage: item.mileage,
				yearCar: item.yearCar,
				rate: item.rate,
				carStatus: item.carStatus		
			};
		});
		res.render('edit-success', {editCar: editCar});
	});
});

app.get('/transaction', function(req, res){
	if(req.session.username){
		var transactions = [];
		connection.query('SELECT transID, CONCAT(customer.firstName, ' ', customer.lastName) AS 'customerName', CONCAT(service_provider.firstName, ' ', service_provider.lastName) AS 'providerName', payStatus, startDate, endDate, transStatus FROM transaction JOIN reservation ON transaction.resID = reservation.resID JOIN customer USING(custID) JOIN service_provider USING(spID)', function(err, rows){
			if (err) {console.log(err); return;}

			rows.forEach(function(item){
				transactions.push({
					transID: item.transID,
					customerName: item.customerName,
					providerName: item.providerName,
					payStatus: item.payStatus,
					startDate: item.startDate,
					endDate: item.endDate,
					transStatus: item.transStatus
				});
			});
			res.render('transaction', {transactions: transactions});
		});
	}else {
		res.redirect('/login');
	}
});






