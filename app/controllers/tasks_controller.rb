class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  PER = 8

  def index
    @tasks = Task.all
    @tasks = Task.page(params[:page]).per(PER)
  end

  def show
  @task = Task.find_by(id: params[:id])
  # 変数@userを定義してください
  #@user = User.find_by(id: @task.user_id)
  end


def new
  @task = Task.new
end

#def create
   #@task = Task.new(task_params）
   #@task = current_user.tasks.build(task_params)
   #@task.user_id = current_user.id


   #if @task.save
     #flash[:success] = 'タスクが投稿されました'
     #edirect_to @task
     #redirect_to :tasks
   #else
     #flash.now[:danger] = 'タスクが投稿されませんでした'
     #render :new
   #end
 #end

 def create
   @task = current_user.tasks.build(task_params)
   if @task.save
     redirect_to task_path(@task), notice: t('common.flash.created')
   else
     flash.now[:alert] = @task.errors.full_messages.join('。')
     @task.errors.delete(:content)
     render :new
   end
 end

 def confirm
    #@task = Task.new(task_params)
    @task = current_user.tasks.build(task_params)
    #binding.pry
    render :new if @task.invalid?
  end

def edit
  @task = Task.find(params[:id])
end

#def update
  #@task = Task.find(params[:id])
  #if @task.update(task_params)
    #flash[:success] = 'タスクが編集されました'
    #redirect_to @task
  #else
    #flash.now[:danger] = 'タスクが編集されませんでした'
    #render :new
  #end
#end

def update
  if @task.update(task_params)
    redirect_to task_path(@task), notice: t('common.flash.updated')
  else
    flash.now[:alert] = @task.errors.full_messages.join('。')
    @task.errors.delete(:content)
    render :edit
  end
end


def destroy
  @task = Task.find(params[:id])
  @task.destroy

  flash[:success] = 'タスクが削除されました'
  redirect_to @task
end

private

def task_params
  params.require(:task).permit(:content)
  #params.require(:task).permit(:content)
end

def set_task
  @task = Task.find(params[:id])
end


end
