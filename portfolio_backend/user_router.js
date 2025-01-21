const db = require('./demo_db')
const bcrypt = require('bcrypt')
const jwt = require('jsonwebtoken')
const router = require('express').Router()


router.post('/registeration', async (req, res) => {
    try {
        const { email, passkey, name } = req.body

        const isRegistered = await db.query(`select * from users where email = '${email}'`)

        if (isRegistered[0].length === 1) {
            return res.json({ status: false, message: "Already registered with this email" })
        }

        const encryptedPassword = await bcrypt.hash(passkey, 10)

        db.query(`insert into users(email,passkey,name) values('${email}','${encryptedPassword}','${name}')`).then(() => {
            return res.json({ status: true, message: "New user created successfully" })
        })
    } catch (err) {
        console.log(err);
    }
})


router.post('/login', async (req, res) => {
    try {
        const { email, passkey } = req.body

        const response = await db.query(`select passkey from users where email = '${email}'`)

        var jsonData = { email: email }

        var token = jwt.sign(jsonData, "12345", { expiresIn: '0.5h' })

        if (response[0].length === 1) {
            const isCorrectpassword = await bcrypt.compare(passkey, response[0][0]['passkey'])

            if (isCorrectpassword) {
                return res.json({ status: true, message: "User logged in successfully", token: token })
            }
            else {
                return res.json({ status: false, message: "Incorrect password" })
            }
        }
        else {
            return res.json({ status: false, message: "No such user exists" })
        }

    } catch (error) {
        console.log(error);
        return res.json({ status: false, err: error })
    }
})

module.exports = router