# encoding: utf-8
class AutocompleteController < ApplicationController
  before_filter :validate_address_params, :only => :address

  def location
    result = Location.where('dong LIKE ?', "%#{params[:term]}%").limit(20).map do |l|
      { :label => l.address, :value => l.id }
    end

    respond_to do |format|
      format.html
      format.json { render json: result }
    end
  end

  def validate_address_params
    if params[:lat].blank? or params[:lng].blank?
      render :nothing => true, :status => :bad_request
    end
  end

  def address
    location = Location.where("latitude is not null and longitude is not null")
        .order("sqrt(pow((latitude - 37.6354891), 2) + pow((longitude - 126.832017), 2))")
        .first

    respond_to do |format|
      format.json { render json: { :id => location.id, :address => location.address } }
    end
  end
end
