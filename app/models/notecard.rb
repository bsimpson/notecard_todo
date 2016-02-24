class Notecard < ApplicationRecord
  include Rails.application.routes.url_helpers

  acts_as_nested_set
  belongs_to :user

  before_save :build_notecards_for_list_items

  def body
    read_attribute("body") || ""
  end

  def htmlified_body
    html = Nokogiri::HTML Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(body)
    html.xpath("//li").each do |li|
      notecard = self.children.find_by(title: li.text)
      new_parent = li.add_next_sibling(Nokogiri::XML::Node.new("a", Nokogiri::HTML.fragment(li.text)))
      new_parent[:href] = notecard_path(notecard) if notecard
      new_parent.add_child(li)
    end
    # Nogogiri is sad that we don't have a doctype and all that jazz so it gives it to us for free
    # Except that I don't want it
    html.at("//body").inner_html
  end

  private

  def build_notecards_for_list_items
    Nokogiri::HTML.parse(htmlified_body).xpath("//li").each do |li|
      notecard = self.children.find_or_create_by!(title: li.text)
      notecard.move_to_child_of(self)
    end
  end
end
