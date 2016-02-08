class NotecardController < ApplicationController

  def index
  end

  def api
    render json: [
      {author: "Pete Hunt", text: "This is one comment"},
      {author: "Jordan Walke", text: "This is *another* comment"}
    ]
  end
end
