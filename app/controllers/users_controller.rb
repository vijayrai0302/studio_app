class UsersController < ApplicationController
  before_filter :set_user
def index
      if current_person.user.present?
        @users= User.all
      end
      respond_to do |format|
       format.html # index.html.erb
       format.json { render json: @users }
      end
  end
  def show
      @user = User.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @user }
      end
  end
  def new
     if person_signed_in? and current_person.user.present?
       @user = current_person.user
       redirect_to user_timeline_show_path(@user)
     else
     @user = User.new

       respond_to do |format|
         format.html # new.html.erb
         format.json { render json: @user }
       end
     end
  end
  def edit
     @user = User.find(params[:id])
  end
  def create
      @user = User.new(params[:user])
      @user.person = current_person
      respond_to do |format|
        if @user.save
          format.html { redirect_to @user, notice: 'User was successfully created.' }
          format.json { render json: @user, status: :created, location: @user }
        else
          format.html { render action: "new", errors: @user.errors }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
  end
  def update
      if @user= current_person.user
        @user = User.find(params[:id])
      end
      @user.person = current_person
      respond_to do |format|
        if @user.update_attributes(params[:user])
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
  end
  def destroy
      @user = User.find(params[:id])
      if @user == current_person.user
         @user.destroy

        respond_to do |format|
          format.html { redirect_to root }
          format.json { head :no_content }
        end
      end
  end
  protected
      def set_user
         @user = User.find(params[:id])
      end
end
