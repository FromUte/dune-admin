Dune::Admin::Engine.routes.draw do
  root to: 'dashboard#index'
  resources :tags, except: [:show]
  resources :press_assets, except: [:show]
  resources :financials, only: [ :index ]
  resources :users, only: [ :index ]

  resources :channels, except: [:show] do
    member do
      put 'push_to_draft'
      put 'push_to_online'
    end

    resources :members, only: [:index, :new, :create, :destroy], controller: 'channels/members'
  end

  resources :projects, only: [ :index, :update, :destroy ] do
    member do
      put 'launch'
      put 'reject'
      put 'push_to_draft'
      put 'approve'
      get 'populate_contribution'
      post 'populate'
    end
  end

  resources :contributions, only: [ :index, :update ] do
    member do
      put 'confirm'
      put 'pendent'
      put 'change_reward'
      put 'refund'
      put 'hide'
      put 'cancel'
      put 'push_to_trash'
    end
  end

  namespace :reports do
    resources :contribution_reports, only: [ :index ]
    resources :funding_raised_per_project_reports, only: [ :index ]
    resources :statistics, only: [ :index ]
  end

  resources :contacts, only: [:index, :show]
end
