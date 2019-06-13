# == Schema Information
#
# Table name: attendances
#
#  id          :bigint(8)        not null, primary key
#  employee_id :bigint(8)
#  end_time    :time
#  start_time  :time
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Attendance, type: :model do
  it { should belong_to(:employee) }
  it { should validate_presence_of(:employee_id) }
end
