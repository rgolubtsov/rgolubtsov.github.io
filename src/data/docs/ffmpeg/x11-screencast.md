# X11 screencast using FFmpeg

### A one very simple yet effective X11 desktop screencasting method

*12th of August, 2022*

Sometimes it needs to perform screen capturing of a desktop where a sequence of some live actions (for example, typing something in the editor, moving windows, playing video content, recording audio input, demonstrating various techniques of something special) should be saved into a video file that can be played and watched later on locally or somewhere else &ndash; simply as the ordinary let's say MPEG-4 video file. There are plenty of cases where it is helpful and desirable: for recording a webinar session, for preparing a task to implement, or visually and orally reporting about its carrying out progress or completeness, and many more. This is commonly known as screencasting.

The very performant and easy to use tool for screencasting is the FFmpeg *versatile utility*. Under unices an X11-driven desktop can be easily captured and recorded along with all the corresponding audio streams (if any) to the MP4 video file using the following one-liner command:

```
$ ffmpeg -f x11grab     -video_size 1920x1080  -framerate 24 \
                        -thread_queue_size 512 -i ${DISPLAY} \
         -f pulse -ac 2 -thread_queue_size 512 -i default    \
                        -c:v libx264 -preset ultrafast       \
                        -c:a aac  <video_filename>.mp4
...
```

To finish recording, simply hit `<Ctrl-C>` in the terminal window where screencasting was started, and get a brand new video file just created.

Happy X11-screencasting with FFmpeg ! :+1:
