class TripsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip, only: %i[show edit update delete]

  def index
    @trips = current_user.trips
  end

  def show; end

  def new
    @trip = current_user.trips.build
  end

  def create
    @trip = current_user.trips.build(trip_params)

    respond_to do |format|
      if @trip.save
        format.html { redirect_to @trip }
        format.js   { }
      else
        format.html { render :new }
        format.js { render :new }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @trip.update(trip_params)
        format.html { redirect_to @trip }
        format.js   { }
      else
        format.html { render :edit }
        format.js { render :edit }
      end
    end
  end

  def destroy
    @trip.destroy
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end
end
