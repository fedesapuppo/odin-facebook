class ProfilesController < ApplicationController
  def show
    @profile = current_user.profile
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      redirect_to @profile
    else
      redirect_to @profile, alert: @profile.errors.full_messages.to_sentence
    end
  end

  def edit
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile
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
