Sky.controller 'saleCtrl', ['focus', '$routeParams','$http', 'Common', 'Product', 'ProductSummary', 'Customer', 'MerchantAccount', 'TempOrder', 'TempOrderDetail', 'Order'
  (focus, $routeParams, $http, Common, Product, ProductSummary, Customer, MerchantAccount, TempOrder, TempOrderDetail, Order) ->
    Common.caption = 'bán hàng';

    @focusSearchBox = true;
    @transports = []; @transport={}; @transports.push obj for property, obj of Sky.Transports; @transport = @transports[0]
    @payments = []; @payment={}; @payments.push obj for property, obj of Sky.Payments; @payment = @payments[0]
    @delivery = {
      delivery_date: null
      delivery_address: null
      contact_name: null
      contact_phone: null
      transportation_fee: null
      comment: null
    }

    @seller = {}; @saleAccounts = []
    MerchantAccount.get('sellers').then (data) =>
      @saleAccounts = data
      foundCurrent = data.find {accoundId: Common.currentMerchantAccount.account.id}
      @seller = foundCurrent ? @saleAccounts[0]

    @buyer = {}; @customers = []
    Customer.query().then (data) => @customers = data; @buyer = data[0]

    @tabHistories = []; @currentTab = {}; @tabDetails = [];
    TempOrder.query().then (data) =>
      order.oldDiscountCash = order.discountCash for order in data
      @tabHistories = data
      if @tabHistories.length is 0
        @addTab()
      else
        @selectTab @tabHistories[0]

    @allProducts = []
    ProductSummary.query().then (data) =>
      for product in data
        product.caption = product.name
        product.caption += " (#{product.skullId})" if product.skullId
        @allProducts.push product

    # Bindable functions -------------------------------------------------------------------------------------->
    @syncSeller = (model) => @currentTab.sellerId = model.id; @currentTab.update()
    @syncBuyer = (model) => @currentTab.buyerId = model.id; @currentTab.update()
    @syncTransport = (model) => @currentTab.delivery = model.value; @currentTab.update()
    @syncPayment = (model) => @currentTab.paymentMethod = model.value; @currentTab.update()
    @syncDiscountOrder = => @syncOnChange @currentTab, 'discountCash'
    @syncBillDiscount = => @currentTab.update().then (data) => @reloadOrderOf @currentTab, data
    @syncDeposit = (item)=>
      @currentTab.deposit = @calculation_item_range_min_max @currentTab.deposit, 0
      @currentTab.currencyDebit = @currentTab.deposit - @currentTab.finalPrice
      if @currentTab.currencyDebit > 0
        @payment = @payments.find {value: 0}
      else
        @payment = @payments.find {value: 1}
      @currentTab.update() if item
    @checkSubmitFrom = =>
      if !@transport.value
        return false
      else
        for key, value of @delivery
          if !value then return true



    @syncOnChange = (obj, key, oldKey = null) =>
      oldKey ?= 'old' + key.charAt(0).toUpperCase() + key.slice(1)
      if obj[key] isnt obj[oldKey] then obj.update().then (data) => obj[oldKey] = obj[key]

    @orderFinished = =>
      if !@checkSubmitFrom()
        order = new Order()
        order.temp_order_id = @currentTab.id
        order.temp_delivery = @delivery
        order.save()

    @productFoundAction = (item) =>
      ProductSummary.get(item.id).then (data) =>
        @sellingProduct = data
        @sellingProduct.fullSearch = item.fullSearch
        @sellingDetail = @newSellingDetailFrom @sellingProduct

    @selectTab = (tab) =>
      @saveCurrentTabOfflineData()
      @seller = @saleAccounts.find { id: tab.sellerId }
      @buyer = @customers.find { id: tab.buyerId }
      @transport = @transports.find {value: tab.delivery}
      @payment = @payments.find {value: tab.paymentMethod}
      @searchText = tab.searchText
      @sellingProduct = tab.sellingProduct
      @sellingDetail = tab.sellingDetail
      @currentTab = tab
      @reloadTabDetails tab


    @addOrderDetail = =>
      if @sellingProduct and @sellingDetail.quality >= 1
        temp = angular.copy @sellingDetail
        temp.save().then (data) =>
          foundOrderDetail = @tabDetails.find {id: data.id}
          if foundOrderDetail then @reloadOrderDetailOf foundOrderDetail, data
          else @tabDetails.push data
          @searchText = ''
          focus 'searchBox'
          @updateSummaries()

    # Tab helpers ---------------------------------------------------------------------------------------------->
    @saveCurrentTabOfflineData = =>
      @currentTab.searchText = @searchText
      @currentTab.sellingProduct = @sellingProduct
      @currentTab.sellingDetail = @sellingDetail

    @reloadTabDetails = (tab) =>
      @tabDetails = []
      TempOrderDetail.query({temp_order_id: tab.id}).then (data) => @tabDetails = data

    @addTab = =>
      newTab = @newEmptyTab (Sky.Conversation.Call @buyer.name, @buyer.sex)
      newTab.save().then (data) => @tabHistories.push data; @selectTab data

    @deleteTab = (tab) =>
      foundTab = @tabHistories.find {id: tab.id}
      foundTab.delete() if foundTab
      currentIndex = @tabHistories.indexOf foundTab
      @tabHistories.removeAt currentIndex
      @currentTab = @tabHistories[currentIndex] ? @tabHistories[currentIndex - 1]
      @reloadTabDetails @currentTab
      @addTab() if @tabHistories.length is 0

    @newEmptyTab = (name, branch_id = null, warehouse_id = null, creator_id = null, seller_id =null, buyer_id = null) =>
      newTab = new TempOrder({name: name})
      newTab.branch_id = branch_id ? Common.currentMerchantAccount.branch.id
      newTab.warehouse_id = warehouse_id ? Common.currentMerchantAccount.warehouse.id
      newTab.creator_id = creator_id ? Common.currentMerchantAccount.account.id
      newTab.seller_id = seller_id ? @seller.id
      newTab.buyer_id = buyer_id ? @buyer.id
      newTab

    #OrderDetail helpers ------------------------------------------------------------------------------------>

    @newSellingDetailFrom = (source) =>
      result = new TempOrderDetail()
      result.tempOrderId = @currentTab.id
      result.productSummaryId = source.id
      result.name = source.name
      result.price = source.price
      result.productCode = source.productCode
      result.warehouseId = source.warehouseId
      result.skullId = source.skullId
      result.quality = 1
      result.discountCash = 0
      result.discountPercent = 0
      result.totalPrice = result.finalPrice  = source.price;
      result

#    @reloadTabDiscount= (tab)=>
#      @currentTab = tab
#      if @currentTab.discountCash == 0
#        @currentTab.discountPercent = 0
#      else
#        @currentTab.discountPercent = @currentTab.discountCash/@currentTab.totalPrice*100
#      @currentTab

    @updateSummaries = => TempOrder.get(@currentTab.id).then (data) =>  @reloadOrderOf @currentTab, data

    @reloadOrderDetailOf = (oldOrderDetail, newOrderDetail) =>
      oldOrderDetail.quality = newOrderDetail.quality
      oldOrderDetail.discountCash = newOrderDetail.discountCash
      oldOrderDetail.finalPrice = newOrderDetail.finalPrice

    @reloadOrderOf = (oldOrder, newOrder) =>
      oldOrder.totalPrice = newOrder.totalPrice
      oldOrder.discountCash = newOrder.discountCash
      if oldOrder.discountCash == 0
        oldOrder.discountPercent = 0
      else
        oldOrder.discountPercent = oldOrder.discountCash/oldOrder.totalPrice*100
      oldOrder.deposit = newOrder.deposit
      oldOrder.currencyDebit = newOrder.currencyDebit
      oldOrder.finalPrice = newOrder.finalPrice


    @removeSellingProduct = (item, index)=>
      item.delete().then (data) =>
        @tabDetails.splice index, 1
        @updateSummaries()

    @calculation_currentTab = (item, boolean)=>
      item.discountCash = @calculation_item_range_min_max(item.discountCash, 0, item.totalPrice)
      item.discountPercent = @calculation_item_range_min_max(item.discountPercent, 0, 100)
      if boolean
        item.discountPercent = (item.discountCash/item.totalPrice)*100
      else
        item.discountCash = (item.discountPercent*item.totalPrice)/100
      item.finalPrice = item.totalPrice - item.discountCash

    @calculation_tabDetails = (item, boolean)=>
      item.quality = @calculation_item_range_min_max(item.quality, 0, @calculation_max_sale_product())
      item.totalPrice =  item.quality * item.price
      item.discountCash = @calculation_item_range_min_max(item.discountCash, 0, item.totalPrice)
      item.discountPercent = @calculation_item_range_min_max(item.discountPercent, 0, 100)
      if item.quality > 0
        if boolean
          item.discountPercent = (item.discountCash/item.totalPrice)*100
        else
          item.discountCash = (item.discountPercent*item.totalPrice)/100
      else
        item.discountPercent = 0
        item.discountCash = 0
      item.finalPrice = item.totalPrice - item.discountCash

    @calculation_max_sale_product = ()=>
      temp = 0
      for product in @tabDetails
        if product.productSummaryId == @sellingProduct.id then temp += product.quality
      temp = @sellingProduct.quality - temp
      temp

    @calculation_item_range_min_max = (item, min, max)=>
      if item == undefined || item == 0 || item == null then item = min
      if item > max then item = max
      item

    @change_bill_discount = =>
      disabled = true
      if @currentTab.billDiscount == true then disabled = true  else disabled = false
      if @tabDetails[0] == undefined then disabled = true
      disabled


    return
]