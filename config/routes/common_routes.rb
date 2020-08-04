namespace :common, except: %i[new edit] do
  # === 관심사 태그
  #
  resources :interest_tags, controller: 'interest_tags' do
    get '/:scope', action: :index, on: :collection, as: :scope
  end
end
