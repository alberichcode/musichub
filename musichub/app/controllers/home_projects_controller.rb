class HomeProjectsController < ApplicationController
  def index
    if user_signed_in?
  		@teams = Team.where('id = ?', current_user.team_id)
  		@projects = Project.where('team_id = ?', current_user.team_id).order("created_at DESC")
  	end

    @activities = PublicActivity::Activity.order("created_at desc")

  end


end
