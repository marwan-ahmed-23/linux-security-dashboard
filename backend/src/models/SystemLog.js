const mongoose = require('mongoose');

const systemLogSchema = new mongoose.Schema({
  message: String,
  level: { type: String, default: 'info' },
  createdAt: { type: Date, default: Date.now }
});

module.exports = mongoose.model('SystemLog', systemLogSchema);
