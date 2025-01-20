const app = require('./app')
const finnhub = require('finnhub');
const axios = require('axios')
// 4N6BPUXAOX4VKZTQ

axios.get('https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&apikey=4N6BPUXAOX4VKZTQ',(err,res,data)=>{
    if(err)
    {
        console.log(err);
    }
    else
    {
        console.log(data);
    }
})


const api_key = finnhub.ApiClient.instance.authentications['api_key'];
api_key.apiKey = "cu50gl1r01qna2roenrgcu50gl1r01qna2roens0"
const finnhubClient = new finnhub.DefaultApi()


app.get('/', (req, res) => {
    res.json({ success: true, body: "hello how are you" })
})


app.listen(5000, () => {
    console.log("Listening to port 5000....");
})