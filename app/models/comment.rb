class Comment < ApplicationRecord
  belongs_to :message, dependent: :destroy
  belongs_to :user, dependent: :destroy
end
