class ApplicationController < ActionController::Base
  #before_action :set_current_user

  before_action :set_search
  protect_from_forgery with: :exception
  include SessionsHelper

  def set_search
  #@search = Article.search(params[:q])
  @search = Task.ransack(params[:q]) #ransackメソッド推奨
  @search_tasks = @search.result.page(params[:page])
  end

  #def set_current_user
  #@current_user = User.find_by(id: session[:user_id])
  #end

end
