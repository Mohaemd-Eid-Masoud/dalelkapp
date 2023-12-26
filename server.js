const app = require("./app");
// const UserModel = require('./models/user.model')
const db = require('./src/config/db')
const dotenv = require ('dotenv');
dotenv.config({ path: './.env' });
const port = 8080;

app.get('/',(req,res)=>{
    res.send("Hello World")
})


app.listen(port,'192.168.1.109',()=>{
    console.log(`Server Listening on Port ${port}`);
})