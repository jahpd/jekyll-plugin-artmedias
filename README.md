# Jekkyl-media-plugins

These are personal plugins i created to use in my projects:

  - Youtube: add Id

```liquid
{% youtube EoTCS9AZRSQ %}
```

  - <video> Tags: add Src

```liquid
{% video /myvideo.mp4 %}
```

  - MIDI with <embed> tags: add Src

```liquid
{% midi /mymidi.mid %}
```

  - [Vexflow](https://github.com/0xfe/vexflow) <canvas> tags for create music
    staffs: add code!

```
{% vexflow myflow 400 170 %}
tabstave notation=true tablature=false
notes 4-5-6/3 ## =|: 5-4-2/3 2/2 =:|

tabstave notation=true tablature=false
notes C-D-E/4 #0# =:: C-D-E-F/4 =|=
{% endvexflow %}
```

- [P5.js](p5js.org/) with render.js: for create interactive sketchs!

A single static sketch:

```
{% p5 foo %}
createCanvas(400, 400 );
background(255);
smooth();
stroke(random(255), random(255), random(255), 100);
line(i, 0, random(0, width), height);
{% endp5 %}
```

A dynamic sketch:

```
{% p5 foo %}
function setup(){
  createCanvas(400, 400 );
}

function draw(){
  background(255);
  smooth();
  stroke(random(255), random(255), random(255), 100);
  line(i, 0, random(0, width), height);
  if(i>=width){
    i++;
  }
  else{
    i--;
  }
}	
{% endp5 %}
```

# TODO

  - Vimeo
  - <audio> tags
  - Soundcloud
  - Freesound
  - Wikimedia images
  - Audio Synthesis:
    - wavepotruntime
    - termpot.js
    - Gibber
