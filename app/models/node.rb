class Node < ApplicationRecord
  belongs_to :line, optional: true

  mount_uploader :avatar, AvatarUploader
end
