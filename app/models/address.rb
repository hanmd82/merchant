class Address < ActiveRecord::Base
  validates :line1, :city, :state, :zip, :user_id, presence: true
  validates :zip, length: { maximum: 5 }, 
                  numericality: { only_integer: true }
  validates :state, length: { maximum: 2 }, 
                   format: { with: /\A[KLRZ]|C[AOT]|D[CE]|FL|GA|HI|I[ADLN]|K[SY]|LA|M[ADEINOST]|N[CDEHJMVY]|O[HKR]|P[AR]|RI|S[CD]|T[NX]|UT|V[AIT]|W[AIVY]\z/ }

  belongs_to :user
  has_many :orders

  def to_s
    [line1, line2, city, state, zip].compact.join(", ")
  end
end
