module MerchantsHelper

  def link_to_take_merchant(player)
    action_label = 'play merchant card'
    image_file_name = 'merchant_card.png'
    url = take_merchant_player_url(player)
    options = {:method => :put, :remote => true, :class => 'playMerchantCard'}
    link_to_action_partial_if(player.merchant.blank?, action_label, image_file_name, url, options)
  end

end
