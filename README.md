iOS下解码AAC并播放
=======
https://smart-voice-stg.pingan.com.cn:10422/nfsc/csp_isps_core_id005707_vol1003_stg/API/VPROMP01/TTS_HTTP/vprompttshttp01/20190212/1549939956202574.aac
>>>>>>> 

#### iOS系统对音频处理做了三层封装。包括应用层、服务层和硬件层。

我们本次使用的都是服务层的接口。也就是上图中被红色框起来的部分。该层更接近于底层，所以灵活性更大，性能也更好。尤其对于直播相关的项目最好使用该层接口。
在iOS下进行音频解码及播放的大体流程如下：

- 打开 AAC 文件。
- 获取音频格式信息。如通道数，采样率等。
- 从 AAC 文件中取出一帧 AAC 数据。
- 使用 AudioToolbox 解码 AAC 数据包。
- 将解码后的 PCM 数据送给 AudioUnit 播放声音。
重复 3-5 步，直到整个 AAC 文件被读完。

AAC 解码与 AAC 编码的逻辑非常类似。

- 首先，设置音频的输入与输出格式。在这里音频的输入格式可以通过上一节中的 AudioFileGetProperty 方法从文件中提取来。
- 其次，创建 AAC 解码器。
 - 解码。
 
 本文介绍了如何将一个AAC文件播放出来的步骤。它包括：
 
 - 打开 AAC 媒体文件。
 - 获取 AAC 媒体格式。
 - 从 AAC 文件中读取一个 AAC 音频帧。
 - 通过 AudioToolbox 解决 AAC 到 PCM。
 - 通过 AudioUnit 播放 PCM。
 循环执行 3-5步，直到文件结束。
 
 希望本文能对您有所帮助。并请多多关注。谢谢！
 
新手项目，多多包涵，谢谢！有相关问题可以在线留言或发邮件至Keen_Team@163.com，谢谢！


# License
The MIT License (MIT)

Copyright (c) 2016 KEENTEAM

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
