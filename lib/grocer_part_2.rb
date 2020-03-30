require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  updated_cart = []
  index = 0
  # iterate each cart item
  while cart[index] do 
    cart_item = cart[index]
    coupon_item = find_item_by_name_in_collection(cart_item[:item], coupons)
    if coupon_item
      if cart_item[:count] >= coupon_item[:num]
        cart_item[:count] -= coupon_item[:num]
        updated_cart << cart_item
        updated_cart << {
          :item => "#{coupon_item[:item]} W/COUPON",
          :price => (coupon_item[:cost] / coupon_item[:num]),
          :clearance => cart_item[:clearance],
          :count => coupon_item[:num]
        }        
      end
    else
      updated_cart << cart_item
    end
    index += 1 
  end
  updated_cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  updated_cart = []
  index = 0
  while cart[index] do 
    cart_item = cart[index]
    if cart_item[:clearance] == true
      cart_item[:price] -= (cart_item[:price] * 0.2)
    end
    updated_cart << cart_item
    index += 1
  end
  updated_cart
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
  index = 0
  while final_cart[index] do 
    total += final_cart[index][:price] * final_cart[index][:count]
    index += 1 
  end
  if total > 100 
    total -= (0.1 * total)
  end
  total
end
