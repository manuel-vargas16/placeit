class ApplicationController < ActionController::API
  # Autor: Manuel Vargas
  #
  # Fecha creacion: 2019-11-23
  #
  # Metodo: POST - Crear una película
  def valid_dates?
    @valid_dates = false
    if !params[:start_date].blank? && !params[:end_date].blank?
      if params[:start_date].to_date > params[:end_date].to_date
        render json: {message: 'La fecha de inicio debe ser menor a la fecha fin' , error: true}, status: :unprocessable_entity
        return 
      else 
        @valid_dates = true
      end
    end
  end
end
