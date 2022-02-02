class CommentsController < ApplicationController
  #  def index
  #    @task = CourierTask.find(params[:courier_task_id])
  #    @comments = @task.comments
  #  end
  before_filter :require_owner, :only => [:edit, :update, :destroy]

  def update
    if @comment.update_attributes(params[:comment])
      flash[:notice] = 'Комментарий успешно обновлён.'
      redirect_to courier_task_url(params[:courier_task_id])
    else
      render :action => "edit"
    end
  end

  def edit
    @courier_task = CourierTask.find(params[:courier_task_id])
  end

  def create
    @courier_task = CourierTask.find(params[:courier_task_id])
    @comment = @courier_task.dup.comments.build(params[:comment])
    @comment.author = current_user.login
    if @comment.save
      redirect_to courier_task_url(@courier_task)
    else
      render "courier_tasks/show"
    end
  end

  def destroy
    @comment.destroy
    redirect_to courier_task_url(params[:courier_task_id])
  end

  private

  def require_owner
    @comment = Comment.find(params[:id])
    unless @comment.author == current_user.login
      flash[:error] = "чужой комментарий не доступен для правки"
      redirect_to courier_task_url(params[:courier_task_id])
      return false
    end
  end

end
