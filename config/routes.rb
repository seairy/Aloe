# -*- encoding : utf-8 -*-
Aloe::Application.routes.draw do
  root :to => 'home#index'
  resources :article_categories
  resources :articles
  resources :resource_categories
  resources :resources
  resources :forums
  resources :topics
  resources :books
  resources :seminars do
    resources :seminar_thesis_categories, as: :thesis_categories, path: 'thesis_categories'
    resources :seminar_articles, as: :articles, path: 'articles'
    resources :seminar_photographs, as: :photographs, path: 'photographs'
    resources :seminar_videos, as: :videos, path: 'videos'
  end
  resources :seminar_theses
  resources :theses
  get 'theses/year/:year', to: 'theses#index'
  resources :newsletters
  resources :links
  resources :publications do
    resources :publication_volumes, path: 'volumes'
  end
  resources :publication_volumes
  resources :publication_categories
  resources :continents
  resources :countries
  resource :member
  resources :individual_members
  resources :organization_members
  match 'signin', to: 'sessions#new', as: :signin, via: [:get]
  match 'signin', to: 'sessions#create', as: :signin, via: [:post]
  match 'signout', to: 'sessions#destroy', as: :signout
  scope 'about', as: 'about' do
    get 'introduction', to: 'about#introduction', as: :introduction
    get 'rule', to: 'about#rule', as: :rule
    get 'council', to: 'about#council', as: :council
    get 'distribution', to: 'about#distribution', as: :distribution
    get 'publication', to: 'about#publication', as: :publication
    get 'contact', to: 'about#contact', as: :contact
    get 'guide', to: 'about#guide', as: :guide
    get 'benefit', to: 'about#benefit', as: :benefit
    get 'application_form', to: 'about#application_form', as: :application_form
    get 'faq', to: 'about#faq', as: :faq
  end
  get ':controller/search', controller: /admin\/[^\/]+/, action: 'search', as: :admin_search
  namespace :admin do
    root :to => 'dashboard#index'
    get 'dashboard', to: 'dashboard#index', as: :dashboard
    resources :members do
      get 'duplicated', on: :collection
    end
    resources :individual_members do
      resources :recipients
      resources :payments
    end
    resources :organization_members do
      resources :recipients
      resources :payments
      resources :contacts
    end
    resources :contacts
    resources :recipients do
      get 'duplicated', on: :collection
      get 'clean_duplicated', on: :collection
    end
    resources :payments
    resources :orders
    resources :articles_categories
    resources :articles
    resources :posters
    resources :book_categories
    resources :books
    resources :resources_categories
    resources :resources
    resources :newsletters
    resources :seminars
    resources :forums
    resources :topics
    resources :theses
    resources :links
    resources :publications do
      resources :publication_volumes
    end
    resources :publication_volumes do
      resources :publication_categories
      resources :publication_articles
    end
    resources :publication_categories
    resources :publication_articles
    resources :emails do
      get 'send', on: :collection
      get 'clean', on: :collection
      get 'to_all', on: :new
      get 'to_permanent', on: :new
      get 'to_council_member', on: :new
    end
    resources :excels do
      collection do
        get 'all_members'
      end
    end
    resources :roles do
      resources :permissions
    end
    resources :administrators
    resources :notifications
    resources :tests do
      get 'clean_notifications', on: :collection
      get 'send_notifications', on: :collection
    end
    resources :data do
      get 'migrate', on: :collection
    end
    resources :assets do
      get 'recreate_version', on: :collection
    end
    resource :profile do
      get 'edit_password'
      post 'update_password'
    end
    match 'signin', to: 'sessions#new', as: :signin, via: [:get]
    match 'signin', to: 'sessions#create', as: :signin, via: [:post]
    match 'signout', to: 'sessions#destroy', as: :signout
    match 'errors/403', to: 'errors#error_403', as: :error_403
    get 'raise_an_exception', to: 'errors#raise_an_exception'
    resources :errors
    unless Rails.application.config.consider_all_requests_local
      match '*not_found', to: 'errors#error_404'
    end
  end
end
