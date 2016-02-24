class NotecardsController < ApplicationController

  def index
    @notecard = current_user.notecards.root
    respond_to do |format|
      format.html { }
      format.json { render @notecard }
    end
  end

  def create
  end

  def update
    @notecard = current_user.notecards.find(params[:id])
    @notecard.update_attributes(notecard_params_for_update)
    render @notecard
  end

  private

  def notecard_params_for_update
    params.require(:notecard).permit(:title, :body)
  end
end
