class TasksController < ApplicationController
  PER = 10

def index
  #@tasks = Task.all
  @tasks = Task.page(params[:page]).per(PER)
end

def show
  #@task = Task.find(params[:id])
end

def new
  @task = Task.new
end

def create
   #@task = Task.new(task_params
   @task = current_user.tasks.build(task_params)
   @task.user_id = current_user.id


   if @task.save
     flash[:success] = 'タスクが投稿されました'
     redirect_to @task
   else
     flash.now[:danger] = 'タスクが投稿されませんでした'
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

def update
  @task = Task.find(params[:id])
  if @task.update(task_params)
    flash[:success] = 'タスクが編集されました'
    redirect_to @task
  else
    flash.now[:danger] = 'タスクが編集されませんでした'
    render :new
  end
end


def destroy
  @task = Task.find(params[:id])
  @task.destroy

  flash[:success] = 'タスクが削除されました'
  redirect_to tasks_path
end

private

def task_params
  params.require(:task).permit(:content )
end

end
