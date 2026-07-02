# **更新文档步骤：**

1. 打开NAS，文档路径：\\MoretionNAS\共享资料\MoretionDocs

2. 如果目前前文件是word，下载pandoc工具并转成md（带链接的图）： https://www.pandoc.org/installing.html 

   pandoc input.docx --extract-media=./images -o output.md

3. 如需新建目录，使用命令： mkdocs new xx_doc
   将.md文件和images等放入docs目录

4. 修改上级目录中的mkdocs.yml文件

   ```
   site_name: Unity Plugins Documentation
   nav:
     - Unity Plugins: unity.md
     - Android Glove: unity_android_glove.md
   theme: 
     name: material
   ```

   通过nav进行分页。

5. 编译网页，生成site目录： mkdocs build

6. 运行网页预览： mkdocs serve

7. 部署GitHub Page：

   仓库：[Moretion/moretion.github.io](https://github.com/Moretion/moretion.github.io)

   加入公司GitHub组织联系言明。

8. 将site目录更名并拷贝进仓库

9. 修改/添加index.html链接，提交完事



插入视频：![type:video](./assets/v0.mp4)