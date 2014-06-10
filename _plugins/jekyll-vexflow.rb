module Jekyll
 
  #See https://gist.github.com/joelverhagen/1805814
  class Vexflow < Liquid::Block
    ERROR = "<p>If you are reading this, it is because your browser does not support the HTML5 canvas element.</p>"
    Syntax = /([\w]+)\s([\d?]+)\s([\d?]+)/
 
    def initialize(tagName, markup, tokens)
      super
      if markup =~ Syntax then 
        id = $1.to_s
        @cssElement = "canvas.vexflow-staff#vex_#{id}"
        @cssError = "p.vexflow-error#vex_#{id}_error"
        @width = $2.to_s || 400.to_s
        @height = $3.to_s || 170.to_s
      else
        raise "no argument valid for vexflow"
      end
    end
 
    def render(context)
      staff = {:tag => @cssElement.split(".")[0], :class => @cssElement.split(".")[1].split("#")[0], :id => @cssElement.split("#")[1]}
      error = {:tag => @cssError.split(".")[0], :class => @cssError.split(".")[1].split("#")[0], :id => @cssError.split("#")[1]}
    

      canvas = "<#{staff[:tag]} id='#{staff[:id]}' class='#{staff[:class]}' width='#{@width}' height='#{@height}'></#{staff[:tag]}>"
      p = "<#{error[:tag]} id='#{staff[:id]}_error' class='#{error[:class]}'></#{error[:tag]}>"
      
      vexcode = ""

      context.stack do
        vexcode << render_all(@nodelist, context)
      end

      script = """<script type='text/javascript' id='gen_#{staff[:id]}'>
function render_#{staff[:id]}(callback) {
  try {
    var $c = $('#{@cssElement}'); 
    var r = new Vex.Flow.Renderer($c[0], Vex.Flow.Renderer.Backends.CANVAS);
    var a =   new Vex.Flow.Artist(10, 10, 600, {scale: 0.8})
    var v =   new Vex.Flow.VexTab(a);
    
    callback(false, v);
    a.render(r);
  } catch (e) {
    callback(true, e);
  }
}

render_#{staff[:id]}(function(err, vextab){
  if(!err){
    $('#{@cssError}').text('');
    console.log('DONE');
    vextab.parse(#{vexcode.strip.dump});
  }
  else{
    console.log(vextab.message.replace(\/[\\n]\/g, '\<br\/>'));
  }
});
</script>"""
      
        canvas << p << script
    end
  end

end

Liquid::Template.register_tag('vexflow', Jekyll::Vexflow)
