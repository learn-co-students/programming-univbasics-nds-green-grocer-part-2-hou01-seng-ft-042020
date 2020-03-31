require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
   item_index = 0
  while cart[item_index] do
    item = cart[item_index]
    coupon_item = find_item_by_name_in_collection(item[:item], coupons)
    if coupon_item
      item[:count] -= coupon_item[:num]
      cart << {
        :item => "#{coupon_item[:item]} W/COUPON",
        :price => (coupon_item[:cost] / coupon_item[:num]),
        :clearance => item[:clearance],
        :count => coupon_item[:num]
      }
    end
    item_index += 1
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
   item_index = 0
  while item_index < cart.length do
    cart_item = cart[item_index]
    if cart_item[:clearance] == true
      cart_item[:price] -= (cart_item[:price] * 0.2)
    end
    item_index += 1
  end
  cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  consolidated_cart = consolidate_cart(cart)
  coupon_applied_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(coupon_applied_cart)
  total = 0
  item_index = 0
  while final_cart[item_index] do
    item = final_cart[item_index]
    total += item[:price] * item[:count]
    item_index += 1
  end
  if total >= 100
    total -= total * 0.1
  end
  total
end
