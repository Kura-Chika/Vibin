class SearchesController < ApplicationController
  def search
    @query = params[:query]
    @search_type = params[:search_type]  # ユーザー検索 or 投稿検索
    @match_type = params[:match_type]    # 部分一致

    if @search_type == 'User'
      @results = User.search_by_fullname(@query, @match_type)
    elsif @search_type == 'Post'
      @results = Post.search_by_name(@query, @match_type)
    else
      @results = []  # どちらにも該当しない場合、@results は空の配列 [] になる
    end

    render 'searches/search_results'
  end
end

