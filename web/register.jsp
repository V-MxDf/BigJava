<%--
  Created by IntelliJ IDEA.
  User: HASEE
  Date: 2018/11/7
  Time: 19:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>XV</title>
</head>
<body>
<div>
    <form action="User_register.action" method="post">
        <input type="text" placeholder="Account" name="user.username"/><br/>
        ${requestScope.error.registerName}
        <input type="text" placeholder="Email" name="user.email" id="email"><br/>
        ${requestScope.error.registerEmail}
        <input type="password" placeholder="Password" name="user.password"><br/>
        <input type="password" placeholder="RePassword" name="RePassword"><br/>
        ${requestScope.error.registerPas}

        <input type="submit" value="注册" onclick="return code()">
    </form>
</div>
<script>
    function code() {
        var email = document.getElementById('email').value;
        if (email != null && email !== "") {
            var reg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
            ok = reg.test(email);
            if (!ok) {
                alert("邮箱格式不正确，请重新输入！");
                return false;
            } else {
                alert("验证邮箱已发送，请前去激活!");
                return true;
            }
        }
    }
</script>
</body>
</html>
