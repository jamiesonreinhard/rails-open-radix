class TimelinesController < ApplicationController

  def index
    @timelines = Timeline.where(user: current_user)
  end
  def show
    @timelines = Timeline.all
    if @timelines.length > 0
      @timeline = Timeline.find(params[:id])
    end
  end

  def new
    @timeline = Timeline.new
    @timeline.saved_articles.build
  end

  def create
    @timeline = Timeline.new(timeline_params)
    @timeline.user = current_user
    if @timeline.save!
      @saved_article = SavedArticle.create(article_id: params[:saved_article_id], timeline: @timeline)
      redirect_to timelines_path(@timeline)
    else
      render :new
    end
  end

  def edit
    @timeline = Timeline.find(params[:id])
  end

def update
  @timeline = Timeline.find(params[:id])
  if @timeline.update(timeline_params)
    redirect_to timeline_path(@timeline)
  else
    render :edit
  end
end

  def destroy
    @timeline = Timeline.find(params[:id])
    @timeline.destroy
    redirect_to timelines_path
  end

  private

  def timeline_params
    params.require(:timeline).permit(:topic, :description)
  end

end
