FROM jiuyoung/texlive:latest

# 将Dockerfile同目录的字体复制到Linux字体文件夹中
COPY fonts/* /usr/share/fonts/
# 刷新字体缓存
RUN fc-cache -fv
# 设置 texlive 的镜像地址
RUN sudo tlmgr option repository https://mirrors.aliyun.com/CTAN/systems/texlive/tlnet
