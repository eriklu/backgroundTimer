backgroundTimer
===============

iOS 后台计时Demo

原理:
伪装成音乐播放器，在后端播放声音。按Home键切换到后台后，应用不受10分钟的限制。

如果不播放声音，按Home键后，应用停止运行。

播放声音，如果不循环播放，播放结束后，应用停止运行。

因为播放声音资源是需要独占使用的。后台播放声音时，如果启动新的声音播放程序，应用后台运行被打断，应用停止运行。