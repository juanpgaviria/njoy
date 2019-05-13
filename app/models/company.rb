# == Schema Information
#
# Table name: companies
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  name                   :string(100)
#  phone                  :string(100)
#  identification         :string(100)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_id                :bigint(8)
#

class Company < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :suppliers, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :employees, dependent: :destroy
  has_many :boards, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable

  belongs_to :user
  validates :name, :phone, :identification, presence: true
  validates :email, presence: true, uniqueness: true
end
