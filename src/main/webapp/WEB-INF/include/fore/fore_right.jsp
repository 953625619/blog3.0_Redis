<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 林浩
  Date: 2018/10/2
  Time: 12:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<div class="information pull-right">
    <div class="info_author">
        <div class="info_title">
            <span class="glyphicon glyphicon-th-list info_title_tag"></span>
            <span class="separate"></span>
            <span>关于本站</span>
        </div>
        <div class="info_author_information">
            <img src="${pageContext.request.contextPath}/${optionPhoto.optionValue}" alt="" width="120px" height="115px"
                 class="pull-left">
            <div class="info_author_name">${optionName.optionValue}</div>
            <div class="info_author_introduction">
                ${optionDescribe.optionValue}
            </div>
            <div>
            </div>
        </div>
        <div class="clearfix"></div>
        <div class="info_author_all">
            <span>文章 ${articleSum}</span>
            <span class="separate"></span>
            <span>留言 ${commentSum}</span>
        </div>
    </div>
    <div class="info_website">
        <div class="info_title">
            <span class="glyphicon glyphicon-th-list info_title_tag"></span>
            <span class="separate"></span>
            <span>网络概况</span>
        </div>
        <div class="info_website_information">
            <ul>
                <li><span class="glyphicon glyphicon-file">  文章总数：${articleSum}篇</span></li>
                <li><span class="glyphicon glyphicon-comment">  留言总数：${commentSum}条</span></li>
                <li><span class="glyphicon glyphicon-tasks">  分类数量：${categorySum}个</span></li>
                <li><span class="glyphicon glyphicon-tag">  标签总数：${tagSum}个</span></li>
                <li><span class="glyphicon glyphicon-user">  在线人数：<span id="total">1</span>个</span></li>
                <li><span class="glyphicon glyphicon-eye-open">  浏览总量：${viewSum}</span></li>
                <li><span class="glyphicon glyphicon-edit">  最后更新：${newDate}</span></li>
            </ul>
        </div>

    </div>
    <div class="info_hot">
        <div class="info_title">
            <span class="glyphicon glyphicon-th-list info_title_tag"></span>
            <span class="separate"></span>
            <span>热评文章</span>
        </div>
        <div>
            <ul>
                <c:forEach items="${articles}" var="art" varStatus="st">
                    <c:if test="${st.index<10}">
                        <li><a href="${pageContext.request.contextPath}/home/articles/${art.id}">${art.articleTitle}</a>
                        </li>
                    </c:if>
                </c:forEach>
            </ul>
        </div>
    </div>
    <div class="info_tag">
        <div class="info_title">
            <span class="glyphicon glyphicon-th-list info_title_tag"></span>
            <span class="separate"></span>
            <span>所有标签</span>
        </div>
        <div class="info_tag_myTag">
            <c:forEach items="${tags}" var="tag">
                <span><a href="${pageContext.request.contextPath}/home/tags/${tag.id}">${tag.tagName}</a></span>
            </c:forEach>
        </div>
    </div>
    <div class="info_comment">
        <div class="info_title">
            <span class="glyphicon glyphicon-th-list info_title_tag"></span>
            <span class="separate"></span>
            <span>近期评论</span>
        </div>
        <div class="info_comment_myComment">
            <ul>
                <c:forEach items="${comments}" var="com" varStatus="st">
                    <c:if test="${st.index<10}">
                        <li><img width="30px" height="30px"
                                 src="${pageContext.request.contextPath}/${com.user.userPhoto}"
                                 alt=""> ${com.user.userNickName}:  ${com.commentMdText}</span></li>
                    </c:if>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>
<script>
    var websocket = null;
    //判断当前浏览器是否支持WebSocket
    if ('WebSocket' in window) {
        websocket = new WebSocket("ws://120.79.215.101:8080/blog/ws/online");
        //
        // //连接成功建立的回调方法
        // websocket.onopen = function () {
        //     websocket.send("客户端链接成功");
        // }

        //接收到消息的回调方法
        websocket.onmessage = function (event) {
            setMessageInnerHTML(event.data);
        }
        //
        // //连接发生错误的回调方法
        // websocket.onerror = function () {
        //     console.log("WebSocket连接发生错误");
        // };
        //
        // //连接关闭的回调方法
        // websocket.onclose = function () {
        //     console.log("WebSocket连接关闭");
        // }

        //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
        window.onbeforeunload = function () {
            closeWebSocket();
        }

    }
    else {
        console.log('当前浏览器 Not support websocket')
    }

    //将消息显示在网页上
    function setMessageInnerHTML(innerHTML) {
        var user = eval("("+innerHTML+")");
        document.getElementById('total').innerHTML = user.total;
    }

    //关闭WebSocket连接
    function closeWebSocket() {
        websocket.close();
    }

</script>
