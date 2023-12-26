const feedback = require('../models/feedback.model');
exports.sendFeedback = async (req,res) =>{
    try{
    const body=req.body;
    const createfeedback = await new feedback(body); 
    await createfeedback.save();
    res.status(201).json({message:"Feedback has been sent"});
    }
    catch(e){
        console.log(e);
    }
}