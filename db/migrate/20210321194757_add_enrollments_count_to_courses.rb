class AddEnrollmentsCountToCourses < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :enrollments_count, :integer, default: 0
  end
end
