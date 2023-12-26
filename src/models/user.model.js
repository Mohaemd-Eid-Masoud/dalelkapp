const db = require('../config/db');
const bcrypt = require("bcrypt");
const mongoose = require('mongoose');
const { Schema } = mongoose;
const content = require('./admin.model');
const    step = content._id;
const userSchema = new Schema({
    firstname: {
    type:String,
    required:true
    },
    lastname: {
        type:String,
        required:true
        },
    phone: {
            type:String,
            required:true
            },
    gender: {
                type:String,
                required:true
                },
    birthdate:{
     type:Date,
     required : true
    },            
    email: {
        type: String,
        lowercase: true,
        required: [true, "userName can't be empty"],
        // @ts-ignore
        match: [
            /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/,
            "userName format is not correct",
        ],
        unique: true,
    },
    password: {
        type: String,
        required: [true, "password is required"],
    },
  
    step: {type:Schema.Types.ObjectId, ref:'admin',checked:Boolean},
    user_feedback:
    {type:Schema.Types.ObjectId, ref:'feedback'},
    user_inquiry:
    {type:Schema.Types.ObjectId, ref:'inquiry'},
    user_image:{type:Schema.Types.ObjectId, ref:'Contact'},
},{timestamps:true});


// used while encrypting user entered password
userSchema.pre("save",async function(){
    var user = this;
    if(!user.isModified("password")){
        return
    }
    try{
        const salt = await bcrypt.genSalt(10);
        const hash = await bcrypt.hash(user.password,salt);

        user.password = hash;
    }catch(err){
        throw err;
    }
});


//used while signIn decrypt
userSchema.methods.comparePassword = async function (candidatePassword) {
    try {
        console.log('----------------no password',this.password);
        // @ts-ignore
        const isMatch = await bcrypt.compare(candidatePassword, this.password);
        return isMatch;
    } catch (error) {
        throw error;
    }
};

const UserModel = db.model('user',userSchema);
module.exports = UserModel;