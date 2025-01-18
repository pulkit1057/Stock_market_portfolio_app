const db = require('./demo_db')

const router = require('express').Router()


router.post('/registeration', async (req, res) => {
    try {
        const { email, passkey ,name} = req.body

        const isRegistered = await db.query(`select * from users where email = '${email}'`)

        if(isRegistered[0].length === 1)
        {
            return res.json({success:false,message:"Already registered with this email"})
        }

        db.query(`insert into users(email,passkey,name) values('${email}','${passkey}','${name}')`).then(() => {
            return res.json({ success: true, message: "New user created successfully" })
        })
    } catch (err) {
        console.log(err);
    }
})


router.get('/login', async (req, res) => {
    try {
        const { email, passkey } = req.body

        const response = await db.query(`select * from users where email='${email}' and passkey='${passkey}'`)
        console.log(response);
        if (response[0].length === 1) {
            return res.json({ success: true, message: "User logged in successfully" })
        }
        else {
            return res.json({ success: false, message: "No such user exists or wrong password" })
        }
    } catch (error) {
        console.log(error);
        return res.json({ success: false, err: error })
    }
})

module.exports = router