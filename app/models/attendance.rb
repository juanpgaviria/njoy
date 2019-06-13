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

class Attendance < ApplicationRecord
  belongs_to :employee

  def self.create_attendance(employee)
    @attendance = employee.attendances.new(start_time: Time.now, end_time: nil)
    employee.active! if @attendance.save
  end
end
