class ReviewsController < ApplicationController
  before_action :require_login

  def create
    @product = Product.find(params[:product_id])
    review = Review.new(review_params)
      if review.save
        redirect_to "/products/#{@product.id}"
      else
        redirect_to "/signup"
      end
    end
      
  def review_params
    params.require(:review).permit(:product_id, :user_id, :rating, :description)
  end

  def destroy
    @review = Review.find(params[:review_id])
    @product = Product.find(params[:product_id])
    @review.destroy
    redirect_to "/products/#{@product.id}" , notice: 'Review deleted!'
  end

  private
 
  def require_login
    unless current_user
      redirect_to '/login', notice: 'You need to login to do that!'
    end
  end

end
