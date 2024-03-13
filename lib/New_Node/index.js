const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");

const PORT = 3000;
const app = express();

const bodyparser=require("body-parser");
app.use(bodyparser.urlencoded({extended:false}));
app.use(bodyparser.json());
const DB = ""//ENTER YOUR DB LINK HERE

app.use(authRouter);

 app.post("/api/getnodes",async function(req,res){
    
    const response =await {message: "NEW NODE ADDED"};
     res.json(response)
 })


app.use(express.json());
mongoose.connect(DB).then(()=>{
    console.log("Connected");
}).catch((e)=>{
    console.log(e)
});

app.listen(PORT, "0.0.0.0",()=>{
    // console.log(`${PORT}`);
});