class ApplicationController < ActionController::Base
  before_action :set_search
  protect_from_forgery with: :exception
  include SessionsHelper

  def set_search
  #@search = Article.search(params[:q])
  @search = Task.ransack(params[:q]) #ransackメソッド推奨
  @search_tasks = @search.result.page(params[:page])
  end


end
