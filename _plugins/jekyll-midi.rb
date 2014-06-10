module Jekyll

  class MIDITag < Liquid::Tag
    
    Syntax = /((http|https):\/\/[^ ]+.mid)/
    def initialize(tag_name, markup, tokens)
      super
      if markup =~ Syntax then
        @src = $1
      else
        raise "Error on parsing html src form MIDI"
      end
    end

    def render(context)
      "<embed src='#{@src}' width='100%' height='100%' name='plugin' type='audio/midi'/>"
    end
  end

end

Liquid::Template.register_tag('midi', Jekyll::MIDITag)
