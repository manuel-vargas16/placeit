class V1::ReservationsController < ApplicationController
  before_action :valid_dates?, only: :index

  # Autor: Manuel Vargas
  #
  # Fecha creacion: 2019-11-23
  #
  # Autor actualizacion: 
  #
  # Fecha actualizacion: 
  #
  # Metodo: GET - Listado de reservas
  #
  # Parámetros: start_date, end_date
  #
  # URL: /v1/reservation.json
  #
  # Resultado: Listado de reservas
  #
  def index
    reservations =  @valid_dates ? Reservation.by_dates(params[:start_date], params[:end_date]) : Reservation.all

    render json: { reservations: reservations.collect(&:details), error: false }, status: :ok
  end

   # Autor: Manuel Vargas
  #
  # Fecha creacion: 2019-11-23
  #
  # Autor actualizacion: 
  #
  # Fecha actualizacion: 
  #
  # Metodo: POST - Crear una reservación
  #
  # Parámetros: name, description, url_film, start_date, end_date
  #
  # URL: /v1/films.json
  #
  # Resultado: Crea una reservación
  #
  def create
    reservation = Reservation.new(reservation_params)

    if reservation.save
      render json: { reservation: reservation, error: false }, status: :ok
    else
      render json: { errors: reservation.errors.full_messages.to_sentence, error: true }, status: :unprocessable_entity
    end
  end

  # Autor: Manuel Vargas
  #
  # Fecha creacion: 2019-11-23
  #
  # Metodo: Valida si las fechas ingresadas son correctas
  # def valid_dates?
  #   @valid_dates = false
  #   if !params[:start_date].blank? && !params[:end_date].blank?
  #     if params[:start_date].to_date > params[:end_date].to_date
  #       render json: {message: 'La fecha de inicio debe ser menor a la fecha fin' , error: true}, status: :unprocessable_entity
  #       return 
  #     else 
  #       @valid_dates = true
  #     end
  #   end
  # end
  
  #PARÁMETROS FUERTES
  def reservation_params
    params.require(:reservation).permit(:name, :email, :document, :phone, :date, :film_id)
  end
end