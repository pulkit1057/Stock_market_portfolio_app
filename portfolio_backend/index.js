const app = require('./app')
const finnhub = require('finnhub');

const api_key = finnhub.ApiClient.instance.authentications['api_key'];
api_key.apiKey = "cu50gl1r01qna2roenrgcu50gl1r01qna2roens0" // Replace this
const finnhubClient = new finnhub.DefaultApi()


app.get('/',(req,res)=>{
    res.json({success:true,body:"hello how are you"})
})



app.listen(5000,()=>{
    console.log("Listening to port 5000....");
})