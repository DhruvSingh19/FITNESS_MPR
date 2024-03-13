const mongoose = require("mongoose");

const userschema = mongoose.Schema({
     name: {
         type : String,
         required : true,
         trim : true
     },
    email: {
        required : true,
        type : String,
        trim : true,
        // validate : {
        //     validator: (value) => {
        //         const regex = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        //         return value.match(regex);
        //     },
        //     message: "Please enter a valid email",
        // },
    },
    password: {
        type: String,
        required: true,
    }
});

module.exports = mongoose.model("User", userschema);

