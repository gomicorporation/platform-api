# = 데이터가 없을 경우를 대비해서 빈 인스턴스를 넣어줍니다
interest_tags = seller_info.interest_tags || InterestTag.new
store_info = seller_info.store_info || Sellers::StoreInfo.new
item_sold_papers = seller_info.item_sold_papers

json.seller_info do
  json.default_info seller_info
  json.commission_rate seller_info&.grade&.commission_rate
  json.interest_tags interest_tags
  json.item_sold_count item_sold_papers.paid.count
  json.store_info do
    json.default_info store_info
    if store_info.products
      json.products store_info.products do |product|
        json.product product

        if ENV['RAILS_ENV'] == 'development'
          json.thumbnail_url url_for(product.thumbnail)
        else
          json.thumbnail_url product.thumbnail.service_url
        end

        json.default_option_title product.default_option.name
        json.default_option_price product.default_option.retail_price
        json.is_selected Sellers::SelectedProduct.find_by(store_info: store_info, product: product).present?
      end 
    end
  end
  json.settlement_statements seller_info.settlement_statements
  json.item_sold_papers seller_info.item_sold_papers
end