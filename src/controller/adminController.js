// const UserServices = require('../services/user.service');
var adminSchema = require('../models/admin.model');
const userchecked = require('../models/user.model');
class adminservice{
static async addContent (req,res) {
    try{
    const guide = req.body;
    console.log(guide) 
    const createcontent = await new adminSchema(guide);
    await createcontent.save();
    console.log(guide,'this is the data that we are sending to db')
        res.json({status:true,success:"Content added"})
    }
    catch(e){
                res.json({status:false,success:"Content is alredy exist"})
                console.error(`Error occured while adding content ${e}`)}
    }
static async editContent(req,res) {
    try{
    const guide = req.body;
    console.log(guide)
    const title = guide.title;
    const check = await adminSchema.findOne({title});
    if(check){
     await adminSchema.updateOne({title},guide);
    res.json({ status: true, success: 'Updated successfully' });    } 
    else{
    console.log('This title doesn\'t exist');
    } 
    }
    catch(err){
        console.log(err);
        res.json({status:false,success:"Can't Update"})

    }
}

static async getallcontent(req,res){
    try{
        const content= await adminSchema.find({});
        console.log(content)
        res.json({status:true,content:content});
}catch(e){
      console.log (e);
}
}
// static async addfeeback (req,res) {
//     try{
//     const guide = req.body;
//     const createcontent = new adminSchema({guide});
//     await createcontent.save();
//     }
//     //console.log(guide,'this is the data that we are sending to db')
//     catch(e){
//         console.log(e) ;
//     }
//  } 
//  static async addinquiry (req,res) {
//     try{
//     const guide = req.body;
//     const createcontent = new adminSchema(guide);
//     await createcontent.save();
//     }
//     //console.log(guide,'this is the data that we are sending to db')
//     catch(e){
//         throw e;
//     }
//  } 
 static presentsteps = async(req,res)=>{
   try{const title = req.title;
   const stepsdata =await adminSchema.findOne({title});
   res.json({status:true,steps:stepsdata});
  }catch(e){
      console.log (e);
  }
} 
 static  checkoutsteps = async(req,res) =>{
    try{
    const check = req.check;
    const user_id = req.user_id;
    const title = req.title;
    const checked = await userchecked({user_id,title,check});
    await checked.save();
    res.json({status:true,check:true});
    }
    catch(e){
        console.log(e);
    }
   }
}
module.exports = adminservice;