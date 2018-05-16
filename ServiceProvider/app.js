
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
		//console.log(rows);
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
	if(req.session.username){
		res.render('create-services');
	}else {
		res.redirect('/login');
	}
});

app.post('/createService', function(req, res){
	if (req.session.username){
		var carColumns = ['carID', 'brandCar', 'typeCar', 'yearCar', 'numSeat', 'modelCar', 'mileage', 'transmission', 'rate'];
		var carValues = [res.insertID, req.body.brand, req.body.type, req.body.year, req.body.num, req.body.model, req.body.mileage, req.body.transmission, req.body.rate];
		connection.query('INSERT INTO car (??) VALUES (?)', [carColumns, carValues], function(err, results){
			if (err) { console.error(err); return}

			res.redirect('/createRental-success');
		});
	}else {
		res.redirect('/login');
	}
});

app.get('/createRental-success', function(req, res){
	if (req.session.username){
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
	}else {
		res.redirect('/login');
	}
});


app.get("/show-reservation", function(req, res){
	if (req.session.username){
		var showReservations = [];
		connection.query('SELECT resID, contactNo, reservedDate, resStatus, CONCAT(firstName, " ", lastName) AS customerName, address FROM reservation JOIN customer ON reservation.custID = customer.custID WHERE resStatus ="Ongoing"',function (err, rows1){
			if(err) {console.log(err); return}

			rows1.forEach(function(item){
				showReservations.push({
					reservedDate: item.reservedDate,
					resStatus: item.resStatus,
					customerName: item.customerName,
					address: item.address,
					contactNo: item.contactNo,
					resID: item.resID
				});
			});

			connection.query('SELECT resID, service_provider.contactNo AS "spContactNo", customer.contactNo AS "cContact", purpose, CONCAT(service_provider.firstName, " ", service_provider.lastName) as serviceName, CONCAT(customer.firstName, " ", customer.lastName) as customerName, brandCar, typeCar, modelCar, mileage, rate FROM reservation JOIN service_provider ON reservation.spID = service_provider.spID JOIN car ON reservation.carID = car.carID JOIN customer ON reservation.custID = customer.custID WHERE resStatus = "Pending"', function(err, rows2){
				if(err) {console.error(err); return}

				var pendReserve = [];
				rows2.forEach(function(item){
					pendReserve.push({
						resID: item.resID,
						customerName: item.customerName,
						serviceName: item.serviceName,
						spContactNo: item.spContactNo,
						brandCar: item.brandCar,
						typeCar: item.typeCar,
						modelCar: item.modelCar,
						mileage: item.mileage,
						rate: item.rate,
						cContact: item.cContact,
						purpose: item.purpose
					});
				});

				connection.query('SELECT resID, startDate, endDate FROM reservation WHERE resStatus = "Ongoing"', function(err, rows3){
					if (err) {console.log(err); return}

					var date = [];
					rows3.forEach(function(item){
						date.push({
							resID: item.resID,
							startDate: item.startDate,
							endDate: item.endDate
						});
					});
					res.render('show-reservation', {showReservations: showReservations, pendReserve: pendReserve, date: date});
				});
			});
		});
	}else {
		res.redirect('/login');
	}
});	



app.get('/edit', function(req, res){
	if (req.session.username){
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
	}else {
		res.redirect('/login');
	}
});

