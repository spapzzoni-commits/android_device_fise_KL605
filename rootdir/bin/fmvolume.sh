#!/system/bin/sh
#
# Keep the MediaTek FM codec gain in sync with the music stream volume.
#
# The FM audio path is a hardware patch (fm_tuner -> speaker/headset) and
# bypasses the Android mixer, so STREAM_MUSIC does not drive the FM output
# on this AOSP-based build. The stock MTK framework normally updates the
# "Audio FM I2S Volume" codec control; bridge the gap here so the volume
# keys keep working.
#

while true; do
    if [ "$(cat /proc/fm 2>/dev/null)" = "1" ]; then
        volume=$(dumpsys audio 2>/dev/null \
            | sed -n '/^- STREAM_MUSIC:/,/^- STREAM_ALARM:/p' \
            | grep -m1 'streamVolume:' \
            | tr -dc '0-9')
        [ -z "$volume" ] && volume=8
        [ "$volume" -gt 15 ] && volume=15
        gain=$((volume * 524288 / 15))
        /system/bin/tinymix "Audio FM I2S Volume" "$gain" >/dev/null 2>&1
    fi
    sleep 1
done
