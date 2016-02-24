class Notecard < ApplicationRecord
  acts_as_nested_set
  belongs_to :user

  def htmlified_body
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(body)
  end
end
