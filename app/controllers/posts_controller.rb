class PostsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @posts = Post.all
  end
  
  def new
    @post = current_user.posts.new
  end
  
  def create
    @post = current_user.posts.new(post_params)
    
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def edit
    if current_user.posts.exists?(params[:id])
      @post = current_user.posts.find(params[:id])
    else
      flash[:notice] = "You cannot edit someone else's post."
      redirect_to posts_path
    end
  end
  
  def update
    @post = current_user.posts.find(params[:id])
    
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end
  
  def destroy
    if current_user.posts.exists?(params[:id])
      @post = current_user.posts.find(params[:id])
      @post.destroy
    else
      flash[:notice] = "You cannot delete someone else's post."
    end
    redirect_to posts_path
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :content)
  end

end
