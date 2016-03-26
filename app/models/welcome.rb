class Welcome < ActiveRecord::Base
  validates_presence_of :name

  # Constant
  default_value_for :imgs, []
  default_value_for :view, 0
  default_value_for :viewhehe, 0
  default_value_for :love, 0

  #validations
  validates_length_of :name, maximum: 64, if: :name_changed?

  # Scopes
  scope :recommend, -> { where("recommend > 0") }
  scope :newapp, -> { order("created_at desc") }
end
