class V1::FilmsController < ApplicationController
  before_action :valid_dates?, only: :index
  
  # Autor: Manuel Vargas
  #
  # Fecha creacion: 2019-11-23
  #
  # Autor actualizacion: 
  #
  # Fecha actualizacion: 
  #
  # Metodo: GET - Lista las películas
  #
  # Parámetros: start_date, end_date
  #
  # URL: /v1/films.json
  #
  # Resultado: Listado de películas completo 
  #
  def index
    films =  @valid_dates ? Film.by_dates(params[:start_date], params[:end_date]) : Film.all

    render json: { films: films.collect(&:details), error: false }, status: :ok
  end

  # Autor: Manuel Vargas
  #
  # Fecha creacion: 2019-11-23
  #
  # Autor actualizacion: 
  #
  # Fecha actualizacion: 
  #
  # Metodo: POST - Crear una película
  #
  # Parámetros: name, description, url_film, start_date, end_date
  #
  # URL: /v1/films.json
  #
  # Resultado: Crea una película
  #
  def create
    if film = Film.create(film_params)
      render json: { film: film, error: false }, status: :ok
    else
      render json: { errors: film.errors.full_messages.to_sentence, error: true }, status: :unprocessable_entity
    end
  end

  private 

  # Autor: Manuel Vargas
  #
  # Fecha creacion: 2019-11-23
  #
  # Metodo: POST - Crear una película
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
  def film_params
    params.require(:film).permit(:name, :description, :url_film, :start_date, :end_date)
  end

end