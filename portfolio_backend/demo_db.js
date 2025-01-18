const mysql = require('mysql2/promise')
const pass = require('./config')


const connection = mysql.createPool({
    host:'localhost',
    user:'root',
    database:'portfolio',
    password:pass,
})


module.exports = connection