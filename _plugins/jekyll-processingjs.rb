module Jekyll
 
  #See https://gist.github.com/joelverhagen/1805814
  class P5 < Liquid::Block
    Syntax = /(\w+)/
 
    def initialize(tagName, markup, tokens)
      super
      if markup =~ Syntax then
        @_id = $1.to_s
        @title = markup
        @code = tokens
      end 
    end

    # https://github.com/processing/p5.js/wiki/Embedding-p5.js
    def render(context)
      contents = super

      # pipe param through liquid to make additional replacements possible
      content = Liquid::Template.parse(contents).render context

      #strip out special chars and replace spaces with hyphens
      #safeContent = content.rstrip.gsub(/[^\w\s]/,'').gsub(/[\s]/,'-')
      "<div class=\"example\" id=\"#{@_id}\">#{@title}<pre><code class=\"language-javascript\">#{content}</code></pre></div>"
    end
  end

  class P5LoadScript < Liquid::Tag
    
    def initialize(tagName, markup, tokens)
      super
    end

    # https://github.com/processing/p5.js/wiki/Embedding-p5.js
    def render(context)
      "<link rel=\"stylesheet\" href=\"/assets/css/prism.css\" type=\"text/css\"/><script src=\"/assets/js/jquery.min.js\"></script><script src=\"/assets/js/processing.min.js\"></script><script src=\"/assets/js/render.js\"></script>"
    end
  end

  class P5Run < Liquid::Tag
    
    def initialize(tagName, markup, tokens)
      super
    end

    # https://github.com/processing/p5.js/wiki/Embedding-p5.js
    def render(context)
      """<script type=\"text/javascript\">window.renderCode()</script>"""
    end
  end

end

Liquid::Template.register_tag('p5', Jekyll::P5)
Liquid::Template.register_tag('p5load', Jekyll::P5LoadScript)
Liquid::Template.register_tag('p5run', Jekyll::P5Run)

