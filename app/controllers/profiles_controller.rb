class ProfilesController < ApplicationController
  def show
    @profile = Profile.find(params[:id])
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      redirect_to @profile
    else
      render 'new', alert: @profile.errors.full_messages.join(', ')
    end
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update(profile_params)
      redirect_to @profile
    else
      render 'edit'
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :surname, :date_of_birth, :bio, :phone_number, :profile_picture)
  end
end
