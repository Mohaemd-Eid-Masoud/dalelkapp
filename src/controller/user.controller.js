const UserServices = require('../services/user.service');
exports.register = async (req, res, next) => {
    try {
        console.log("---req body---", req.body);
        const userData = req.body;

        const duplicate = await UserServices.getUserByEmail(userData.email);
        if (duplicate) {
            throw new Error(`UserName ${email}, Already Registered`)
        }
        const response = await UserServices.registerUser(userData);

        res.json({ status: true, success: 'User registered successfully' });


    } catch (err) {
        console.log("---> err -->", err);
        next(err);
    }
}
exports.login = async (req, res, next) => {
        const userinfo = req.body;
        const email_admin = process.env.ADMIN_EMAIL;
        const password_admin = process.env.ADMIN_PASSWORD;
    try{    
        if (userinfo.email === email_admin && userinfo.password===password_admin){
            let tokenData;
            tokenData = { userinfo };
            const token = await UserServices.generateAccessToken(tokenData,"secret","1h")       
            console.log("login success");
            res.status(200).json({ status: true, success: "sendData", token: token ,isAdmin:true});
        }else {
        let user = await UserServices.checkUser(userinfo.email);
        if (!user) {
            throw new Error('User does not exist');
        }
        const isPasswordCorrect = await user.comparePassword(userinfo.password);
        if (isPasswordCorrect === false) {
            throw new Error(`Username or Password does not match`);
         }else{
          // Creating Token
        let tokenData;
        tokenData = { userinfo };
         token = await UserServices.generateAccessToken(tokenData,"secret","1h")
        res.status(200).json({ status: true, success: "sendData", token: token,isAdmin:false });
       } 
        }
    }catch (error) {
        console.log(error, 'err---->');
        next(error);
     }
    }
    //    exports.changePassword =  async (req, res) => {
    //     const changePass = req.params.token;
    //     const newPassword = req.body.password;
    //     try {
    //        // Find the user in the database based on the reset password token.
    //        const user = await User.findOne({ passchangeToken: changePass, passwordResetExpires: { $gt: Date.now() } });
    //        // If no user is found, send an error message.
    //        if (!user) {
    //          return res.status(404).send('Password reset token is invalid or has expired.');
    //        }
       
    //        // Hash the new password.
    //        const hashedPassword = await bcrypt.hash(newPassword, 10);
       
    //        // Update the user's password in the database.
    //        user.password = hashedPassword;
    //        user.passchangeToken = undefined;
    //        user.passwordResetExpires = undefined;
    //        await user.save();
       
    //        res.status(200).send('Password has been successfully reset.');
       
    //     } catch (error) {
    //        res.status(500).send(error.toString());
    //     }
    //    }
       