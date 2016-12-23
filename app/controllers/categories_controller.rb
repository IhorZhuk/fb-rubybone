class CategoriesController < ApplicationController
  before_filter :authorize
  respond_to :json

  def index
    respond_with current_user.categories.all
  end

  def show
    respond_with current_user.categories.find(params[:id])
  end

  def create
     respond_with Category.create(
       user: current_user,
       title: params[:title]
     )
  end

  def update
    category = current_user.categories.find(params[:id])
    respond_with category.update(category_params)
  end

  def destroy
    category = current_user.categories.find(params[:id])
    result = category.destroy

    if result
      respond_with result
    else
      respond_with category
    end
  end

private

  def category_params
    allow = [:title]
    params.permit(allow)
  end

end
