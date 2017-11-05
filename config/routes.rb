Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root "welcome#index"
  root "quizzes#index"

  # get '/favorites', to: 'quiz_questions#show', as: 'favorites'

  namespace :admin do
    resources :categories
    resources :types
    resources :questions do
      collection do
        post :import
      end
    end
    resources :quizzes do
      member do
        post :hide_and_publish
      end
    end
  end

  resources :quizzes do
    resources :questions, :controller => 'quiz_questions' do
      member do
        post :create_detail
        post :favorite
      end
    end

    member do
      post :reset
    end
  end

end
