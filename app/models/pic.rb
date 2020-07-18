# frozen_string_literal: true

class Pic < ApplicationRecord
  belongs_to :user
  has_one_attached :pic_image
  validate :acceptable_image

  def acceptable_image
    return unless pic_image.attached?

    errors.add(:pic_image, 'is too big') unless pic_image.byte_size <= 1.megabyte
    acceptable_types = %w[image/jpeg image/png]
    errors.add(:pic_image, 'must be a JPEG or PNG') unless acceptable_types.include?(pic_image.content_type)
  end
end
