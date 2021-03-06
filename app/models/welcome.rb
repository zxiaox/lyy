class Welcome < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :logo

  # Constant
  default_value_for :imgs, []
  default_value_for :view, 0
  default_value_for :viewhehe, 0
  default_value_for :love, 0

  #validations
  validates_length_of :name, maximum: 64, if: :name_changed?

  # Scopes
  scope :approved, -> { where("approved > 0") }
  scope :recommend, -> { where("recommend > 0") }
  scope :newapp, -> { order("created_at desc") }
end
