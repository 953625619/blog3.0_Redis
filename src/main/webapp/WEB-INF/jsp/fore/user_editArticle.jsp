<%--
  Created by IntelliJ IDEA.
  User: 林浩
  Date: 2018/10/7
  Time: 21:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../include/fore/fore_header.jsp" %>
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
<%--<script src="${pageContext.request.contextPath}/js/editor.md/Gulpfile.js"></script>--%>
<script src="${pageContext.request.contextPath}/js/editor.md/editormd.amd.js"></script>
<script src="${pageContext.request.contextPath}/js/editor.md/editormd.amd.min.js"></script>
<script>
    var testEditor;
    testEditor = $(function () {
        editormd("my-editormd", {
            width: "90%",
            height: 400,
            //markdown : md,
            codeFold: true,
            syncScrolling: "single",
            //你的lib目录的路径
            path: getContentPath() + "/js/editor.md/lib/",
            saveHTMLToTextarea: true,
            imageUpload: true,
            imageFormats: ["jpg", "jpeg", "gif", "png", "bmp", "webp"],
            // imageUploadURL: path+"/upload/article",
            imageUploadURL: getContentPath() + "/admin/articles/editormdPic",
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
<%@include file="../../include/fore/fore_top.jsp" %>
<%@include file="../../include/fore/fore_nav.jsp" %>
<div class="bottom_navigate">
    <ul class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}/home">首页</a></li>
        <li><a href="${pageContext.request.contextPath}/home/users/${user.id}">我的空间</a></li>
        <li class="active">编辑文章</li>
    </ul>
</div>
</nav>
<div class="main">
    <div class="userInfo">
        <div class="userLeft pull-left">
            <ul class="nav nav-pills nav-stacked">
                <li role="presentation" class="userLi"><a
                        href="${pageContext.request.contextPath}/home/users/${user.id}">个人资料</a></li>
                <li role="presentation" class="active userLi"><a
                        href="${pageContext.request.contextPath}/home/users/${user.id}/articles">我的文章</a></li>
                <li role="presentation" class="userLi"><a
                        href="${pageContext.request.contextPath}/home/users/${user.id}/create">创建文章</a></li>
                <li role="presentation" class="userLi"><a
                        href="${pageContext.request.contextPath}/home/users/${user.id}/comments">评论</a></li>
            </ul>
        </div>
        <div class="userRight pull-left">
            <div class="allArticle_contain">
                <div class="writeArticle">
                    <form action="${pageContext.request.contextPath}/fore/articles" method="post"
                          id="updateArticleFrom">
                        <input type="hidden" id="second_url" value="/home/users/${user.id}/articles">
                        <table style="border-spacing: 20px;border-collapse: separate">
                            <tr>
                                <td>
                                    <label for="article_title">标题<span class="alarm">*</span></label>
                                </td>
                                <td>
                                    <input type="text" id="article_title" name="articleTitle"
                                           value="${article.articleTitle}"
                                           class="form-control">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="my-editormd">内容<span class="alarm">*</span></label>
                                </td>
                                <td>
                                    <div class="editormd" id="my-editormd">
                                        <!-- 用于接受后台传递的数据 -->
                                        <textarea class="editormd-markdown-textarea" name="my-editormd-markdown-do"
                                                  id="my-editormd-markdown-do">${article.articleMdText}</textarea>
                                        <!-- <textarea class="editormd-html-textarea" name="test-editormd-html-code" style="display: none;"></textarea> -->
                                    </div>
                                    <%--<div id="doc-content">--%>
                                    <%--<textarea style="display: none;">${article.articleHtmlText}</textarea>--%>
                                    <%--</div>--%>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label>分类<span class="alarm">*</span></label>
                                </td>
                                <td>
                                    <div class="form-group">
                                        <div class="dropdown bootstrap-select">
                                            <select class="selectpicker" data-style="btn-success" tabindex="-98"
                                                    name="category1" id="category1">
                                                <option value="${article.parent.id}">${article.parent.categoryName}</option>
                                                <c:forEach items="${categories1}" var="cat">
                                                    <option value="${cat.id}">${cat.categoryName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="dropdown bootstrap-select">
                                            <select class="selectpicker" data-style="btn-success" tabindex="-98"
                                                    name="category2" id="category2">
                                                <option value="${article.children.id}">${article.children.categoryName}</option>
                                                <c:forEach items="${categories2}" var="cat">
                                                    <option value="${cat.id}">${cat.categoryName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="checkBox">标签</label>
                                </td>

                                <td>
                                    <div id="checkBox">
                                        <c:forEach items="${tags}" var="tag" varStatus="st">
                                            <div class="checkbox checkbox-success checkbox-inline" style="margin: 5px">
                                                <input type="checkbox" name="tagCheckBox" class="styled" id="${tag.id}"
                                                       value="${tag.id}"
                                                <c:forEach items="${article.tags}" var="tag1">
                                                <c:if test="${tag.id eq tag1.id}"> checked=""</c:if>
                                                </c:forEach>>
                                                <label for="${tag.id}"> ${tag.tagName} </label>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label for="radioButton"></label>
                                </td>
                                <td>
                                    <div id="radioButton">
                                        <div class="radio radio-info radio-inline">
                                            <input type="radio" id="inlineRadio1" value="1" name="radioInline" <c:if
                                                    test="${article.articleStatus eq 1}"> checked=""</c:if>>
                                            <label for="inlineRadio1">发布</label>
                                        </div>
                                        <div class="radio radio-inline">
                                            <input type="radio" id="inlineRadio2" value="2" name="radioInline"  <c:if
                                                    test="${article.articleStatus eq 2}"> checked=""</c:if>>
                                            <label for="inlineRadio2">草稿</label>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td> &nbsp;
                                    <input type="hidden" id="articleId" value="${article.id}">
                                </td>
                                <td>
                                    <button class="btn btn-success updateArticleButton" type="button">立即提交</button>
                                    <button class="btn btn-default" type="reset" id="resetArticle">重置</button>
                                </td>
                            </tr>
                        </table>
                    </form>

                </div>
            </div>
        </div>

    </div>
</div>
<div class="clearfix"></div>
<%@include file="../../include/fore/fore_footer.jsp" %>
