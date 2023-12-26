const router = require("express").Router();
const uploaded = require('../services/upload.service');
const cloudinary = require('../utils/cloudinary');
const Contact = require('../models/imagemodel');
const feedback = require('../controller/feedback.controller');
const fs = require('fs');
router.post("/upload", uploaded.single('image') , async (req, res) => {
try {
    const {path} =req.file;
    // upload image to cloudinary
    const result = await cloudinary.uploader.upload(path);
    // create new contact
   let contact = new Contact({
       name:req.body.name,
       image:result.secure_url,
       cloudinary_id:result.public_id
   });
    //save the contactg
        await contact.save();
    // removed the uploaded image from the uploads folder
       fs.unlinkSync(path);
       res.json(contact)
    } catch (error) {
       console.log(error);
  }});
  router.post("/feedback",feedback.sendFeedback);
  module.exports = router;