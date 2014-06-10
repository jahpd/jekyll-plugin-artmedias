module Jekyll
 
  #See https://gist.github.com/joelverhagen/1805814
  class P5 < Liquid::Block
    ERROR = "<p>If you are reading this, it is because your browser does not support the HTML5 canvas element.</p>"
    Syntax = /(\w+)/
 
    def initialize(tagName, markup, tokens)
      super
      if markup =~ Syntax then 
        id = $1.to_s
        @cssElement = "canvas.processing#p5_#{id}"
        @cssError = "p.processing#p5_#{id}_error"
      else
        raise "no argument valid for processing"
      end
    end
 
    def render(context)
      staff = {:tag => @cssElement.split(".")[0], :class => @cssElement.split(".")[1].split("#")[0], :id => @cssElement.split("#")[1]}
      error = {:tag => @cssError.split(".")[0], :class => @cssError.split(".")[1].split("#")[0], :id => @cssError.split("#")[1]}
    

      canvas = "<#{staff[:tag]} id='#{staff[:id]}' class='#{staff[:class]}'>#{ERROR}</#{staff[:tag]}>"
      p = "<#{error[:tag]} id='#{staff[:id]}_error' class='#{error[:class]}'></#{error[:tag]}>"
      
      p5 = ""

      context.stack do
        p5 << render_all(@nodelist, context)
      end


      script = """<script type='text/javascript' id='gen_#{staff[:id]}'>
function render_#{staff[:id]}(callback) {
  try {
    var c = document.getElementById('#{staff[:id]}'); 
    var proc = Processing.compile(#{p5.strip.dump});
    callback(false, new Processing(c, eval(proc.sourceCode)));
  } catch (e) {
    callback(e);
  }
}

render_#{staff[:id]}(function(err, processing){
  if(!err){
    $('#{@cssError}').text('');
    console.log('DONE');
  }
  else{
    console.log(err);
  }
});
</script>"""
      
      canvas << p << script     
    end
  end

end

Liquid::Template.register_tag('p5', Jekyll::P5)
