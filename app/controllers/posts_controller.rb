class PostsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create]
  before_action :find_post_and_check_permission, :only => [:edit, :update, :destroy]
  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end

  def create
    @group = Group.find(params[:group_id])
    @post = Post.new(post_params)
    @post.group = @group
    @post.user = current_user

    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @group = @post.group
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to account_posts_path, notice: "Edit Success."
    else
      render :edit
    end
  end

  def destroy
      @post = Post.find(params[:id])
      @post.destroy
      redirect_to account_posts_path, alert: "Post Deleted Success."
  end


private

def find_post_and_check_permission
  @post = Post.find(params[:id])
  if current_user != @post.user
     redirect_to root_path, alert: "You have no permission."
  end
end

def post_params
  params.require(:post).permit(:content)
end


end
