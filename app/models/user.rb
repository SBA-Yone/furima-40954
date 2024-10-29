class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :purchases

  validates :nickname, presence: true
  validates :password, presence: true
  validate :password_complexity
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'is invalid. Input full-width characters' }
  validates :first_name, presence: true,
                         format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'is invalid. Input full-width characters' }
  validates :last_name_kana, presence: true,
                             format: { with: /\A[ァ-ヶー]+\z/, message: 'is invalid. Input full-width katakana characters' }
  validates :first_name_kana, presence: true,
                              format: { with: /\A[ァ-ヶー]+\z/, message: 'is invalid. Input full-width katakana characters' }
  validates :birth_date, presence: true

  private

  def password_complexity
    if password.present?
      if password =~ /[^\x20-\x7E]/
        errors.add(:password, 'is invalid. Include both letters and numbers')
      elsif password !~ /\A(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!-~]).+\z/
        errors.add(:password, 'is invalid. Include both letters and numbers')
      end
    end
  end
end
