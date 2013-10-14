# -*- encoding : utf-8 -*-
Aloe::Application.routes.draw do
  root :to => 'home#index'
  resources :article_categories
  resources :articles
  resources :resources_categories
  resources :resources
  resources :forums
  resources :topics
  resources :books
  resources :theses
  namespace :admin do
    root :to => 'dashboard#index'
    match 'dashboard' => 'dashboard#index', :as => 'dashboard'
    resources :articles_categories
    resources :articles
    resources :posters
    resources :book_categories
    resources :books
    resources :resources_categories
    resources :resources
    resources :newsletters
    resources :seminars do
      
    end
    resources :forums
    resources :topics
    resources :theses
    resources :links
    resources :roles do
      resources :permissions
    end
    resources :administrators
    resources :data do
      collection do
        get 'migrate'
      end
    end
    match 'signin' => 'sessions#new', :as => 'signin', :via => [:get]
    match 'signin' => 'sessions#create', :as => 'signin', :via => [:post]
    match 'signout' => 'sessions#destroy', :as => 'signout'
    unless Rails.application.config.consider_all_requests_local
      match '*not_found', to: 'errors#error_404'
    end
  end
end
