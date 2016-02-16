class NotecardController < ApplicationController
  before_filter :set_comments

  def index
  end

  def api
    render json: @comments
  end

  def create
    @comments.push({ author: params[:author], text: params[:text] })
    render json: @comments
  end

  private


  def set_comments
    @comments = [
      {author: "Pete Hunt", text: "This is one comment"},
      {author: "Jordan Walke", text: "This is *another* comment"}
    ]
  end
end
