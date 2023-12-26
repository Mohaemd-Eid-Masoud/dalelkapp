const router = require("express").Router();
const UserController = require('../controller/user.controller');
const uploading =require('../services/upload.service');

router.post("/register",UserController.register);
router.post("/login", UserController.login);
// router.post('/change-password/:token' , UserController.changePassword);
router.post("/edit",);
module.exports = router;