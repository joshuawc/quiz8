Quiz8::Application.routes.draw do
  get "user/index"
  match "pages/login" => "pages#login", :via => [:get, :post]
  get "pages/check"
end
