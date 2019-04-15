# == Schema Information
#
# Table name: employees
#
#  id             :bigint(8)        not null, primary key
#  names          :string(100)
#  last_names     :string(100)
#  address        :string
#  state          :string
#  city           :string
#  identification :string
#  phone          :string(100)
#  email          :string(100)
#  birthday       :date
#  start_date     :date
#  password       :binary
#  company_id     :bigint(8)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Employee < ApplicationRecord
  belongs_to :company

  validates :last_names, :names, :phone, :identification, presence: true
  validates :password, presence: true, uniqueness: { scope: :company_id }

  before_validation :encrypt_password

  def encrypt_password
    self.password = Digest::SHA256.digest password if password
  end
end
