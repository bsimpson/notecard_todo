class NotecardController < ApplicationController

  def index
    respond_to do |format|
      format.html { }
      format.js { render json: notecards }
    end
  end

  def create
  end

  def update
    notecard = current_user.notecards.find(params[:id])
    notecard.update_attributes(notecard_params_for_update)
    render json: Array(notecard)
  end

  private

  def notecards
    @notecards ||= Array(current_user.notecards.root)
  end

  def notecard_params_for_update
    params.require(:notecard).permit(:title, :body)
  end
end
