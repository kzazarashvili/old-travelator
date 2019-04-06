module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    before_action :set_user

    def facebook
      authenticate_from_omniauth(@user, provider: :facebook)
    end

    def google_oauth2
      authenticate_from_omniauth(@user, provider: :google)
    end

    private

    def authenticate_from_omniauth(user, params = {})
      if user.persisted?
        sign_in_and_redirect!(user, provider: params[:provider])
      else
        setup_session_and_redirect_back(provider: params[:provider])
      end
    end

    def sign_in_and_redirect!(user, params = {})
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: params[:provider]
      sign_in_and_redirect user, event: :authentication
    end

    def setup_session_and_redirect_back(params = {})
      session["devise.#{params[:provider]}_data"] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end

    def set_user
      @user = User.from_omniauth(request.env['omniauth.auth'])
    end
  end
end
