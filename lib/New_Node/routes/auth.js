const User = require("../models/user");
const auth = require("../models/authentication")
const express = require("express");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const bodyparser=require("body-parser");
const authRouter = express.Router();
const app = express();
app.use(bodyparser.urlencoded({extended:false}));
app.use(bodyparser.json());

authRouter.post("/api/signup", async (req, res) => {
  try {  
    //   const checkemail = req.body.email;
    //   console.log(checkemail);
      const {name, email, password}=req.body;
      const extuseremail = await User.findOne({email});
      const extusername = await User.findOne({name});
      if(extuseremail){
        return res.status(400).json({message: "Email already Exists"});
      } 
      else if(extusername){
        return res.status(400).json({message: "USernamealready Exists"});
      } 
      else{
        const hashedpassowrd = await bcryptjs.hash(password,8);
      const newuser = new User({
        name: req.body.name,
        email: req.body.email,
        password: hashedpassowrd
      })
      await newuser.save();
      res.json("new node added");}
  } catch (e) {
      res.status(500).json({ error: e.message });
  }
});


authRouter.post("/api/signin",async function(req,res){
  try{
    const { name, password}=req.body;
    const extuser = await User.findOne({name});
    if(!extuser){
      return res.status(400).json({message: "Username not exists"});
    } 

    const ismatch = await bcryptjs.compare(password,extuser.password);
    if(!ismatch){
      return res.status(400).json({message: "Incorrect Password"});
    }

    const token = jwt.sign({id: extuser._id},"passwordkey");
    res.json({token,...extuser._doc});
  }
  catch(e){
    res.status(500).json({error: e.message});
  }
})

authRouter.post("/tokenIsValid",async (req,res)=>{
  try{
    const token = req.header("x-auth-token");
    if(!token){
        return res.status(401).json(false);
    }

    const verified = jwt.verify(token,"passwordkey");
        if(!verified){
            return res.status(401).json(false);
        }

        const user = await User.findById(verified.id);
        if(!user) return res.json(false);
        
        res.json(true);
  }
  catch(e){
    res.status(500).json({error: e.message});
  }
})

authRouter.get("/", auth, async (req,res) => {
  const user = await User.findById(req.user);
  res.json({...user._doc, token: req.token});
});

// authRouter.post("api/delete",async function(req,res){
//     try{

//     }
// })

module.exports = authRouter;