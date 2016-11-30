 class Album < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader # Tells rails to use this uploader for this model.
  validates :name, presence: true
  validates_presence_of :avatar
  has_many :images, dependent: :destroy
  belongs_to :user
end
