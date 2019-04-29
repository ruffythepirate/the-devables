require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'

class HTML < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet # yep, that's it.

  def block_code(code, language)
    content = Rouge.highlight(code, language || 'text', 'html')
    '<pre class="highlight">' + content + '</pre>'
  end
end

module BlogPostsHelper
  def markdown(text)
    options = {
      filter_html:     true,
      hard_wrap:       true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true,
      fenced_code_blocks: true
    }

    extensions = {
      autolink:           true,
      highlight:          true,
      superscript:        true,
      #disable_indented_code_blocks: true,
      space_after_headers: true,
      fenced_code_blocks: true
    }

    renderer = HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end
end
