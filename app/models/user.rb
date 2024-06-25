class User < ApplicationRecord
  validate :avatar_type

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end

  private

  def avatar_type
    if !avatar.blob.content_type.in?(%('image/jpeg image/png image/gif'))
      avatar.purge
      errors.add(:avatar, 'はjpegまたはpngまたはgif形式でアップロードしてください')
    end
  end

end
