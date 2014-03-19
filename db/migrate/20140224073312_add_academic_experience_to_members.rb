# -*- encoding : utf-8 -*-
class AddAcademicExperienceToMembers < ActiveRecord::Migration
  def change
    add_column :members, :academic_experience, :text, :after => :public
  end
end
