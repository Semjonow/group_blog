class PostsController < ApplicationController
  before_filter :check_logged_in

  layout false

  def new
    @post = current_user.blog.posts.build
    render :json => { :template => render_to_string("posts/new") }
  end

  def create
    @post = current_user.blog.posts.build(params[:post])
    if @post.save
      render :json => { :completed => true, :url => root_url }
    else
      render :json => { :completed => false, :template => render_to_string(:partial => "posts/form") }
    end
  end
end