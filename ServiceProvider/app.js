
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
	database: 'cargo_database'
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

		connection.query("SELECT * FROM car NATURAL JOIN service_provider WHERE spID = ?", req.session.userID, function(err, rows2){
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
					statusQuantity: item.statusQuantity,
					plateNo: item.plateNo	
				});
			});
			res.render('main', {serviceCars: serviceCars});
		});
	}else {
		res.redirect('/login');
	}
});

app.post('/unavailable', function(req, res){
	connection.query("UPDATE car SET carStatus = 'Unavailable' WHERE carID = '" + req.body.carID + "'", function(err, row){
		if (err) {console.log(err); return}

		res.redirect('/main');
	});
});

app.post('/available', function(req, res){
	connection.query("UPDATE car SET carStatus = 'Available' WHERE carID = '" + req.body.carID + "'", function(err, row){
		if (err) {console.log(err); return}

		res.redirect('/main');
	});
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
	
	connection.query("SELECT username, userType FROM users WHERE status = 'Activated'", function(err, rows){
		if (err) {console.log(err); return}

		var valid = false;
		console.log(rows);
		rows.forEach(function(item){
			if(item.username == username){
				valid = true;
				var userType = item.userType;

				if(userType == "Administrator"){
					res.redirect('http://admin.cargo2018.com/loginAdmin.php?username=' + req.body.username);
				}else if (userType == "SuperAdmin"){
					res.redirect('http://admin.cargo2018.com/login.php?username=' + req.body.username);
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

//var uName = null;
app.get('/password', function(req, res){
	var uName = req.query.username;
	console.log(uName);
	var user = {
		username: uName
	}
	res.render('password', {user: user});
});

app.post('/password', function(req, res){
	var password = req.body.password;
	var username = req.body.username;

	connection.query("SELECT userID, username, password FROM users WHERE status = 'Activated'", function(err, rows){
		if (err) {console.log(err); return}

		var valid = false;
		rows.forEach(function(item){
			if(item.username == username && item.password == password){
				var userType = item.userType;
				valid = true;

				req.session.username = username;
                req.session.userID = item.userID;
				res.redirect('/main');
			}
		});

		if (!valid){
			res.redirect('/error');
		}
	});
});


app.get('/forgot-password', function(req, res){
	req.session.username = req.query.username;
	var username = req.session.username;

	connection.query("SELECT question, answer, password FROM users WHERE username=?", username, function(err, row){
		if (err) {console.log(err); return}

		var forgot = {};
		row.forEach(function(item){
			forgot = {
				question: item.question,
				answer: item.answer,
				password: item.password
			}
		});
		res.render('forgot-password', {forgot: forgot});
	});
});


app.post('/forgot-password', function(req, res){
	var username = req.session.username;

	connection.query("SELECT question, answer, password FROM users WHERE username=?", username, function(err, row){
		if (err) {console.log(err); return}

		var forgot = {};
		row.forEach(function(item){
			forgot = {
				question: item.question,
				answer: item.answer,
				password: item.password
			}
			console.log(item.answer+"=============");
		});
		//console.log(forgot.answer);

		if (forgot.answer == req.body.answer){
			res.redirect('/new-password');
		}else {
			res.redirect('/login');
		}	
	});
});

app.get('/new-password', function(req, res){
	res.render('new-password');
});

app.post('/new-password', function(req, res){

	if(req.body.password != req.body.retype){
		res.redirect('/new-password');
	}else {
		connection.query('UPDATE users SET password =? WHERE username=?', [req.body.password, req.session.username], function(err, row){
			if (err) {console.log(err); return}

			req.session.destroy(function(err){
				if(err){console.error(err); return}
				res.redirect('/login');
			});
		});
	}
});


app.get('/register', function(req, res){
	res.render('register', {userObject: null});
});

app.post('/register', function(req, res){
	var userColumns = ['username', 'password', 'userType', 'status', 'question', 'answer'];
	var userValues = [req.body.username, req.body.retype, req.body.userType, 'Deactivated', req.body.question, req.body.answer];
	var userObject = {
		username: req.body.username,
		password: req.body.password,
		firstName: req.body.firstname,
		lastName: req.body.lastname,
		contactNumber: req.body.contact,
		email: req.body.email,
		question: req.body.question,
		answer: req.body.answer,
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
		var carColumns = ['brandCar', 'typeCar', 'yearCar', 'numSeat', 'modelCar', 'mileage', 'transmission', 'rate', 'carQuantity', 'spID', 'plateNo'];
		var carValues = [req.body.brand, req.body.type, req.body.year, req.body.num, req.body.model, req.body.mileage, req.body.transmission, req.body.rate, req.body.quantity, req.session.userID, req.body.number];
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
		console.log(req.session.spID);
		var pendingReservations = [];
		var acceptedReservations = [];
		var reservations = [];

		connection.query('SELECT car.spID, customer.custID, resID, contactNo, reservedDate, resStatus, CONCAT(firstName, " ", lastName) AS customerName, address FROM reservation JOIN customer ON reservation.custID = customer.custID NATURAL JOIN car WHERE resStatus ="Accepted" AND spID="?"', req.session.userID ,function (err, rows1){
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

			connection.query('SELECT reservation.custID as custID, resID, service_provider.contactNo AS "spContactNo", customer.contactNo AS "cContact", purpose, CONCAT(service_provider.firstName, " ", service_provider.lastName) as serviceName, CONCAT(customer.firstName, " ", customer.lastName) as customerName, brandCar, typeCar, modelCar, mileage, rate FROM reservation JOIN car ON reservation.carID = car.carID JOIN customer ON reservation.custID = customer.custID JOIN service_provider ON car.spID = service_provider.spID WHERE resStatus = "Pending" AND car.spID = "?"', req.session.userID, function(err, rows2){
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
				connection.query("SELECT resID, contactNo, startDate, endDate, reservedDate, resStatus, CONCAT(firstName, ' ', lastName) AS customerName, address, brandCar, typeCar, modelCar FROM reservation JOIN customer ON reservation.custID = customer.custID JOIN car ON reservation.carID = car.carID WHERE spID = '?'", req.session.userID, function(err, rows3){
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
	var update = "UPDATE car SET brandCar=?, typeCar=?, modelCar=?, transmission=?, numSeat=?, yearCar=?, mileage=?, rate=?, carQuantity=?, statusQuantity=? WHERE carID = ?";
	var updateValues = [req.body.brand, req.body.type, req.body.model, req.body.transmission, req.body.num, req.body.year, req.body.mileage, req.body.rate, req.body.quantity, req.body.stats, req.body.carID];

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
		connection.query("SELECT transID, contactNo, CONCAT(customer.firstName, ' ', customer.lastName) AS 'customerName', startDate, endDate, transStatus FROM transaction JOIN reservation ON transaction.resID = reservation.resID JOIN customer USING(custID) JOIN car USING(carID) WHERE spID='?'", req.session.userID, function(err, rows){
			if (err) {console.log(err); return;}

			rows.forEach(function(item){
				transactions.push({
					transID: item.transID,
					customerName: item.customerName,
					startDate: item.startDate,
					contactNo: item.contactNo,
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

		res.redirect('/show-reservation'); 
	});
});

app.post('/done', function(req, res){
	connection.query("UPDATE reservation SET resStatus = 'Done' WHERE resID = '" + req.body.resID + "'", function(err, rows){
		if (err) {console.log(err); return}

		res.redirect('/add-payment'); 
	});
});


app.get('/payment', function(req, res){
	if (req.session.username){		
		var payments = [];
		connection.query('SELECT reservation.resID, resStatus, payID, payDate, transStatus, tentativePaid, totalAmount, paidAmount, miscFee, contactNo, CONCAT(customer.firstName, " ", customer.lastName) AS customerName FROM paymentdetails JOIN transaction ON paymentdetails.transID = transaction.transID JOIN reservation ON transaction.resID = reservation.resID JOIN customer ON reservation.custID = customer.custID JOIN car ON reservation.carID = car.carID', function(err, rows1){
			if (err) {console.log(err); return}

			rows1.forEach(function(item){
				var balance = Number(item.totalAmount - item.tentativePaid);
				payments.push({
					resID: item.resID,
					payID: item.payID,
					payDate: item.payDate,
					totalAmount: item.totalAmount,
					tentativePaid: item.tentativePaid,
					contactNo: item.contactNo,
					paidAmount: item.paidAmount,
					balance: balance,
					miscFee: item.miscFee,
					customerName: item.customerName,
					payStatus: item.transStatus,
					resStatus: item.resStatus
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
		console.log(req.query);
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
			console.log('eyoow===========');
			console.log(req.query.resID);
			connection.query("SELECT transaction.transID, CONCAT(firstName, ' ', lastName) as customerName, rate, tentativePaid, reservation.resID, paymentdetails.payID, DAY(startDate) as startDate, DAY(endDate) as endDate FROM customer JOIN reservation ON reservation.custID = customer.custID JOIN car ON reservation.carID = car.carID JOIN transaction ON transaction.resID = reservation.resID JOIN paymentdetails ON transaction.transID = paymentdetails.transID WHERE reservation.resID ='" + req.query.resID + "'", function(err, row2){
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
						totalAmount = item.rate* Math.abs((item.endDate) - (item.startDate));
					} 
					console.log(totalAmount);
					var balance = Number(totalAmount - item.tentativePaid);
					console.log(balance);
					thingy = {
						transID: item.transID,
						customerName: item.customerName,
						tentativePaid: item.tentativePaid,
						balance: balance,
						totalAmount: totalAmount,
						resID: item.resID,
						payID: item.payID,
						payStatus: item.payStatus,
						resStatus: req.query.resStatus
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

		var payColumns = ['transID','tentativePaid', 'totalAmount'];
		var payValues = [results.insertId, req.body.tentativePaid, req.body.totalAmount];
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
	var total = Number(req.body.balance) + Number(req.body.miscFee);
	var payValues = [req.body.totalAmount, req.body.paidAmount, req.body.miscFee, req.body.balance, req.body.transID];
	console.log("asadsada ==============================")
	console.log(req.body.transID)
	console.log(req.body.paidAmount)
	console.log(total)
	connection.query('UPDATE paymentdetails SET totalAmount = ?, paidAmount = ?, miscFee = ?, balance = ? WHERE transID = ?', payValues, function(err, row1){
		if (err) {console.log(err); return}
		
		if(req.body.resStatus == "Ongoing" && total == req.body.paidAmount){
			connection.query('UPDATE transaction SET transStatus = ? WHERE transID = ?', ["Fully Paid", req.body.transID], function(err, row2){
				if (err) {console.log(err); return}
				
				connection.query('UPDATE reservation SET resStatus = ? WHERE resID = ?', ["Done", req.body.resID], function(err, row3){
					if (err) {console.log(err); return}
				
					res.redirect('/payment');
				})
			})
		}else{
			res.redirect('/payment');
		}
	});
});

app.post('/search-transaction-status', function(req, res){
	var status = [req.body.status];
	var transaction = [];

	connection.query(`SELECT transID, transStatus, contactNo, CONCAT(customer.firstName, ' ', customer.lastName) AS 'customerName', startDate, endDate FROM transaction JOIN reservation ON transaction.resID = reservation.resID JOIN customer USING(custID) JOIN car USING(carID) WHERE transStatus = ?`, status, function(err, rows1){
		if (err) {console.log(err); return}

		rows1.forEach(function(item){
			transaction.push({
				transID: item.transID,
				customerName: item.customerName,
				contactNo: item.contactNo,
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
});

app.post('/sort-car', function(req, res){
	var car = [req.body.car];
	var cars = [];

	if(req.body.order == "asc"){
		var sql = "SELECT * FROM car JOIN service_provider ON service_provider.spID = car.spID WHERE car.spID = '?' ORDER BY " + connection.escapeId(req.body.column);
		connection.query(sql, [req.session.userID], function(err, row){
			if (err) {console.log(err); return}

			console.log(sql);
			console.log(row);
			row.forEach(function(item){
				cars.push({
					brandCar: item.brandCar,
					typeCar: item.typeCar,
					modelCar: item.modelCar,
					mileage: item.mileage,
					transmission: item.transmission,
					rate: item.rate,
					yearCar: item.yearCar,
					numSeat: item.numSeat,
					plateNo: item.plateNo,
					carStatus: item.carStatus,
					carQuantity: item.carQuantity,
					statusQuantity: item.statusQuantity
				});
			});
			res.render('main', {serviceCars: cars});
		});
	}else{
		var sql = "SELECT * FROM car JOIN service_provider ON service_provider.spID = car.spID WHERE car.spID = '?' ORDER BY " + connection.escapeId(req.body.column);
		connection.query(sql, [req.session.userID], function(err, row){
			if (err) {console.log(err); return}

			row.forEach(function(item){
				cars.push({
					brandCar: item.brandCar,
					typeCar: item.typeCar,
					modelCar: item.modelCar,
					mileage: item.mileage,
					transmission: item.transmission,
					rate: item.rate,
					yearCar: item.yearCar,
					numSeat: item.numSeat,
					plateNo: item.plateNo,
					carStatus: item.carStatus,
					carQuantity: item.carQuantity,
					statusQuantity: item.statusQuantity
				});
			});
			res.render('main', {serviceCars: cars});
		});
	}
});

app.post('/search-car', function(req, res){
	var status = [req.body.status];
	var search = [];

	connection.query("SELECT * FROM car WHERE carStatus =? AND car.spID='?'", [status, req.session.userID], function(err, row){
		if (err) {console.log(err); return}

		row.forEach(function(item){
			search.push({
				brandCar: item.brandCar,
				typeCar: item.typeCar,
				modelCar: item.modelCar,
				mileage: item.mileage,
				transmission: item.transmission,
				rate: item.rate,
				yearCar: item.yearCar,
				numSeat: item.numSeat,
				plateNo: item.plateNo,
				carStatus: item.carStatus,
				carQuantity: item.carQuantity,
				statusQuantity: item.statusQuantity
			});
		});
		res.render('main', {serviceCars: search});
	});
});



















