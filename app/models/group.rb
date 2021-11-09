class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users, dependent: :destroy
  attachment :image

  def joined?(user)
    group_users.where(user_id: user.id).exists?
  end
end
