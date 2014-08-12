class Common
  constructor: ->
    @currentMerchantAccount = {}
    @caption = 'caption'

Sky.service 'Common', -> new Common()