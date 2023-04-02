# TeX Live + xduts fonts
此镜像包含TeX Live和[西电毕设和部分开题报告的LaTex模板 xduts](https://github.com/note286/xduts)中需要的字体，基础的镜像是[jiuyoung/texlive](https://hub.docker.com/r/jiuyoung/texlive)，操作系统是Debian，**可以用于Github的[Codespace](https://github.com/features/codespaces)以及[devcontainer](https://containers.dev/overview)来作为基础镜像。**



**注意！！！此镜像非 xduts 官方版本，并且不包含模板相关信息，仅仅提供一个运行环境。**

## 使用说明

为了方便使用文档，此镜像分为两个版本，第一个版本无后缀，例如`latest`，表示不带有文档的版本；第二个版本有 doc 后缀，例如`latest-doc`，表示镜像中包括宏包的文档。

### Github Codespace

Github Codespace 可以在云端基于 .devcontainer 创建一个运行环境，支持在浏览器中运行，支持登录 VS Code 的同步账号，可以在云端同步本地的 VS Code 配置。

**注意：**

* Codespace 有资源限制，具体请查看 Github
* 需要将写毕业论文的项目上传到 Github 仓库中



**步骤：**

1. 在自己的毕设项目根目录中创建 `.devcontainer/devcontainer.json` 文件，此文件用于定义 Codespace 的运行时
2. 将下述的内容写入到上述文件中，可以按照自己的想法自行修改

```json
{
  // 环境名称
  "name": "webtex",
  // 使用本项目提供的基础镜像
  "image": "texlive/texlive:latest",
  "remoteUser": "root",
  "customizations": {
    "vscode": {
      "settings": {
        // 不同的编译命令，根据使用的参考文献后端来切换
        "latex-workshop.latex.recipes": [
          {
            // xduts默认使用这种即可
            "name": "xelatex -> biblatex -> xelatex*2",
            "tools": [
              "xelatex-no-pdf",
              "biblatex",
              "xelatex-no-pdf",
              "xelatex"
            ]
          },
          {
            "name": "xelatex -> bibtex -> xelatex*2",
            "tools": [
              "xelatex-no-pdf",
              "bibtex",
              "xelatex-no-pdf",
              "xelatex"
            ]
          },
          {
            // 一站式自动编译
            "name": "cn-ref-one-command",
            "tools": [
              "cn-ref-one-command"
            ]
          }
        ],
        "latex-workshop.latex.tools": [
          {
            "name": "latexmk",
            "command": "latexmk",
            "args": [
              "-synctex=1",
              "-interaction=nonstopmode",
              "-file-line-error",
              "-pdf",
              "%DOC%"
            ]
          },
          {
            "name": "xelatex",
            "command": "xelatex",
            "args": [
              "-synctex=1",
              "-interaction=nonstopmode",
              "-file-line-error",
              "%DOC%"
            ]
          },
          {
            "name": "xelatex-no-pdf",
            "command": "xelatex",
            "args": [
              "-interaction=nonstopmode",
              "-file-line-error",
              "-no-pdf",
              "%DOC%"
            ]
          },
          {
            "name": "bibtex",
            "command": "bibtex",
            "args": [
              "%DOCFILE%"
            ]
          },
          {
            "name": "biblatex",
            "command": "biber",
            "args": [
              "%DOCFILE%"
            ]
          },
          {
            "name": "cn-ref-one-command",
            "command": "latexmk",
            "args": [
              "-xelatex",
              "%DOC%"
            ]
          }
        ],
        "[latex]": {
          // 让latex文档可以折行显示
          "editor.wordWrap": "on"
        },
        "latex-workshop.latex.clean.fileTypes": [
          "*.aux",
          "*.bbl",
          "*.blg",
          "*.idx",
          "*.ind",
          "*.lof",
          "*.lot",
          "*.out",
          "*.toc",
          "*.acn",
          "*.acr",
          "*.alg",
          "*.glg",
          "*.glo",
          "*.gls",
          "*.fls",
          "*.log",
          "*.fdb_latexmk",
          "*.snm",
          "*.synctex(busy)",
          "*.synctex.gz(busy)",
          "*.nav",
          "*.vrb",
          "*.gz", // Added Manually
          "*.bcf", // Added Manually
          "*.nlo", // Added Manually
          "*.run.xml" // Added Manually
        ],
        "latex-workshop.latex.autoClean.run": "onBuilt",
        "latex-workshop.latex.build.forceRecipeUsage": false,
        "latex-workshop.synctex.afterBuild.enabled": true,
        "latex-workshop.view.pdf.viewer": "tab",
        "latex-workshop.latex.clean.subfolder.enabled": true,
        "latex-workshop.latex.autoBuild.cleanAndRetry.enabled": false,
        //"latex-workshop.latex.watch.delay": 500, // Deprecated. See here: https://github.com/sanjib-sen/WebLaTex/issues/8
        "latex-workshop.codespaces.portforwarding.openDelay": 20000
      },
      "extensions": [
        "James-Yu.latex-workshop"
      ]
    }
  }
}
```



3. 将自己的毕设项目上传到 GitHub 。
4. 在 GitHub Codespace 中选中此项目并创建 Codespace



## 注意事项

1. 此镜像中的字体来自于[xduts discussions 适用于XDUTS的常见示例/代码片段 #40](https://github.com/note286/xduts/discussions/40#discussioncomment-5117827)，打包镜像的时间是2023年04月02日，**后续如果有字体更新请自行 fork 并将其加入到 fonts 文件夹中，重新打包镜像**
2. 此镜像中的 TeX Live 使用阿里的[CTAN镜像](https://mirrors.aliyun.com/CTAN/systems/texlive/tlnet)
3. 

