const app = require('express')()
const userRouter = require('./user_router')
const bodyParser = require('body-parser')

app.use(bodyParser.json())
app.use('/',userRouter)

module.exports = app