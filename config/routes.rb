Rails.application.routes.draw do
  get 'repositories/issues', to: 'repositories#issues'
end
