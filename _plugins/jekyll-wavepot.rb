module Jekyll

  attr_accessor :wavepotid

   class WavepotLoad<Liquid::Tag
    
    def initialize(tagName, markup, tokens)
      super
    end

    # https://github.com/processing/p5.js/wiki/Embedding-p5.js
    def render(context)
      "<script src=\"/assets/js/wavepotRT.js\"></script>"
    end
   end
  
  class Wavepot<Liquid::Block

    def initialize(tagName, markup, tokens)
      super
      if markup =~ /(\w+)/ then
        @wavepotid= $1.to_s
      end
    end

    # https://github.com/processing/p5.js/wiki/Embedding-p5.js
    def render(context)
      # pipe param through liquid to make additional replacements possible
      content = Liquid::Template.parse(super).render context
      content[0] = ""
      content[content.length-1]=""
      """<div class=\"wavepot\" id=\"#{@wavepotid}\"><button class=\"play\">play</button><button class=\"stop\">stop</button><pre class=\"highlight language-javascript\" data-lang=\"javascript\"><code>#{content}<code/></pre></div>"""
    end

  end
end

Liquid::Template.register_tag('wavepot', Jekyll::Wavepot)
Liquid::Template.register_tag('wavepotload', Jekyll::WavepotLoad)
