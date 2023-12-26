// const FlexApiBase = require("twilio/lib/rest/FlexApiBase");
const db = require("../config/db");
const mongoose = require('mongoose');

const { Schema } = mongoose;
var adminSchema = new Schema({
      title : {
        type : String,
        unique : true
      },
      description: {
        type : String,
        },
      content : {
        type : [String]
      },
      user_id: {type:Schema.Types.ObjectId, ref:'user'},
},{timestamps:true});
adminSchema = db.model('admin', adminSchema);
module.exports = adminSchema;