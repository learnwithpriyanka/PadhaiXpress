const express = require('express');
const WasteCollection = require('../models/wasteCollectionModel');

const router = express.Router();

// Health check
router.get('/health', (req, res) => {
  res.json({ status: 'ok', service: 'waste-collection' });
});

// Create a new waste collection request
router.post('/', async (req, res) => {
  try {
    const {
      userId,
      estimatedWeight,
      weightUnit,
      pickupAddress,
      contactPhone,
      preferredPickupDate,
      preferredPickupTime,
      wasteType,
      estimatedValue,
    } = req.body;

    if (!userId || !estimatedWeight || !pickupAddress || !contactPhone || !preferredPickupDate) {
      return res.status(400).json({ error: 'Missing required fields' });
    }

    const doc = await WasteCollection.create({
      userId,
      estimatedWeight,
      weightUnit,
      pickupAddress,
      contactPhone,
      preferredPickupDate,
      preferredPickupTime,
      wasteType,
      estimatedValue,
    });

    res.status(201).json(doc);
  } catch (err) {
    console.error('Failed to create waste collection:', err);
    res.status(500).json({ error: 'Failed to create waste collection request' });
  }
});

// Get all waste collection requests (basic listing)
router.get('/', async (_req, res) => {
  try {
    const items = await WasteCollection.find().sort({ createdAt: -1 });
    res.json(items);
  } catch (err) {
    console.error('Failed to fetch waste collections:', err);
    res.status(500).json({ error: 'Failed to fetch waste collection requests' });
  }
});

module.exports = router;