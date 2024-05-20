const express = require('express');
const { findUser, insertUser } = require('../models/user.model');
const router = express.Router();

router.post('/signup', async (req, res) => {
    try {
        const existingUser = await findUser({ email: req.body.email });
        if (existingUser) {
            res.json({ message: 'Email is not available' });
        } else {
            const newUser = {
                email: req.body.email,
                password: req.body.password
            };
            const result = await insertUser(newUser);
            if (result.insertedCount === 1) {
                res.json(newUser);
            } else {
                res.status(500).json({ error: 'Failed to create user' });
            }
        }
    } catch (err) {
        console.log(err);
        res.status(500).json(err);
    }
});

router.post('/signin', async (req, res) => {
    try {
        const user = await findUser({ email: req.body.email, password: req.body.password });
        if (user) {
            res.json(user);
        } else {
            res.status(401).json({ error: 'Invalid email or password' });
        }
    } catch (err) {
        console.log(err);
        res.status(500).json(err);
    }
});

module.exports = router;
