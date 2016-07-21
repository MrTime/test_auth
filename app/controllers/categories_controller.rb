class CategoriesController < ApplicationController
  def index
    @categories = Category.roots
  end
end
