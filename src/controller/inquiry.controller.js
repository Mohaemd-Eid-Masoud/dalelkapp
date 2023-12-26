const inquiry = require('../models/inquiry');
exports.sendFeedback = async (req,res) =>{
    try{
    const body=req.body;
    const createinquiry = await new inquiry(body); 
    await createinquiry.save();
    res.status(201).json({message:"inquiry has been sent"});
    }
    catch(e){
        console.log(e);
    }
}