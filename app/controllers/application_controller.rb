class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def load_order
    @order = Order.find_or_initialize_by(id: session[:order_id], status: "unsubmitted")

    if @order.new_record?
      # @order.save!(validate: false)
      @order.save!
      session[:order_id] = @order.id
    end
  end

  # def current_admin?
  #   current_user.admin?
  # end
end
