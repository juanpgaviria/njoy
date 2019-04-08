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
#  name                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_id                :bigint(8)
#

require 'rails_helper'

RSpec.describe Company, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:products) }
  it { should have_many(:categories) }
  it { should have_many(:suppliers) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:name) }
end
