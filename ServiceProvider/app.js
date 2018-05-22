
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

app.get('/profile', function(req, res){
	if(req.session.username){

		var user = req.session.username;
		connection.query("SELECT * FROM users JOIN service_provider ON spID=userID", function(err, rows1){
			if(err){console.log(err); return}

			var serviceUsers = {};
			rows1.forEach(function(item){
				if(item.username == user){
					serviceUsers = {
						userID: item.userID,
						spID: item.spID,
						firstName: item.firstName,
						lastName: item.lastName,
						email: item.email,
						contactNo: item.contactNo,						
					};
				}
			});
			res.render('profile', {serviceUsers: serviceUsers});
		});
	}else {
		res.redirect('/login');
	}
});

app.get('/edit-profile', function(req, res){
	if(req.session.username){

		var user = req.session.username;
		connection.query("SELECT * FROM users JOIN service_provider ON spID=userID", function(err, rows1){
			if(err){console.log(err); return}

			var serviceUsers = {};
			rows1.forEach(function(item){
				if(item.username == user){
					serviceUsers = {
						userID: item.userID,
						username: item.username,
						spID: item.spID,
						firstName: item.firstName,
						lastName: item.lastName,
						email: item.email,
						contactNo: item.contactNo,
						password: item.password
					};
				}
			});
			res.render('edit-profile', {serviceUsers: serviceUsers});
		});
	}else {
		res.redirect('/login');
	}
});

app.post('/edit-profile', function(req, res){
	var update = "UPDATE service_provider SET firstName = ?, lastName=?, email=?, contactNo=? WHERE spID=?";
	connection.query(update, [req.body.firstname, req.body.lastname, req.body.email, req.body.contact, req.body.spID], function(err, row){
		if (err) {console.log(err); return}

		var update1 = "UPDATE users SET username=?, password=? WHERE userID = ?";

		connection.query(update1, [req.body.username, req.body.retype, req.body.spID], function(err, row1){
			if(err) {console.log(err); return}

			res.redirect('/profile');
		});
	});
});

app.get('/main', function(req, res){
	if(req.session.username){

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
					carStatus: item.carStatus,
					carQuantity: item.carQuantity,
					statusQuantity: item.statusQuantity		
				});
			});
			res.render('main', {serviceCars: serviceCars});
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
	
	connection.query("SELECT username, userType FROM users WHERE status = 'Activate'", function(err, rows){
		if (err) {console.log(err); return}

		var valid = false;
		console.log(rows);
		rows.forEach(function(item){
			if(item.username == username){
				valid = true;
				var userType = item.userType;

				if(userType == "Customer"){
					res.redirect('http://customer.cargo.com/login.jsp?username=' + req.body.username);
				}else if (userType == 'Administrator'){
					res.redirect('http://admin.cargo.com/login.php?username=' + req.body.username);
				}else{
					res.redirect('/password?username=' + req.body.username);
				}
			}
		});

		if(!valid){
			res.redirect('/error');
		}
	});
});

var uName = null;
app.get('/password', function(req, res){
	uName = req.query.username;
	res.render('password');
});

app.post('/password', function(req, res){
	var password = req.body.password;
	var username = uName;

	connection.query("SELECT username, password FROM users WHERE status = 'Activate'", function(err, rows){
		if (err) {console.log(err); return}

		var valid = false;
		rows.forEach(function(item){
			if(item.username == username && item.password == password){
				var userType = item.userType;
				valid = true;

				req.session.username = username;
				res.redirect('/main');
			}
		});

		if (!valid){
			res.redirect('/error');
		}
	});
});


app.get('/forgot-password', function(req, res){
	uName = req.query.username;
	res.render('forgot-password');
});

app.post('/forgot-password', function(req, res){
	var username = uName;

	connection.query("UPDATE users SET password ='" + req.body.retype + "' WHERE username = '" + username + "'", function(err, row){
		if (err) {console.log(err); return}

		res.redirect('/main');
	});
});


app.get('/register', function(req, res){
	res.render('register', {userObject: null});
});

