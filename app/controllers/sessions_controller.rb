class SessionsController < ApplicationController
  def create
  	@user = User.find_or_create_by_auth(request.env["omniauth.auth"])
  	session[:user_id] = @user.id

    pending_order = get_pending_order

    if session[:order_id]
      # An order currently exists in session
      if pending_order
        # User has a previous pending order

        # (1) Move session order's order items into user's previous pending order
        # -> Check if session order's order item is in pending order
        # --> If order item is in pending order, add the quantity to the same order item in pending order
        # --> If order item is not in pending order, add order item & quantity to pending order
        @order = Order.find(session[:order_id])

        @order.order_items.each do |item|
          if (pending_order.order_items.exists?(product_id: item.product_id) == true)
            current_item = pending_order.order_items.find_by(product_id: item.product_id)
            current_item.quantity += item.quantity
            current_item.save
          else
            pending_order.order_items.create(product_id: item.product_id, quantity: item.quantity)
          end
        end

        # (2) Set session order to user's pending order
        session[:order_id] = pending_order.id
        # (3) Destroy the old session order
        @order.destroy
        
      else
        # User has no previous pending order, assign the order currently in the session to user
        @order = Order.find(session[:order_id])
        @order.update_attributes(user: @user)
      end

    else
      # No order currently in session
      if pending_order
        # User has a previous pending order
        @order = pending_order
      else
        # User has no previous pending order, create a new pending order
        @order = @user.orders.create(status: "unsubmitted")
      end
      session[:order_id] = @order.id
    end

  	redirect_to root_path, notice: "Logged in as #{@user.name}"
  end

  def destroy
    session[:user_id] = nil
    session[:order_id] = nil
    redirect_to root_path, notice: "Goodbye!"
  end


  private
    def get_pending_order
      last_order = @user.orders.last

      if last_order
        if last_order.status == "unsubmitted"
          return last_order
        end
      end
    end

end
