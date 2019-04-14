class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  def index
    @users = User.all
  end

  def follow
    @user = User.find(params[:id])
    current_user.follow(@user)
    redirect_to action: 'show'
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.stop_following(@user)
    redirect_to action: 'show'

  end

  def followers
    @user = User.find(params[:id])
  end

  def following
    @user = User.find(params[:id])
  end

  def search
    @users = User.search(params[:search_param])
    if params[:search].blank?
      redirect_to(my_friends_path, alert: "Empty field!") and return
    else
      @parameter = params[:search].downcase
      @users = User.all.where("lower(name) LIKE :search", search: "%#{@parameter}%")
      render "users/my_friends"
    end
  end




end
