# == Schema Information
#
# Table name: product_item_entities
#
#  id              :bigint           not null, primary key
#  expired_at      :datetime
#  leaved_at       :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  product_item_id :bigint           not null
#
# Indexes
#
#  index_product_item_entities_on_product_item_id  (product_item_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_item_id => product_items.id)
#
class ProductItemEntity < ApplicationRecord
  has_not_paper_trail

  belongs_to :product_item, counter_cache: :entities_count
  # belongs_to :product_option_bridge
  # has_many :options, class_name: 'ProductOption', through: :product_option_bridge

  has_many :cart_item_entities
  has_many :cart_items, through: :cart_item_entities

  scope :alive, -> { where(expired_at: nil) }
  scope :expired, -> { where.not(expired_at: nil) }
  scope :leaved, -> { where.not(leaved_at: nil) }
  scope :remain, -> { where(leaved_at: nil) }

  after_save :update_counter_cache
  after_destroy :update_counter_cache

  def expire!
    update_attribute(:expired_at, DateTime.now)
  end

  def disexpire!
    update_attribute(:expired_at, nil)
  end

  private

  def update_counter_cache
    product_item.send(:update_counter_cache)
  end
end