app.post('/editService', function(req, res){
	connection.query("UPDATE car SET brandCar = '" + req.body.brand + "' WHERE carID = '" + req.body.carID + "'", function(err, row1){
		if (err) {console.log(err); return}
		
		connection.query("UPDATE car SET typeCar = '" + req.body.type + "' WHERE carID = '" + req.body.carID + "'", function(err, row2){
			if (err) {console.log(err); return}

			connection.query("UPDATE car SET modelCar = '" + req.body.model + "' WHERE carID = '" + req.body.carID + "'", function(err, row3){
				if (err) {console.log(err); return}

				connection.query("UPDATE car SET transmission = '" + req.body.transmission + "' WHERE carID = '" + req.body.carID + "'", function(err, row4){
					if (err) {console.log(err); return}

					connection.query("UPDATE car SET numSeat = '" + req.body.num + "' WHERE carID = '" + req.body.carID + "'", function(err, row5){
						if (err) {console.log(err); return}

						connection.query("UPDATE car SET yearCar = '" + req.body.year + "' WHERE carID = '" + req.body.carID + "'", function(err, row6){
							if (err) {console.log(err); return}

							connection.query("UPDATE car SET mileage = '" + req.body.mileage + "' WHERE carID = '" + req.body.carID + "'", function(err, row7){
								if (err) {console.log(err); return}

								connection.query("UPDATE car SET rate = '" + req.body.rate + "' WHERE carID = '" + req.body.carID + "'", function(err, row8){
									if (err) {console.log(err); return}

									connection.query("UPDATE car SET carStatus = '" + req.body.status + "' WHERE carID = '" + req.body.carID + "'", function(err, row9){
										if (err) {console.log(err); return}

										res.redirect('/main');
									});
								});
							});
						});
					});
				});
			});
		});
	});
});