app.post('/register', function(req, res){
	var userColumns = ['username', 'password', 'userType', 'status'];
	var userValues = [req.body.username, req.body.retype, req.body.userType, 'Activate'];
	var userObject = {
		username: req.body.username,
		password: req.body.password,
		firstName: req.body.firstname,
		lastName: req.body.lastname,
		contactNumber: req.body.contact,
		email: req.body.email,
		passwordError: "",
		usernameError: ""
	}

	console.log(userObject.passwordError);

	var foundUser = false;

	if(req.body.retype != req.body.password){
		userObject.passwordError = "Wrong Password";
		//res.render('register', {userObject: userObject});

		// return;
	}

	connection.query("SELECT username FROM users", function(err, rows){
		if(err) {console.log(err); return}

		rows.forEach(function(item){
			if(item.username == req.body.username){
				userObject.usernameError = "Username already exists!";
				res.render('register', {userObject: userObject});
				foundUser = true;
				return;
			}
		})

		console.log("dumaan ren siya dito");
		if(!foundUser){
			connection.query("INSERT INTO users (??) VALUES (?)", [userColumns, userValues], function(err, res1){
				if(err) {console.log(err); return}

				var spColumns = ['spID', 'email', 'firstName', 'lastName', 'contactNo'];
				var spValues = [res1.insertId, req.body.email, req.body.firstname, req.body.lastname, req.body.contact];

				connection.query("INSERT INTO service_provider (??) VALUES (?)", [spColumns, spValues], function(err, res2){
					if (err) {console.log(err); return}

					res.redirect('/login');
				});
			});	
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

			res.redirect('/main');
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
		var pendingReservations = [];
		var acceptedReservations = [];
		var reservations = [];

		connection.query('SELECT customer.custID, resID, contactNo, reservedDate, resStatus, CONCAT(firstName, " ", lastName) AS customerName, address FROM reservation JOIN customer ON reservation.custID = customer.custID WHERE resStatus ="Accepted"',function (err, rows1){
			if(err) {console.log(err); return}

			rows1.forEach(function(item){
				acceptedReservations.push({
					custID: item.custID,
					reservedDate: item.reservedDate,
					resStatus: item.resStatus,
					customerName: item.customerName,
					address: item.address,
					contactNo: item.contactNo,
					resID: item.resID
				});
			});

			connection.query('SELECT reservation.custID as custID, resID, service_provider.contactNo AS "spContactNo", customer.contactNo AS "cContact", purpose, CONCAT(service_provider.firstName, " ", service_provider.lastName) as serviceName, CONCAT(customer.firstName, " ", customer.lastName) as customerName, brandCar, typeCar, modelCar, mileage, rate FROM reservation JOIN service_provider ON reservation.spID = service_provider.spID JOIN car ON reservation.carID = car.carID JOIN customer ON reservation.custID = customer.custID WHERE resStatus = "Pending"', function(err, rows2){
				if(err) {console.error(err); return}

				rows2.forEach(function(item){
					pendingReservations.push({
						custID: item.custID,
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
				connection.query("SELECT resID, contactNo, startDate, endDate, reservedDate, resStatus, CONCAT(firstName, ' ', lastName) AS customerName, address, brandCar, typeCar, modelCar FROM reservation JOIN customer ON reservation.custID = customer.custID JOIN car ON reservation.carID = car.carID", function(err, rows3){
					if (err) {console.log(err); return}

					rows3.forEach(function(item){
						reservations.push({
							reservedDate: item.reservedDate,
							resStatus: item.resStatus,
							customerName: item.customerName,
							address: item.address,
							contactNo: item.contactNo,
							resID: item.resID,
							brandCar: item.brandCar,
							typeCar: item.typeCar,
							modelCar: item.modelCar,
							startDate: item.startDate,
							endDate: item.endDate
						});
					});
				res.render('show-reservation', {acceptedReservations: acceptedReservations, pendingReservations: pendingReservations, reservations: reservations});
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
						carStatus: item.carStatus,
						carQuantity: item.carQuantity,
						statusQuantity: item.statusQuantity
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
	var update = "UPDATE car SET brandCar=?, typeCar=?, modelCar=?, transmission=?, numSeat=?, yearCar=?, mileage=?, rate=?, carStatus=?, carQuantity=?, statusQuantity=? WHERE carID = ?";
	var updateValues = [req.body.brand, req.body.type, req.body.model, req.body.transmission, req.body.num, req.body.year, req.body.mileage, req.body.rate, req.body.status, req.body.quantity, req.body.stats, req.body.carID];

	connection.query(update, updateValues, function(err, rows){
		if (err) {console.log(err); return}
		
		res.redirect('/main');
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
	connection.query("UPDATE reservation SET resStatus = 'Accepted' WHERE resID = '" + req.body.resID + "'", function(err, rows){
		if (err) {console.log(err); return}

		res.redirect('/show-reservation'); 
	});
});

app.post('/deny', function(req, res){
	connection.query("UPDATE reservation SET resStatus = 'Denied' WHERE resID = '" + req.body.resID + "'", function(err, rows){
		if (err) {console.log(err); return}

		var transColumn = ['resID', 'resStatus'];
		var transValues = [req.body.resID, 'Denied'];
		connection.query("INSERT INTO reservation (??) VALUES (?)", [transColumn, transValues], function(err, rows){
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
		var payments = [];
		connection.query('SELECT reservation.custID, payID, payDate, transStatus, totalAmount, paidAmount, miscFee, CONCAT(customer.firstName, " ", customer.lastName) AS customerName, CONCAT(service_provider.firstName, " ", service_provider.lastName) AS providerName FROM paymentdetails JOIN transaction ON paymentdetails.transID = transaction.transID JOIN reservation ON transaction.resID = reservation.resID JOIN customer ON reservation.custID = customer.custID JOIN service_provider ON reservation.spID = service_provider.spID', function(err, rows1){
			if (err) {console.log(err); return}

			rows1.forEach(function(item){
				payments.push({
					custID: item.custID,
					payID: item.payID,
					payDate: item.payDate,
					totalAmount: item.totalAmount,
					paidAmount: item.paidAmount,
					miscFee: item.miscFee,
					customerName: item.customerName,
					providerName: item.providerName,
					payStatus: item.transStatus
				});
			});

			res.render('payment', {payments: payments});
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
			connection.query("SELECT transaction.transID, CONCAT(firstName, ' ', lastName) as customerName, rate, reservation.resID, paymentdetails.payID, DAY(startDate) as startDate, DAY(endDate) as endDate FROM customer JOIN reservation ON reservation.custID = customer.custID JOIN car ON reservation.carID = car.carID JOIN transaction ON transaction.resID = reservation.resID JOIN paymentdetails ON transaction.transID = paymentdetails.transID WHERE reservation.custID ='" + req.query.custID + "'", function(err, row2){
				if (err) {console.log(err); return}

				var thingy = {};

				row2.forEach(function(item){
					console.log(item.rate)
					console.log(item.startDate)
					console.log(item.endDate)
					var totalAmount = 0;
					if ( item.startDate-item.endDate == 0){
						totalAmount = item.rate;
					}else {
						totalAmount = item.rate*((item.endDate) - (item.startDate));
					} 
					console.log(totalAmount);
					thingy = {
						transID: item.transID,
						customerName: item.customerName,
						totalAmount: totalAmount,
						resID: item.resID,
						payID: item.payID,
						payStatus: item.payStatus,
					}
				});	
				
				res.render('add-payment', {name: name, thingy: thingy});
			});
		});
	}else {
		res.redirect('/login');
	}
});

app.get('/payment-reservation', function(req, res){
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

			connection.query('SELECT customer.custID, CONCAT(firstName, " ", lastName) as customerName, rate, reservation.resID as resID, DAY(startDate) as startDate, DAY(endDate) as endDate FROM customer NATURAL JOIN reservation NATURAL JOIN car WHERE reservation.custID = "' + req.query.custID + '"', function(err, rows2){
				if (err) { console.log(err); return }

				var customerDetails = {};
				rows2.forEach(function(item){
					var totalAmount = (item.endDate - item.startDate == 0) ? item.rate : (item.rate * (item.endDate - item.startDate));
					console.log(item.resID);
					customerDetails = {
						customerName: item.customerName,
						rate: item.rate,
						resID: item.resID,
						totalAmount: totalAmount
					}
				});

				res.render('payment-reservation', {name: name, customerDetails: customerDetails});
			});
		});
	}else {
		res.redirect('/login');
	}
});

app.post('/payment-reservation', function(req, res){
	console.log(req.body.resID);
	var transColumns = ['resID', 'transStatus'];
	var transValues = [req.body.resID, 'Partially Paid'];
	connection.query("INSERT INTO transaction (??) VALUES (?)", [transColumns, transValues], function(err, results){
		if (err) {console.log(err); return}

		var payColumns = ['transID','paidAmount', 'totalAmount'];
		var payValues = [results.insertId, req.body.paidAmount, req.body.totalAmount];
		connection.query("INSERT INTO paymentdetails (??) VALUES (?)", [payColumns, payValues], function(err, results){
			if (err) {console.log(err); return}

			connection.query("UPDATE reservation SET resStatus = 'Ongoing' WHERE resID = '" + req.body.resID + "'" , function(err, row){
				if (err) {console.log(err); return}
				res.redirect('/payment');
			});
		});
	});
});


app.post('/add-payment', function(req, res){
	var total = Number(req.body.totalAmount) + Number(req.body.miscFee);
	var payValues = [req.body.totalAmount, req.body.paidAmount, req.body.miscFee, req.body.transID];
	console.log("asadsada ==============================")
	console.log(req.body.transID)
	connection.query('UPDATE paymentdetails SET totalAmount = ?, paidAmount = ?, miscFee = ? WHERE transID = ?', payValues, function(err, results){
		if (err) {console.log(err); return}
		
		if(total == req.body.paidAmount){
			connection.query('UPDATE transaction SET transStatus = ? WHERE transID = ?', ["Fully Paid", req.body.transID], function(err, results2){
				if (err) {console.log(err); return}
				res.redirect('/payment');
			})
		}
	});
});

app.post('/search-transaction-status', function(req, res){
	var status = [req.body.status];
	var transaction = [];

	connection.query(`SELECT transID, transStatus, CONCAT(customer.firstName, ' ', customer.lastName) AS 'customerName', CONCAT(service_provider.firstName, ' ', service_provider.lastName) AS 'providerName', startDate, endDate FROM transaction JOIN reservation ON transaction.resID = reservation.resID JOIN customer USING(custID) JOIN service_provider USING(spID) WHERE transStatus = ?`, status, function(err, rows1){
		if (err) {console.log(err); return}

		rows1.forEach(function(item){
			transaction.push({
				transID: item.transID,
				customerName: item.customerName,
				providerName: item.providerName,
				startDate: item.startDate,
				endDate: item.endDate,
				transStatus: item.transStatus
			});
		});
		res.render('transaction', {transactions: transaction});
	});
});

app.post('/search-reservation', function(req, res){
	var status = [req.body.status];
	var reservation = [];

	connection.query(`SELECT resID, contactNo, startDate, endDate, reservedDate, resStatus, CONCAT(firstName, ' ', lastName) AS customerName, address, brandCar, typeCar, modelCar FROM reservation JOIN customer ON reservation.custID = customer.custID JOIN car ON reservation.carID = car.carID WHERE resStatus = ?`, status, function(err, rows){
		if (err) {console.log(err); return}

		rows.forEach(function(item){
			reservation.push ({
				reservedDate: item.reservedDate,
				resStatus: item.resStatus,
				customerName: item.customerName,
				address: item.address,
				contactNo: item.contactNo,
				resID: item.resID,
				brandCar: item.brandCar,
				typeCar: item.typeCar,
				modelCar: item.modelCar,
				startDate: item.startDate,
				endDate: item.endDate
			});
		});
		res.render('search-reservation', {reservation: reservation});
	});
});

app.get('/search-reservation', function(req, res){
	res.render('search-reservation');
})























