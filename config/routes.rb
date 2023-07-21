Rails.application.routes.draw do
  root 'repositories#index'
  get 'repositories/issues', to: 'repositories#issues'
end
