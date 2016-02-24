class AddDefaultToNotecardBody < ActiveRecord::Migration[5.0]
  def change
    change_column :notecards, :body, :text, default: String.new
  end
end
