class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :email, uniqueness: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  
  has_many :articles
  has_many :comments
  has_many :likes

  has_many :user_publications
  has_many :publications, through: :user_publications


  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  def full_name
    firstname + " " + lastname
  end

end
