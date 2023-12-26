const express = require("express");
const bodyParser = require("body-parser")
const UserRoute = require("./src/routes/user.routes");
const TaskRoute = require("./src/routes/taskRoutes");
const Admin = require('./src/routes/adminroutes');
const app = express();

app.use(bodyParser.json())
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use("/",UserRoute,TaskRoute,Admin);
 

module.exports = app;