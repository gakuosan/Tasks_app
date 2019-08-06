class ApplicationController < ActionController::Base
  before_action :login_required

  before_action :set_search
  protect_from_forgery with: :exception
  include SessionsHelper

  def set_search
  #@search = Article.search(params[:q])
  @search = Task.ransack(params[:q]) #ransackメソッド推奨
  @search_tasks = @search.result.page(params[:page])
  end

  def login_required
    redirect_to login_path unless current_user
  end
end
