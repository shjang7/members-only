class PostsController < ApplicationController
  before_action :is_signed_in?, only: [:new, :create]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(user_id: session[:user_id],
                     content: params[:post][:content])
    if @post.save
      flash[:success] = "Thank you for writing post!"
      redirect_to posts_path
    else
      render :new
    end
  end

  def index
    @posts = Post.all
  end
end
