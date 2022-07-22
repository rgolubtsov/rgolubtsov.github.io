# X11 screencast using FFmpeg

```
$ ffmpeg -f x11grab     -video_size 1920x1080  -framerate 24 \
                        -thread_queue_size 512 -i ${DISPLAY} \
         -f pulse -ac 2 -thread_queue_size 512 -i default    \
                        -c:v libx264 -preset ultrafast       \
                        -c:a aac  <video_filename>.mp4
...
```