app.get('/edit-success', function(req, res){
	if (req.session.username){
		connection.query("SELECT * FROM car", function(err, rows){
			if (err) {console.log(err); return}

			var editService = {};
			rows.forEach(function(item){
				editService = {
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
			res.render('edit-success', {editService: editService, carValues: carValues});
		});
	}else {
		res.redirect('/login');
	}
});

app.get('/transaction', function(req, res){
	if(req.session.username){
		var transactions = [];
		connection.query("SELECT transID, CONCAT(customer.firstName, ' ', customer.lastName) AS 'customerName', CONCAT(service_provider.firstName, ' ', service_provider.lastName) AS 'providerName', startDate, endDate, transStatus FROM transaction JOIN reservation ON transaction.resID = reservation.resID JOIN customer USING(custID) JOIN service_provider USING(spID)", function(err, rows){
			if (err) {console.log(err); return;}

			rows.forEach(function(item){
				transactions.push({
					transID: item.transID,
					customerName: item.customerName,
					providerName: item.providerName,
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


app.post('/accept', function(req, res){
	connection.query("UPDATE reservation SET resStatus = 'Ongoing' WHERE resID = '" + req.body.resID + "'", function(err, rows){
		if (err) {console.log(err); return}

	res.redirect('/show-reservation'); 
	});
});

app.post('/deny', function(req, res){
	connection.query("UPDATE reservation SET resStatus = 'Denied' WHERE resID = '" + req.body.resID + "'", function(err, rows){
		if (err) {console.log(err); return}

		var transColumn = ['resID', 'transStatus'];
		var transValues = [req.body.resID, 'Denied'];
		connection.query("INSERT INTO transaction (??) VALUES (?)", [transColumn, transValues], function(err, rows){
			if (err) {console.log(err); return}

			res.redirect('/transaction'); 
		});
	});
});

app.post('/done', function(req, res){
	connection.query("UPDATE reservation SET resStatus = 'Done' WHERE resID = '" + req.body.resID + "'", function(err, rows){
		if (err) {console.log(err); return}

		var transColumn = ['resID', 'transStatus'];
		var transValues = [req.body.resID, 'Done'];
		connection.query("INSERT INTO transaction (??) VALUES (?)", [transColumn, transValues], function(err, rows){
			if (err) {console.log(err); return}

			res.redirect('/transaction'); 
		});
	});
});


app.get('/payment', function(req, res){
	if (req.session.username){		
		var paid = [];
		connection.query('SELECT payID, payStatus, payDate, totalAmount, paidAmount, miscFee, CONCAT(customer.firstName, " ", customer.lastName) AS customerName, CONCAT(service_provider.firstName, " ", service_provider.lastName) AS providerName FROM paymentdetails JOIN transaction ON paymentdetails.transID = transaction.transID JOIN reservation ON transaction.resID = reservation.resID JOIN customer ON reservation.custID = customer.custID JOIN service_provider ON reservation.spID = service_provider.spID WHERE payStatus = "Paid"', function(err, rows1){
			if (err) {console.log(err); return}

			rows1.forEach(function(item){
				paid.push({
					payID: item.payID,
					payDate: item.payDate,
					totalAmount: item.totalAmount,
					paidAmount: item.paidAmount,
					miscFee: item.miscFee,
					customerName: item.customerName,
					providerName: item.providerName,
					payStatus: item.payStatus
				});
			});
			connection.query('SELECT payID, payStatus, payDate, totalAmount, paidAmount, miscFee, CONCAT(customer.firstName, " ", customer.lastName) AS customerName, CONCAT(service_provider.firstName, " ", service_provider.lastName) AS providerName FROM paymentdetails JOIN transaction ON paymentdetails.transID = transaction.transID JOIN reservation ON transaction.resID = reservation.resID JOIN customer ON reservation.custID = customer.custID JOIN service_provider ON reservation.spID = service_provider.spID WHERE payStatus = "Partial Paid"', function(err, rows2){
				if (err) {console.log(err); return}

				var partial = [];
				rows2.forEach(function(item){
					partial.push({
						payID: item.payID,
						payDate: item.payDate,
						totalAmount: item.totalAmount,
						paidAmount: item.paidAmount,
						miscFee: item.miscFee,
						payStatus: item.payStatus,
						customerName: item.customerName,
						providerName: item.providerName
					});
				});
				res.render('payment', {paid: paid, partial: partial});
			});
		});
	}else {
		res.redirect('/login');
	}
});


app.get('/add-payment', function(req, res){
	if (req.session.username){
		var user = req.session.username;

		connection.query('SELECT username, userID, CONCAT(firstName, " ", lastName) AS providerName FROM users JOIN service_provider ON spID = userID', function(err, row1){
			if (err) {console.log(err); return}

			var name = {};
			row1.forEach(function(item){
				if (item.username == user){
					name = {
						userID: item.userID,
						providerName: item.providerName
					}
				}
			});

			connection.query("SELECT startDate, endDate, rate FROM reservation JOIN car on reservation.carID = car.carID WHERE ", function(err, row2){
				if (err) {console.log(err); return}

				var startDay = startDate.split(" ")[0].split("-")[1];
				var endDay = endDate.split(" ")[0].split("-")[1];

				var day = endDay - startDay;
				row2.forEach(function(item){					
					if (day == 0){
						totalAmount = {
							rate: item.rate,
						}
					}else {
						totalAmount = {
							rate: item.rate,
							day
						}
					} 
				}); 
			});
			res.render('add-payment', {name: name, totalAmount: totalAmount});
		});
	}else {
		res.redirect('/login');
	}
});


app.post('/add-payment', function(req, res){
	var payColumns = ['payID', 'firstName', 'lastName', 'paidAmount'];
	var payValues = [results.insertID, req.body.firstName, req.body.lastName, req.body.paidAmount];
	connection.query('INSERT INTO paymentdetails (??) VALUES (?)', [payColumns, payValues], function(err, results){
		if (err) {console.log(err); return}
		
		res.redirect('/payment');
	});
});

app.post('/search-transaction-status', function(req, res){
	var status = [req.body.status];
	var transaction = [];

	connection.query(`SELECT transID, transStatus, CONCAT(customer.firstName, ' ', customer.lastName) AS 'customerName', CONCAT(service_provider.firstName, ' ', service_provider.lastName) AS 'providerName', startDate, endDate FROM transaction JOIN reservation ON transaction.resID = reservation.resID JOIN customer USING(custID) JOIN service_provider USING(spID) WHERE transStatus = '${status}'`, function(err, rows1){
		if (err) {console.log(err); return}

		rows1.forEach(function(item){
			transaction.push({
				transID: item.transID,
				customerName: item.customerName,
				providerName: item.providerName,
				startDate: item.startDate,
				endDate: item.endDate,
				tranStatus: item.tranStatus
			});
		});
		res.render('transaction', {transactions: transaction});
	});
});






















