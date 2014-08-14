mongoose = require 'mongoose'

merchantSchema = mongoose.Schema
  name: String
  phoneContact: String

module.exports = mongoose.model('Merchant', merchantSchema);