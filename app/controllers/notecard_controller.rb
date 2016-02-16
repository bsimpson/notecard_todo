class NotecardController < ApplicationController

  def index
    respond_to do |format|
      format.html { }
      format.js { render json: notecards }
    end
  end

  def create
  end

  private


  def notecards
    @notecards ||= current_user.notecards.limit(50).to_a
  end
end
