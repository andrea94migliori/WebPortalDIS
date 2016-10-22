  Rails.application.routes.draw do
    
    default_url_options :host => "localhost:3000"
    
    #StaticPages routes
    root    'static_pages#home'
    get     'normeAccessoRete'              => 'static_pages#normeAccessoRete'
    get     'privacyPolicy'                 => 'static_pages#privacyPolicy'

    #Employees routes
    get     'employees/new'
    get     'signup'                        => 'employees#new'
    get     'employees/confirm'             => 'employees#confirm'
    post    'employees/confirm'             => 'employees#confirm'
    get     'employees/email-confirmed'     => 'employees#email-confirmed'
    
    #Sessions routes
    get     'sessions/new'
    get     'login'                         => 'sessions#new'
    post    'login'                         => 'sessions#create'
    delete  'logout'                        => 'sessions#destroy'
    
    
    #It means: for each entry of employee table, do a get on :confirm_email
    resources :employees do
        member do
            get :confirm_email
        end
    end
    
    #Limitation to CRUD operations
    resources :indirizzimacs,   only: [:create, :destroy , :edit , :update]
    resources :visitors,        only: [:create, :destroy , :edit , :update]
    resources :visits,          only: [:create, :destroy , :edit , :update]

  end
