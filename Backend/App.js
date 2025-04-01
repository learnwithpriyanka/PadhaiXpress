const express= require("express");
const app=express();

app.get("/test",function(req,res){
    console.log("i am try to test");

    res.send("all good");
})
app.listen(3000,()=>{
console.log("port is 3000"
)
})