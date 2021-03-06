class BooksController < ApplicationController

  before_action :categories, only: [:show, :index]
  before_action :new_order_item, only: [:show, :home]
  before_action :new_rating, only: :show
  before_action :set_wish_list, only: :show

  def index
    if params[:category_id]
      @books = Book.where(category_id: params[:category_id]).page(params[:page])
      @current_category = current_category params[:category_id]
    elsif params[:search]
      @books = Book.search(params[:search]).page(params[:page])
    else
      @books = Book.all.page(params[:page])
    end
  end

  def home
    @books = Book.best_sellers
  end

  def show
    @book = Book.find(params[:id])
  end

  private

    def set_wish_list
      @wish_list = current_or_guest_user.wish_list
    end
    def categories
      @categories = Category.all
    end

    def current_category id
      Category.find(id)
    end

    def new_order_item
      @order_item = OrderItem.new
    end

    def new_rating
      @rating = Rating.new
    end
end
