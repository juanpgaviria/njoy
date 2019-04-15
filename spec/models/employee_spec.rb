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

require 'rails_helper'

RSpec.describe Employee, type: :model do
  let!(:company) { create(:company) }
  let!(:employee) { create(:employee, company: company, password: '1234') }
  let!(:password_duplicated_params) { FactoryBot.attributes_for(:employee, password: '1234') }

  it { should belong_to(:company) }
  it { should validate_presence_of(:names) }
  it { should validate_presence_of(:last_names) }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:identification) }
  it { should validate_presence_of(:password) }

  it 'should show uniqueness error' do
    employees = company.employees.new(password_duplicated_params)
    expect(employees.valid?).to be_falsy
  end

  it 'should not show uniqueness error' do
    company = FactoryBot.create(:company)
    employee = FactoryBot.create(:employee, company: company, password: '1234')
    expect(employee.valid?).to be_truthy
  end

  it 'should hash the password' do
    expect(employee.password).to_not eq '1234'
  end
end
