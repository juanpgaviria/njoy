# == Schema Information
#
# Table name: suppliers
#
#  id             :bigint(8)        not null, primary key
#  name           :string
#  address        :string
#  city           :string
#  phone          :string
#  identification :string
#  contact_name   :string
#  company_id     :bigint(8)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Supplier < ApplicationRecord
  has_many :products, dependent: :destroy
  belongs_to :company

  validates :name, :address, :city, :identification, :contact_name, :phone, presence: true
end
