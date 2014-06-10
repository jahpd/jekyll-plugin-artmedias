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

  - Vexflow <canvas> tags for create music
    staffs: add code!

```
{% vexflow myflow 400 170 %}
tabstave notation=true tablature=false
notes 4-5-6/3 ## =|: 5-4-2/3 2/2 =:|

tabstave notation=true tablature=false
notes C-D-E/4 #0# =:: C-D-E-F/4 =|=
{% endvexflow %}
```

- Processing.js with <canvas> tags: for create interactive sketchs!

```
{% p5 foo %}
int i = 0; 
void setup() {
   size(800, 800);
   background(255);
   smooth();
   strokeWeight(15);
   frameRate(24);
} 
void draw() {
  stroke(random(255), random(255), random(255), 100);
  line(i, 0, random(0, width), height);
  if (i <= width) {
    i++;
  } else {
    i = 0; 
  }
}
{% endp5 %}
```

Future:

  - Vimeo
  - <audio> tags
  - Soundcloud
  - Freesound
  - Wikimedia images
