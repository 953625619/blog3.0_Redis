<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 林浩
  Date: 2018/10/1
  Time: 22:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<header class="header">
    <div class="header_left pull-left">
        <c:if test="${empty user}">
            <a href="${pageContext.request.contextPath}/loginPage">登录</a>
            <a href="${pageContext.request.contextPath}/register/page">注册</a>
        </c:if>
        <c:if test="${!empty user}">
            <a href="${pageContext.request.contextPath}/home/users/${user.id}">${user.userNickName}的空间</a>
            <c:forEach items="${user.roles}" var="role" end="${end}">
                    <c:if test="${!(role.id eq 13 or role.id eq 14)}">
                        <a href="${pageContext.request.contextPath}/admin">后台管理</a>
                        <c:set var="end" value="0"></c:set>
                    </c:if>
            </c:forEach>
            <c:if test="${!found}">
            </c:if>
            <a href="${pageContext.request.contextPath}/logout">退出</a>
        </c:if>
    </div>
    <div class="header_right pull-right">
        <c:forEach items="${menus}" var="menu">
            <a href="${pageContext.request.contextPath}${menu.menuLink}"><span
                    class="${menu.menuIcon}"></span>${menu.menuName}</a>
        </c:forEach>
    </div>
</header>
