class CommentsController < ApplicationController
  before_filter :initialize_post

  layout false

  def index
    @comments     = @post.comments
    @comment      = @post.comments.build
    @comment.user = current_user if logged_in?

    render :json => { :template => render_to_string("comments/index") }
  end

  def create
    @comment      = @post.comments.build(params[:comment])
    @comment.user = current_user if logged_in?

    if @comment.save
      render :json => { :completed => true, :url => root_url }
    else
      render :json => { :completed => false, :template => render_to_string("comments/form") }
    end
  end

  private

  def initialize_post
    @post = Post.find(params[:post_id])
  end
end