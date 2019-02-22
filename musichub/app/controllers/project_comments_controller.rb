class ProjectCommentsController < ApplicationController
	before_action :authenticate_user!, only: [:create, :destroy]

  def create
  	@project = Project.find(params[:project_id]) # finds the project with the associated project_id
  	@project_comment = @project.project_comments.create(comment_params) # creates the comment on the project passing in params
  	@project_comment.user_id = current_user.id if current_user # assigns logged in user's ID to comment
  	@project_comment.save!

  	redirect_to project_path(@project)

  end

  def destroy
  	@project = Project.find(params[:project_id])
  	@project_comment = @project.project_comments.find(params[:id])
  	@project_comment.destroy
  	redirect_to project_path(@project)
  end

  private

  def comment_params
  	params.require(:project_comment).permit(:name, :response)
  end
end
