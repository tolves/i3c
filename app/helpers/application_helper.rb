module ApplicationHelper

  # <%= icon("bicycle", class: "text-success") %>
  def icon(icon, options = {})
    file = File.read("node_modules/bootstrap-icons/icons/#{icon}.svg")
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'
    if options[:class].present?
      svg['class'] += " " + options[:class]
    end
    doc.to_html.html_safe
  end

  def nav
    content_tag(:ul, class: "nav nav-tabs justify-content-end") do
      yield
    end
  end

  def nav_link(text, path)
    options = current_page?(path) ? { class: "nav-link active disabled" } : { class: "nav-link", method: :get }
    content_tag(:li, { class: "nav-item" }) do
      link_to text, path, options
    end
  end
end
