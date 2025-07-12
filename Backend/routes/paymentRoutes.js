const express = require('express');
const Razorpay = require('razorpay');
const router = express.Router();
const authenticate = require('../middlewares/authenticate');

const razorpay = new Razorpay({
  key_id: process.env.RAZORPAY_KEY_ID,
  key_secret: process.env.RAZORPAY_KEY_SECRET
});

router.post('/razorpay-order', authenticate, async (req, res) => {
  try {
    const { amount } = req.body;
    console.log('Received body:', req.body);
    if (!amount || isNaN(amount)) {
      return res.status(400).json({ error: 'Invalid amount' });
    }
    const options = {
      amount: Math.round(amount * 100),
      currency: 'INR',
      receipt: `receipt_order_${Date.now()}`,
    };
    const order = await razorpay.orders.create(options);
    res.json(order);
  } catch (error) {
    console.error('Razorpay order error:', error);
    res.status(500).json({ error: 'Failed to create Razorpay order' });
  }
});

module.exports = router; 