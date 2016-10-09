class Nation < ApplicationRecord

  enum tag: { province: 1, city: 2, country: 3 }

  # associations
  belongs_to :parent, class_name: 'Nation', foreign_key: :parent_id
  has_many :children, class_name: 'Nation', foreign_key: :parent_id

  # methods
end
