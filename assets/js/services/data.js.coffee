#Sky.factory 'Product', ($resource)-> $resource 'api/products/:id', {id: '@id'}, {update: {method: 'PUT'}}

#Sky.factory "Product", ($resource) ->
#  $resource "/api/products/:id", { id: "@id" },
#    'create': { method: 'POST' }
#    'index': { method: 'GET', isArray: true }
#    'show': { method: 'GET', isArray: false }
#    'update': { method: 'PUT' }
#    'destroy': { method: 'DELETE' }

Sky.factory 'Session', [ '$resource', ($resource) ->
  $resource 'api/sessions', {id: '@id'}, {update: {method: 'PUT'}}
]

Sky.factory 'Account', [ '$resource', ($resource) ->
  $resource 'api/orders', {id: '@id'}, {update: {method: 'PUT'}}
]

Sky.factory 'MerchantAccount', [ '$resource', ($resource) ->
  $resource 'api/merchant_accounts', {id: '@id'}, {update: {method: 'PUT'}}
]

Sky.factory 'Product', [ '$resource', ($resource) ->
  $resource 'api/products', {id: '@id'}, {update: {method: 'PUT'}}
]

Sky.factory 'ProductSummary', [ '$resource', ($resource) ->
  $resource 'api/product_summaries', {id: '@id'}, {update: {method: 'PUT'}}
]

Sky.factory 'Order', [ '$resource', ($resource) ->
  $resource 'api/orders', {id: '@id'}, {update: {method: 'PUT'}}
]

Sky.factory 'Customer', [ '$resource', ($resource) ->
  $resource 'api/customers', {id: '@id'}, {update: {method: 'PUT'}}
]

Sky.factory 'TempOrder', [ '$resource', ($resource) ->
  $resource 'api/temp_orders', {id: '@id'}, {update: {method: 'PUT'}}
]

Sky.factory 'TempOrderDetail', [ '$resource', ($resource) ->
  $resource 'api/temp_order_details', {id: '@id'}, {update: {method: 'PUT'}}
]

Sky.factory 'TempImport', [ '$resource', ($resource) ->
  $resource 'api/temp_imports', {id: '@id'}, {update: {method: 'PUT'}}
]

Sky.factory 'TempImportDetail', [ '$resource', ($resource) ->
  $resource 'api/temp_import_details', {id: '@id'}, {update: {method: 'PUT'}}
]

Sky.factory 'Delivery', [ '$resource', ($resource) ->
  $resource 'api/deliveries', {id: '@id'}, {update: {method: 'PUT'}}
]

Sky.factory 'Warehouse', [ '$resource', ($resource) ->
  $resource 'api/warehouses', {id: '@id'}, {update: {method: 'PUT'}}
]
