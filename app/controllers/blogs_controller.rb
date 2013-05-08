class BlogsController < ApplicationController
  def index
    render "application/index" and return unless logged_in?
    @blog = current_user.blog
  end

  def show
    @blog = Blog.find(params[:id])
    render "blogs/index"
  end
end