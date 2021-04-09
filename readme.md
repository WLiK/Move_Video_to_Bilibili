## 自动搬运youtube视频上传到B站脚本

基于https://github.com/ytdl-org/youtube-dl (youtube下载工具)和https://github.com/FortuneDayssss/BilibiliUploader B站pc投稿工具进行投稿）进行开发。设置定时脚本即可每日定时自动搬运所设置频道的视频转载到b站。

安装步骤:

1. 安装python 3+，建议直接使用  [anaconda](anaconda.com/products/individual)

2. 安装[youtube-dl](https://github.com/ytdl-org/youtube-dl)

3. 下载本项目，执行setup.py进行相关包的安装. 

   ```
   python setup.py
   ```

4. 在dl_video.sh中设置想要转载的频道，和限制天数(例如设置忽略3天之前更新的视频)

   ```
   # 设置限制天数为一天(1d)
   ind_date=`date -v -1d '+%Y%m%d'`
   # 设置频道为https://www.youtube.com/c/cafemusicbgmchannel/playlists
   youtube-dl --proxy http://127.0.0.1:1087 --playlist-end 5 --write-thumbnail --write-info  --dateafter $ind_date https://www.youtube.com/c/cafemusicbgmchannel/playlist
   ```

5. 执行auto_mv_video.sh，即可自动搬运所设置频道的相关视频到b站. 这里会在本地新建以当天日期命名video/file_YYMMDD的文件夹用以存放下载的视频，上传视频的历史记录会保存在本地所创建的up_history.json文件里.

   ```
   bash auto_mv_video.sh
   ```

6. 在user_up.py中设置你的b站用户id和密码.
   
   ```
   user_id = 'XXX'
   user_passwd = 'XXX'
   ```

7. 将auto_mv_video.sh设置为定时任务即可每天自动搬运。例如基于linux的系统(ubuntu, macOS等)可设置crontab任务.

8. 另外，视频防撞车可调用user_up.py中的fileadd_begin_end函数给上传视频添加片头片尾.

Good Luck.



### 以下转载BilibiliUploader的相关使用方法:

## BilibiliUploader

模拟B站pc投稿工具进行投稿

## B站分区tid号码查询

https://github.com/FortuneDayssss/BilibiliUploader/wiki/Bilibili%E5%88%86%E5%8C%BA%E5%88%97%E8%A1%A8

## 海外DNS无法解析问题

海外的DNS有时无法解析upcdn-szhw.bilivideo.com域名导致上传失败，此时可以考虑将DNS服务器临时改为1.2.4.8

## 登录

支持密码登录以及access_token登录

```
uploader = BilibiliUploader()

# 账号密码登录
uploader.login("username_example", "password_example")

# 使用存有access_token的json文件登录
uploader.login_by_access_token_file("/YOURFILEPATH/bililogin.json")

# 直接使用access_token登录，refresh_token可以不提供，没有refresh_token更新时间的话access_token会在获取的30天后过期(todo: refresh)
uploader.login_by_access_token("ACCESS_TOKEN")
uploader.login_by_access_token("ACCESS_TOKEN", "REFRESH_TOKEN")

# 登录后获取access_token与refresh_token
access_token, refresh_token = uploader.save_login_data(file_name="/YOURFOLDER/bililogin.json")
```

## Example

```
from bilibiliuploader.bilibiliuploader import BilibiliUploader
from bilibiliuploader.core import VideoPart

if __name__ == '__main__':
    uploader = BilibiliUploader()
    
    # 登录
    uploader.login("username_example", "password_example")

    # 处理视频文件
    parts = []
    parts.append(VideoPart(
        path="C:/Users/xxx/Videos/1.mp4",
        title="分p名:p1",
        desc="这里是p1的简介"
    ))
    parts.append(VideoPart(
        path="C:/Users/xxx/Videos/2.mp4",
        title="分p名:p2",
        desc="这里是p2的简介"
    ))
    
    # 上传
    avid, bvid = uploader.upload(
        parts=parts,
        copyright=2,
        title='py多p上传测试1',
        tid=171,
        tag=",".join(["python", "测试"]),
        desc="python多p上传测试",
        source='https://www.github.com/FortuneDayssss',
        thread_pool_workers=5,
    )
    
    
    # 修改已有投稿
    parts = []
    parts.append(VideoPart(
        path="C:/Users/xxx/Videos/1.mp4",
        title="edit分p名:p1",
        desc="这里是p1的简介"
    ))
    parts.append(VideoPart(
        path="C:/Users/xxx/Videos/2.mp4",
        title="edit分p名:p2",
        desc="这里是p2的简介"
    ))
    uploader.edit(
        avid=414167215,
        parts=parts,
        copyright=2,
        title='edit 测试1',
        tag=",".join(["python", "测试", "edit"]),
        desc="python多p edit测试",
        source='https://www.github.com/FortuneDayssss',
        cover='/cover_folder/cover.png',
    )
```

## Parameters && Structures

### VideoPart

VideoPart代表投稿内各个分p

* path:上传的文件路径

* title:分p标题

* desc:分p简介

* server_file_name:pre_upload API自动生成的服务端文件名，不需要填写


### Upload

* parts：VideoPart结构体

* copyright: int 版权标志，1为原创2为转载，转载投稿需要填写下面的source参数

* title: str 投稿标题

* tid: int 投稿分区号

* tag: str 以半角逗号分割的字符串

* desc: str 视频简介

* source: int, 转载地址

* cover: str, 封面图片路径，若路径不正确则默认封面为空

* no_reprint: int = 0,视频是否禁止转载标志0无1禁止

* open_elec: int = 1,是否开启充电面板，0为关闭1为开启

* max_retry: int = 5 上传重试次数

* thread_pool_workers: int = 1 多视频并行上传最大线程数，默认为串行上传


### Edit

* avid: av号 (av/bv提供其一即可)

* bvid: bv号 (av/bv提供其一即可)

* parts: VideoPart list (不填写参数则不修改)

* insert_index: 新视频分P位置(不填写参数则从最后追加)

* copyright: 原创/转载 (不填写参数则不修改)

* title: 投稿标题 (不填写参数则不修改)

* tid: 分区id (不填写参数则不修改)

* tag: 标签 (不填写参数则不修改)

* desc: 投稿简介 (不填写参数则不修改)

* source: 转载地址 (不填写参数则不修改)

* cover: 封面路径 (不填写参数则不修改)

* no_reprint: 可否转载 (不填写参数则不修改)

* open_elec: 充电 (不填写参数则不修改)

* max_retry: 上传重试次数

* thread_pool_workers: 多视频并行上传最大线程数，默认为串行上传
