const db = require('./demo_db')
const router = require('express').Router()


router.post('/add_new_stock', async (req, res) => {
    try {
        var { email, symbol, bought_price, quantity } = req.body;

        const response = await db.query(`select * from holdings where email='${email}' and symbol='${symbol}'`)
        
        // console.log(response[0][quantity])

        if(response[0].length === 1)
        {
            const r = await db.query(`update holdings set quantity = quantity + ${quantity} where email='${email}' and symbol='${symbol}'`)
            return res.json({ status: true, message: "Updated old stock to the portfolio" })
        }

        var response1 = await db.query(`insert into holdings(email,symbol,bought_price,quantity) values('${email}','${symbol}',${bought_price},${quantity})`)

        return res.json({ status: true, message: "Added new stock to the portfolio" })
    } catch (error) {

    }
})

router.post('/get_holdings', async (req, res) => {

    try {
        const { email } = req.body

        const response = await db.query(`select * from holdings where email='${email}'`)
    } catch (error) {
        throw error
    }
})


router.post('/get_portfolio',async (req,res)=>{
    const {email} = req.body
    const response = await db.query(`select sum(quantity * bought_price) as portfolio from holdings where email='${email}'`)
    console.log(response[0])

    return res.json({status:true,message:"Your total portfolio is recieved"})
})

module.exports = router