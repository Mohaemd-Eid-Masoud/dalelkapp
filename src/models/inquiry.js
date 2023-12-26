const db = require("../config/db");
const mongoose = require('mongoose');

const { Schema } = mongoose;
const inquirySchema = new Schema ({
    inquiry:  {
        type: String,
        required : true
    },
    user_id: {type:Schema.Types.ObjectId, ref:'user'},
},{timestamps:true}
);
    inquiry = db.model("inquiry",inquirySchema);
    module.exports = inquiry;