class TripsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip, only: %i[show edit update destroy]

  def index
    @trips = current_user.trips.order(id: :desc)
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
    redirect_to trips_path
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(:started_at, :ended_at)
  end
end
