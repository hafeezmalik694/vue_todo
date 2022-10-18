class Api::UsersController < Api::BaseController
  skip_before_action :authenticate_request, only: [:create]
  before_action :get_user, only: [:update, :destroy, :show]
  def index
    users = User.all
    json_success_response('Listing all users', users)
  end

  def create
    user = User.new(user_params)
    if user.save
      json_success_response('User Successfully Created.', user.attributes.merge(profile_pic: url_for(user.profile_pic)))
    else
      json_error_response('Something Went Wrong.', user.errors.full_messages)
    end
  end

  def show
    json_success_response('User Detail', @user)
  end

  def update
    if @user.update(user_params)
      json_success_response('User Successfully Updated.', @user)
    else
      json_error_response('Something Went Wrong.', @user.errors.full_messages)
    end
  end

  def destroy
    if @user.destroy
      json_success_response('User Successfully Destroyed.', @user)
    else
      json_error_response('Something Went Wrong.', @user.errors.full_messages)
    end
  end

  def user_params
    params.permit(:name, :email, :password, :profile_pic)
  end

  def get_user
    @user = User.find_by_id(params[:id])
  end
end