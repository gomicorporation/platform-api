# == Schema Information
#
# Table name: sellers_selected_products
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  product_id    :bigint           not null
#  store_info_id :bigint           not null
#
# Indexes
#
#  index_sellers_selected_products_on_product_id     (product_id)
#  index_sellers_selected_products_on_store_info_id  (store_info_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (store_info_id => sellers_store_infos.id)
#
module Sellers
  class SelectedProduct < ApplicationRecord
    validates_uniqueness_of :product_id, scope: :store_info

    belongs_to :store_info, class_name: 'Sellers::StoreInfo'
    belongs_to :product

  end
end
