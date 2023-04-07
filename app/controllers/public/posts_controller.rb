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
    @post = Post.new(post_params)
    # カンマ区切りでタグを分割
    # @post.tag_list = params[:post][:tag_list].split(",")
    #既に存在するタグは使用し、存在しないタグは新しいタグを作成
    # tags = []
    # @post.tag_list.each do |tag_name|
    #   tags << Tag.find_or_create_by(name: tag_name.strip)
    # end
    # @post.tags = tags

    if @post.save
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

  private

  def post_params
    params.require(:post).permit(:title, :content, :image, :tag_list)
  end

end
