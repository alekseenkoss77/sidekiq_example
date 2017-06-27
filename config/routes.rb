require 'sidekiq/web'

Rails.application.routes.draw do
  Sidekiq::Web.use Rack::Auth::Basic do |login, pass|
    params = Rails.application.secrets[:sidekiq].with_indifferent_access
    sidekiq_user = ::Digest::SHA256.hexdigest(params[:username])
    sidekiq_pass = ::Digest::SHA256.hexdigest(params[:password])

    login_hash = ::Digest::SHA256.hexdigest(login)
    pass_hash = ::Digest::SHA256.hexdigest(pass)

    ActiveSupport::SecurityUtils.secure_compare(login_hash, sidekiq_user) &
      ActiveSupport::SecurityUtils.secure_compare(pass_hash, sidekiq_pass)
  end

  mount Sidekiq::Web => '/sidekiq'

  resources :cities, only: [:create]
end
