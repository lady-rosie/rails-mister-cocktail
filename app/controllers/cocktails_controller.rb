require 'open-uri'
class CocktailsController < ApplicationController
  def home
  end

  def index
    @cocktails = Cocktail.all
  end

  def show
    @cocktail = Cocktail.find(params[:id])
    @review = Review.new
    @dose = Dose.new
  end

  def new
    @cocktail = Cocktail.new
    @dose = Dose.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save && @cocktail.photo.attached?
      redirect_to cocktail_path(@cocktail)
    elsif @cocktail.save && !@cocktail.photo.attached?
      photo_url = "https://images.unsplash.com/photo-1536599424071-0b215a388ba7?ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80"
      file = URI.open(photo_url)
      @cocktail.photo.attach(io: file, filename: 'cocktail-photo.jpg', content_type: 'image/jpg')
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def destroy
    @cocktail = Cocktail.find(params[:id])
    @cocktail.destroy
    redirect_to cocktails_path
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo)
  end
end
