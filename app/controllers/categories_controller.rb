class CategoriesController < ApplicationController

  respond_to :json

  def index
    respond_with Category.all
    # respond_with Category.includes(:transactions).to_json(include: :transactions )
  end

  def show
    respond_with Category.find(params[:id])
  end

  def create
     respond_with Category.create(category_params)
  end

  def update
    category = Category.find(params[:id])
    respond_with category.update(category_params)
  end

  def destroy
    respond_with Category.destroy(params[:id])
  end

private

  def category_params
    allow = [:title]
    params.permit(allow)
  end

end
