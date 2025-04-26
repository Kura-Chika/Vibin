class SearchesController < ApplicationController
  def search
    @query = params[:query]
    @search_type = params[:search_type]
    @match_type = params[:match_type]  # 部分一致

    @results = case @search_type
    when 'User'
      User.search_by_fullname(@query, @match_type)
    when 'Post'
      Post.search_by_name(@query, @match_type)
    when 'Artist'
      Artist.search_by_name(@query, @match_type)
    when 'Comment'
      Comment.search_by_body(@query, @match_type)
    else
      []
    end

    render 'searches/search_results'
  end
end

