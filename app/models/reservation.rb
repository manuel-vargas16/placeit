class Reservation < ApplicationRecord
  include AASM

  belongs_to :film
  validates :name, :email, :document, :phone, :date, presence: true


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
