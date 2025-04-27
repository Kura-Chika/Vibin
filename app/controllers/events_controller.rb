class EventsController < ApplicationController
  def index
    @posts = current_user.posts # current_user の投稿を取得

    # 投稿の日付とタイトルをカレンダー用に整形
    @events = @posts.map do |post|
      {
        title: post.title,  # 投稿のタイトル
        start: post.created_at.to_date,  # 投稿日
        url: post_path(post),  # 投稿詳細ページへのリンク
      }
    end

    respond_to do |format|
      format.html  # 通常のHTML形式
      format.json { render json: @events.as_json(include: :user) }  # JSON形式で返す
    end
  end
  
  private
  
  def set_events
    # 現在のユーザーがその週に作成したイベントを取得
    @events = current_user.events.where(start: Date.today.beginning_of_week..Date.today.end_of_week)
  end
end
