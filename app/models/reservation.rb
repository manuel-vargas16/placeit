class Reservation < ApplicationRecord
  include AASM

  belongs_to :film
  validates :name, :email, :document, :phone, :date, presence: true
  validate :limit_reservations_by_film?


  aasm column: "status", skip_validation_on_save: true do
    state :active, initial: true
    state :inactive

    event :disable do 
      transitions from: :active, to: :inactive
    end
    event :enable do
      transitions from: :inactive, to: :active
    end
  end

  def limit_reservations_by_film? 
    count_reservation_film = Reservation.where(film_id: self.film_id, date: Date.today).count
    errors.add(:message, "Ya estan ocupados todos los asientos para la película #{self.film.name} para el día #{self.date}") if count_reservation_film >= 10 
  end

  def self.by_dates(start_date, end_date)
    where("(films.start_date >= ? AND films.end_date <= ?) AND (films.start_date >= ? AND films.end_date <= ?) ", start_date, start_date, end_date, end_date)
  end

  def details 
    {
      id: id,
      film: film.name,
      name: name,
      email: email, 
      document: document,
      phone: phone,
      date: date,
      status: status
    }
  end
end
