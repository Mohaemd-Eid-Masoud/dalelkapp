const db = require("../config/db");
const mongoose = require('mongoose');

const { Schema } = mongoose;
const feedbackschema = new Schema ({
    feedback:  {
        type: String,
        required : true
    },
    user_id:
         {type:Schema.Types.ObjectId, ref:'user'},
},{timestamps:true}
);
    feedBack = db.model("feedback",feedbackschema);
    module.exports = feedBack;