class ProfessionalAccountRequest < ApplicationRecord
  belongs_to :user


  has_one_attached :photo
  validates :first_cost, presence: true
  validates :follow_cost, presence: true
  validates :diploma, presence: true
  validates :username, presence: true, uniqueness: {case_sensitive: false}, length: {minimum:5, maximum:15}
  after_update :create_professional, if: :confirmed_accepted?

  private

  def confirmed_accepted?
    confirmed == true
  end

  def create_professional
    professional = Professional.new(
      username: username,
      branch: branch,
      adress: adress,
      diploma: diploma,
      first_cost: first_cost,
      follow_cost: follow_cost,
      startAttendingTime: startAttendingTime,
      endAttendingTime: endAttendingTime,
      user_id: user_id,
      confirmed: true
    )
  
    if photo.attached? # Verifica si hay un archivo adjunto
      professional.photo.attach(photo.blob) # Adjunta el archivo al nuevo registro de Professional
    end
  
    professional.save!
  end
end
