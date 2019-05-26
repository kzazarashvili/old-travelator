module Admin
  class UsersController < BaseController
    before_action :set_user, only: %i[show edit update]

    SEARCH_ATTRIBUTES = [
      { name: 'users.id', method: :exact, type: :integer },
      { name: 'users.name', method: :like },
      { name: 'users.email', method: :like }
    ]


    def index
      @users = search(User.all_except(current_user))
    end

    def show; end

    def edit; end

    def update
      if @user.update(user_params)
        redirect_to [:admin, @user]
      else
        reder :edit
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:admin)
    end
  end
end
