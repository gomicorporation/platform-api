module Companies
  class WithCountryDecorator < DefaultDecorator
    data_keys_from_model :company, except: %i[created_at updated_at]
    data_key :countries, with: Countries::DefaultDecorator
  end
end
