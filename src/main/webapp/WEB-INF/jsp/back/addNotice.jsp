<%--
  Created by IntelliJ IDEA.
  User: 林浩
  Date: 2018/9/26
  Time: 16:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../include/back/back_header.jsp" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/editor.md/editormd.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/editor.md/codemirror.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/editor.md/dialog.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/editor.md/matchesonscrollbar.css">

<script src="${pageContext.request.contextPath}/js/editor.md/editormd.js"></script>
<script src="${pageContext.request.contextPath}/js/editor.md/codemirror.min.js"></script>
<script src="${pageContext.request.contextPath}/js/editor.md/modes.min.js"></script>
<script src="${pageContext.request.contextPath}/js/editor.md/addons.min.js"></script>
<script src="${pageContext.request.contextPath}/js/editor.md/marked.min.js"></script>
<script src="${pageContext.request.contextPath}/js/editor.md/prettify.min.js"></script>
<script src="${pageContext.request.contextPath}/js/editor.md/editormd.min.js"></script>
<script src="${pageContext.request.contextPath}/js/editor.md/Gulpfile.js"></script>
<script src="${pageContext.request.contextPath}/js/editor.md/editormd.amd.js"></script>
<script src="${pageContext.request.contextPath}/js/editor.md/editormd.amd.min.js"></script>
<script>
    var testEditor;
    testEditor = $(function () {
        editormd("my-editormd", {
            width: "100%",
            height: 440,
            //markdown : md,
            codeFold: true,
            syncScrolling: "single",
            //你的lib目录的路径
            path: path + "/js/editor.md/lib/",
            saveHTMLToTextarea: true,
            imageUpload: true,
            imageFormats: ["jpg", "jpeg", "gif", "png", "bmp", "webp"],
            // imageUploadURL: path+"/upload/article",
            imageUploadURL: path + "/admin/articles/editormdPic",
            onload: function () {
                console.log('onload', this);
            },
            /*  theme: "dark",//工具栏主题
             previewTheme: "dark",//预览主题
             editorTheme: "pastel-on-dark",//编辑主题 */
            emoji: true,
            // taskList: true,
            // tocm: true,         // Using [TOCM]
            // tex: true,                   // 开启科学公式TeX语言支持，默认关闭
            // flowChart: true,             // 开启流程图支持，默认关闭
            // sequenceDiagram: true,       // 开启时序/序列图支持，默认关闭,
            //这个配置在simple.html中并没有，但是为了能够提交表单，使用这个配置可以让构造出来的HTML代码直接在第二个隐藏的textarea域中，方便post提交表单。
            watch: false,
            toolbarAutoFixed: false,
            toolbarIcons: function () {
                // Or return editormd.toolbarModes[name]; // full, simple, mini
                // Using "||" set icons align right.
                return ["bold", "italic", "|", "del", "hr", "|", "link", "image", "code", "emoji", "html-entities", "||", "watch", "fullscreen", "preview", "clear"]
            }

        });
    });
</script>
<%@include file="../../include/back/back_top.jsp" %>
<%@include file="../../include/back/back_nav_notice.jsp" %>
<div class="container">
    <ul class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}/admin/index">首页</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/notices">公告列表</a></li>
        <li class="active">添加公告</li>
    </ul>
    <div class="addNotice">
        <form action="${pageContext.request.contextPath}/admin/notices" method="post" id="addNoticeFrom">
            <table>
                <tr>
                    <td>
                        <label for="noticeTitle">标题<span class="alarm">*</span></label>
                    </td>
                    <td>
                        <input type="text" id="noticeTitle" name="noticeTitle" placeholder="请输入标题"
                               class="form-control">
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="my-editormd">内容<span class="alarm">*</span></label>
                    </td>
                    <td>
                        <div class="editormd" id="my-editormd">
                            <textarea class="editormd-markdown-textarea" name="my-editormd-markdown-do"
                                      id="my-editormd-markdown-do"></textarea>
                            <!-- 第二个隐藏文本域，用来构造生成的HTML代码，方便表单POST提交，这里的name可以任意取，后台接受时以这个name键为准 -->
                            <!-- html textarea 需要开启配置项 saveHTMLToTextarea == true -->
                            <textarea class="editormd-html-textarea" name="my-editormd-html-code" id="my-editormd-html-code"></textarea>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td> &nbsp;
                    </td>
                    <td>
                        <button class="btn btn-success" type="button" id="addNoticeButton">添加</button>
                        <button class="btn btn-default" type="reset" id="resetNotice">重置</button>
                    </td>
                </tr>
            </table>
        </form>

    </div>

</div>
