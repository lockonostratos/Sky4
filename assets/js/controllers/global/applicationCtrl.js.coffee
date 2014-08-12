Sky.controller 'applicationCtrl', ['$routeParams', '$location', '$scope', 'Common'
($routeParams, $location, $scope, Common) ->


#  Session.get('current_merchant_user').then (data) =>
#    Common.currentMerchantAccount = data
#    Common.currentMerchantAccount.avatar = '/assets/Son.jpg'
#    @Author = Common.currentMerchantAccount
  @Author =
    merchant:
      name: 'Huynh Chau'

  @Common = Common

  @colors = Sky.Style.Themes
  @showMenu = true
  @collapsedMode = false
  @name = 'Enterprise Dual Strategy'
  @currentUrl = $location.path()
  @navs = [
    active: true
    title: 'Tổng quan'
    url: '/'
    icon: 'fa fa-desktop'
  ,
    title: 'Bán hàng'
    url: '/sale'
    icon: 'fa fa-shopping-cart'
  ,
    title: 'Giao Hàng'
    url: '/sale/delivery'
    icon: 'fa fa-shopping-cart'
  ,
    title: 'Trả Hàng'
    url: '/sale/return'
    icon: 'fa fa-shopping-cart'
  ,
    title: 'Nhập kho'
    url: '/warehouse/import'
    icon: 'fa fa-download'
  ,
    title: 'Kiểm kho'
    url: '/warehouse/inventory'
    icon: 'fa fa-download'
  ,
    title: 'Tồn kho'
    url: '/warehouse/list'
    icon: 'fa fa-download'
  ]

  @toggleCollapse = -> @collapsedMode = !@collapsedMode

  $scope.$on '$routeChangeSuccess', (e, current, previous) =>
    @currentUrl = current.originalPath

  return
]