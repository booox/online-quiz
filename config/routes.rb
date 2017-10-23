Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root "welcome#index"
  root "quizzes#index"

  namespace :admin do
    resources :categories
    resources :types
    resources :questions
    resources :quizzes
  end

  resources :quizzes do
    # member do
    #   post :create_detail
    # end
    resources :questions, :controller => 'quiz_questions' do
      # post :create_detail
      member do
        post :create_detail
        post :favorite
      end
    end
  end

  # resources :questions do
  #   member do
  #     post :create_detail
  #   end
  # end

end
