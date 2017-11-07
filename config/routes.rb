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
    resources :complains
  end

  resources :quizzes do
    resources :questions, :controller => 'quiz_questions' do
      member do
        post :create_detail
        post :favorite
        post :feeling
        post :complain
      end
    end

    member do
      delete :reset
    end
  end

  resources :complains



end
