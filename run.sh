#!/bin/bash
# FIXME: need to findout correct (default) soundcard eg. aplay -L/-l and put it as ALSA_CARD value
docker build . -t vlcrecord && \
docker run -ti --rm \
    -u $(id -u $USER):$(id -g $USER) \
    -w "/home/$USER" \
    -v "/home/$USER:/home/$USER" \
    -v "/etc/group:/etc/group:ro" \
    -v "/etc/passwd:/etc/passwd:ro" \
    -v "/etc/shadow:/etc/shadow:ro" \
    -v "/etc/sudoers.d:/etc/sudoers.d:ro" \
    -e "DISPLAY=$DISPLAY" \
    -v "/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    -e "QT_X11_NO_MITSHM=1" \
    -v /dev/snd:/dev/snd --privileged \
    -e ALSA_CARD=Headset \
    vlcrecord
