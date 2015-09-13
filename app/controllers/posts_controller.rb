class PostsController < ApplicationController
	def post_params
    params.require(:post).permit(:title, :content, :tag_list) ## Rails 4 strong params usage
  end
end