class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    if params[:end_year].present? or params[:start_year].present? or params[:title].present?
      it = Car.solr_search do
        fulltext(params[:title]) if params[:title].present?
        with :year, (params[:start_year]..params[:end_year]) if params[:start_year].present? and params[:end_year].present?
      end

      @cars = it.results
    else
      if params['admin']
        @cars = Car.unscoped
      else
        @cars = Car.all
      end
    end

    #if params[:start_year].present? and params[:end_year].present?
    #  @cars = @cars.by_year(params[:start_year], params[:end_year])
    #end
    #@cars = @cars.by_title(params[:title]) if params[:title].present?

    #@cars = @cars.select {|c| c.title.include?(params[:title]) } if params[:title]

    respond_with(@cars)
  end

  def show
    respond_with(@car)
  end

  def new
    @car = Car.new
    respond_with(@car)
  end

  def edit
  end

  def create
    @car = Car.new(car_params)
    @car.save
    HardJob.perform_later(@car.id)
    respond_with(@car)
  end

  def update
    @car.update(car_params)
    respond_with(@car)
  end

  def recovery
    car = Car.unscoped.find(params[:id])
    car.deleted_at = nil
    car.save
    respond_with(car)
  end

  def destroy
    @car.destroy
    respond_with(@car)
  end

  private
    def set_car
      if params[:admin]
        @car = Car.unscoped.find(params[:id])
      else
        @car = Car.find(params[:id])
      end
    end

    def car_params
      params.require(:car).permit(:title, :price)
    end
end
