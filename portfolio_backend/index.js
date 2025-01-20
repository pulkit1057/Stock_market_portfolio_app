const app = require('./app')
const finnhub = require('finnhub');
const axios = require('axios')
const api_finnhub = require('./config')


const api_key = finnhub.ApiClient.instance.authentications['api_key'];
api_key.apiKey = api_finnhub
const finnhubClient = new finnhub.DefaultApi()


app.get('/', (req, res) => {
    res.json({ success: true, body: "hello how are you" })
})


app.listen(5000, () => {
    console.log("Listening to port 5000....");
})