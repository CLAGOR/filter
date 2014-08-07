class ItemsController < ApplicationController

  def index 
    @items = Item.scoped

    @filter_by = params[:filter_by]
  end

end
