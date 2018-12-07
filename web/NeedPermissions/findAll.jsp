<%--
  Created by IntelliJ IDEA.
  User: HASEE
  Date: 2018/10/31
  Time: 20:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1>This is add.jsp</h1>
<table>
    <tr>
        <td>用户</td>
    </tr>
    <c:forEach items="${sessionScope.list}" var="user">
        <tr>
            <td>
                    ${user.username}
            </td>
        </tr>

    </c:forEach>
</table>
    <a href="Permissions/Permissions_findAll.action?indexPage=${sessionScope.indexPage-1}" >下一页</a>
    <a href="Permissions/Permissions_findAll.action?indexPage=${sessionScope.indexPage+1}" >上一页</a>
</body>
</html>
