# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]

  def index
    @categories = Category.order(:name)
  end

  def show; end

  def new
    @category = Category.new
  end

  def edit; end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to(categories_path)
    else
      render('new')
    end
  end

  def update
    if @category.update(category_params)
      redirect_to(categories_path)
    else
      render('edit')
    end
  end

  def delete; end

  def destroy
    @category.destroy
    redirect_to(categories_path)
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
