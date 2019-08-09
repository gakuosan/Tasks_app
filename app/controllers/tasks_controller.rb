class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  PER = 8

  #def index
    #@tasks = Task.all
    #@tasks = current_user.tasks

    #@tasks = Task.page(params[:page]).per(PER)
  #end
  #def index
  #@tasks = current_user.tasks
  #end

  def index
  @q = current_user.tasks.ransack(params[:q])
  @tasks = @q.result(distinct: true).page(params[:page])

  respond_to do |format|
    format.html
    format.csv { send_data @tasks.generate_csv, filename: "tasks-#{Time.zone.now.strftime('%Y%m%d%S')}.csv" } # --- ②
  end
 end

  def show
  @task = Task.find_by(id: params[:id])
  # 変数@userを定義してください
  #@user = User.find_by(id: @task.user_id)
  end


def new
  @task = Task.new
end

def create
   @task = current_user.tasks.build(task_params)
   #binding.pry
   if @task.save
   #binding.pry
     redirect_to task_path(@task), notice: ('common.flash.created')
   else
     flash.now[:alert] = @task.errors.full_messages.join('。')
     @task.errors.delete(:content)
     render :new
   end
 end

 #def creates
   #@task = current_user.tasks.build(task_params)
   #if @task.save
     #redirect_to task_path(@task), notice: ('common.flash.created')
   #else
     #flash.now[:alert] = @task.errors.full_messages.join('。')
     #@task.errors.delete(:content)
     #render :new
   #end


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

def confirm_new
   @task = current_user.tasks.new(task_params)
   render :new unless @task.valid?
end

private

def task_params
  params.require(:task).permit(:content)
end


def set_task
  @task = current_user.tasks.find(params[:id])
end

end
