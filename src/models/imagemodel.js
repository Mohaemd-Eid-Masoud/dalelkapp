const mongoose = require('mongoose');
const db = require('../config/db');
const Schema = mongoose.Schema;
const contactSchema = new Schema({
    name: String,
    image: String,
    cloudinary_id: String,
    user_id: {type:Schema.Types.ObjectId, ref:'user'},
},);
module.exports = db.model("Contact",contactSchema)