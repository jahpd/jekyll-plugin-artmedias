module Jekyll
  class Videotag < Liquid::Tag
    
    ERROR = "<p>If you are reading this, it is because your browser does not support the HTML5 video element.</p>"

    def initialize(tag_name, src, tokens)
      super
      @src = src
    end

    def render(context)
      "<video src='#{@src}' width='480' height='360'>#{ERROR}</video>"
    end
  end

  #See https://gist.github.com/joelverhagen/1805814
  class YoutubeTag < Liquid::Tag
    Syntax = /^\s*([^\s]+)(?:\s+(\d+)\s+(\d+)\s*)?/
 
    def initialize(tagName, markup, tokens)
      super
 
      if markup =~ Syntax then
        @id = $1
 
        if $2.nil? then
          @width = 560
          @height = 420
        else
          @width = $2.to_i
          @height = $3.to_i
        end
      else
        raise "No YouTube ID provided in the \"youtube\" tag"
      end
    end
 
    def render(context)
      "<iframe width=\"#{@width}\" height=\"#{@height}\" src=\"http://www.youtube.com/embed/#{@id}?color=white&amp;theme=light\">&nbsp;</iframe>"
    end
  end

end

Liquid::Template.register_tag('video', Jekyll::Videotag)
Liquid::Template.register_tag('youtube', Jekyll::YoutubeTag)
