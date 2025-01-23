const db = require('./demo_db')
const router = require('express').Router()


router.post('/add_stock', async (req, res) => {
    try {
        var { email, name, price, quantity } = req.body;
        await db.query(`insert into holdings(email,name,date,action,price,quantity) values('${email}','${name}',current_date(),'buy',${price},${quantity})`)

        return res.json({ status: true, message: "Added new stock to the portfolio" })
    } catch (error) {
        return res.json({ status: false, message: error })
    }
})


router.post('/get_holdings', async (req, res) => {
    try {
        const { email } = req.body

        const response = await db.query(`select * from holdings where email='${email}'`)
        // console.log(response[0]);

        return res.json({ status: true, data: response[0], })
    } catch (error) {
        throw error
    }
})


router.post('/add_stocks', async (req, res) => {
    var { email, symbol, bought_price, quantity } = req.body;

    const response = await db.query(`select * from holdings where email='${email}' and symbol='${symbol}'`)

    if (response[0].length === 1) {
        const r = await db.query(`update holdings set quantity = quantity + ${quantity} where email='${email}' and symbol='${symbol}'`)
        return res.json({ status: true, message: "Updated old stock to the portfolio" })
    }

})


router.post('/delete_stocks')


router.post('/get_portfolio', async (req, res) => {
    const { email } = req.body
    const response = await db.query(`select sum(quantity * price) as portfolio from holdings where email='${email}'`)
    console.log(response[0])

    return res.json({ status: true, message: "Your total portfolio is recieved" })
})

module.exports = router