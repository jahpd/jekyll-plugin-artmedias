module Jekyll

  class Imgtag < Liquid::Tag

    Syntax = /[a-zA-Z]+\.[a-z]+/

    def initialize(tag_name, markup , tokens)
      super
      if markup =~ Syntax then
        @id = $1
 
        unless $2.nil? then
          @src = $2.to_s 
          @width = $3.to_s "50"
          @alt = $4.to_s || ""
          @clazz = $5.to_s || "jekyll-img"
        else
          raise "Give at least src"
        end
      else
        raise "No Video  provided in the \"img\" tag"
      end
    end

    def render(context)
      "<img src='#{@src}' style='max-width:#{@width}%;' alt='#{@alt}'>"
    end
  end

end

Liquid::Template.register_tag('img', Jekyll::Imgtag)
