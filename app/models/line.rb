class Line < ApplicationRecord
  belongs_to :nation, optional: true
end
