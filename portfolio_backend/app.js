const app = require('express')()
const userRouter = require('./user_router')
const bodyParser = require('body-parser')
const holdingsRouter = require('./holdings_router')

app.use(bodyParser.json())
app.use('/',userRouter)
app.use('/',holdingsRouter)

module.exports = app