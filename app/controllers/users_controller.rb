class UsersController < ApplicationController
  before_action :current_user, only: [:edit, :update, :destroy]
  def show
     @user = User.find(params[:id])
     @books = @user.books
     @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user==current_user
      render :edit
    else
      redirect_to user_path(current_user)
    end
  
    
  end

  def index
    @book = Book.new
    @books = Book.all
    @users = User.all
    @user = current_user
  end

  def update
    #ユーザーの取得
    @user = User.find(params[:id])
    #ユーザーのアップデート
    if @user.update(user_params)
    #ユーザーの詳細ページへのパス 
    flash[:notice]="you have updated user successfully."
    redirect_to user_path(@user)
    else
        # @books =Book.all
        render action: :edit
    end
  end
   private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end

end
