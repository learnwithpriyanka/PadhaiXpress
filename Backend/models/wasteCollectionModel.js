const mongoose = require('mongoose');

const wasteCollectionSchema = new mongoose.Schema({
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'UserData',
    required: true
  },
  estimatedWeight: {
    type: Number,
    required: true,
    min: 0.1
  },
  weightUnit: {
    type: String,
    enum: ['kg', 'lbs'],
    default: 'kg'
  },
  pickupAddress: {
    street: { type: String, required: true },
    city: { type: String, required: true },
    state: { type: String, required: true },
    zipCode: { type: String, required: true },
    country: { type: String, default: 'India' },
    coordinates: {
      lat: { type: Number },
      lng: { type: Number }
    }
  },
  contactPhone: {
    type: String,
    required: true
  },
  preferredPickupDate: {
    type: Date,
    required: true
  },
  preferredPickupTime: {
    type: String,
    enum: ['morning', 'afternoon', 'evening'],
    default: 'morning'
  },
  wasteType: {
    type: String,
    enum: ['newspaper', 'magazine', 'cardboard', 'mixed', 'other'],
    default: 'mixed'
  },
  estimatedValue: {
    type: Number,
    min: 0
  },
  status: {
    type: String,
    enum: ['pending', 'approved', 'scheduled', 'in-progress', 'completed', 'cancelled'],
    default: 'pending'
  },
  adminNotes: {
    type: String
  },
  scheduledPickupDate: {
    type: Date
  },
  collectorId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'UserData'
  },
  collectionRoute: {
    type: String
  },
  isNotified: {
    type: Boolean,
    default: false
  },
  createdAt: {
    type: Date,
    default: Date.now
  },
  updatedAt: {
    type: Date,
    default: Date.now
  }
});

// Update timestamp on save
wasteCollectionSchema.pre('save', function(next) {
  this.updatedAt = Date.now();
  next();
});

const WasteCollection = mongoose.model('WasteCollection', wasteCollectionSchema);

module.exports = WasteCollection;
