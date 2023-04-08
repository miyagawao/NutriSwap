class Public::PostsController < ApplicationController
  def index
    
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end


  def create
    @post = current_contributor.posts.build(post_params)
    if @post.save
      flash[:success] = "投稿できました。"
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  
    

  def edit
  end

  def update
  end

  def destroy
  end

  def tags
    @tags = Tag.all
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :image, :tag_list)
  end
    
end
