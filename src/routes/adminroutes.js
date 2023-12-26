const router = require("express").Router();
const admin = require('../controller/adminController');
router.post("/addContent",admin.addContent);
router.post("/editContent",admin.editContent);
router.get("/getContent",admin.getallcontent);
router.post("/check",admin.checkoutsteps);
module.exports = router;