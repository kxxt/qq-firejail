# 给新版 Linux QQ 的 Firejail 配置文件

这个配置文件目前的主要目标是防止 QQ 偷窥我的隐私。不过我也同时想要防止 QQ 干一些奇怪的事情。

欢迎 PR。

## 做了什么

- 禁止 root
- 禁止读写 /mnt 下的文件
- 和其他进程隔离
- 给 QQ 使用单独的临时目录（/tmp）
- 给 QQ 使用临时家目录，且只把如下的位置挂载到临时家目录
  - `~/.config/pulse`
  - `~/.config/QQ`: 存储 QQ NT 的配置
  - `~/Downloads`: 方便分享下载的文件
  - `~/Pictures`: 方便分享屏幕截图

## 没做什么

- QQ 仍然可以读取你的很多系统文件。（比如 `/etc/v2ray/config.json`）
- QQ 仍然可以运行你安装的其他程序，不过它们会受到一样的限制
- 未完待续

## 怎么食用

```bash
firejail --profile=qq.profile <qq 可执行文件>
```

比如，在 Archlinux 下，如果你安装了 aur 的 linuxqq-new,
你可以运行下面的命令：

```bash
firejail --profile=qq-firejail/qq.profile tencent-qq
```

你也可以自定义 desktop 文件，本仓库附带了一个模板 [`qq.desktop`](qq.desktop)。
