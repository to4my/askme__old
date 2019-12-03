class Question < ActiveRecord::Base
  belongs_to :user

  validates :user, :text, presence: true
  validates :text, length: { maximum: 255 }

end