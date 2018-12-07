<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: HASEE
  Date: 2018/10/15
  Time: 15:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>$Title$</title>
    <link rel="stylesheet" href="userModule/userModuleCss/user_login.css">
    <link rel="stylesheet" href="userModule/userModuleCss/error_Color.css"/>
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

</head>
<body>

Language:
<select id="mySelect" onchange="changeLanguage(this)">
    <option value="">默认</option>
    <option value="zh_CN">中文</option>
    <option value="en_US"><s:property value="getText('language.English')"/></option>
</select>
<div class="login-content">
    ${requestScope.LoginError}
    <form action="User_login.action" method="post" class="login_form">
        <div class="form_text">
            <input type="text" placeholder="<s:property value="getText('login.username')"/>" name="user.username"
                   class="user_text" id="username"/>

            <input type="password" placeholder="<s:property value="getText('login.password')"/>" name="user.password"
                   class="user_text"/>
            <p style="margin-top: -5px;margin-left: 15px;color: red;" id="content">
                ${requestScope.error.loginError}
                <%--<s:property value="exception.value"/>--%>
            </p>
        </div>


        <div>
            验证码:<input type="text" name="imageText" style="height: 30px;width: 70px;">
            <img src="verifyCode.action"/>
            <input type="button" value="看不清? 换一张." id="btn"><font color="red">${requestScope.ImageError}</font>
        </div>
        <br>
        <p class="error_color">
            ${requestScope.error.imageError}
        </p>
        <input type="submit" value="<s:property value="getText('login.Btn')"/>" class="submit_btn">
    </form>

    <button type="button" onclick="register()"><s:property value="getText('register.Btn')"/></button>
</div>

<script type="text/javascript">

    $(function(){
        $("#sub").click(function(){
            var user_value=$("input[name='username']").val();
            var pass_value=$("input[name='password']").val();

            if(user_value===""){
                 $("#content1").html("不能为空");
                return false;
            }
            if(pass_value===""){
                $("#content1").html("密码不能为空");
                return false;
            }
            var params={
                username : user_value,
                password : pass_value
            };

            $.ajax({
                url:"login.action",
                type:"post",
                data:params,
                dataType:"json",
                success:function(data,textStatus){
                    $("#content1").html(data);
                },
                error:function(data,textStatus){
                    return false;
                }

            });
        });


    });

    document.getElementById("btn").onclick = function () {
        // 获取img元素
        // 为了让浏览器发送请求到servlet, 所以一定要改变src
        document.getElementsByTagName("img")[0].src =
            "verifyCode.action?time=" + new Date().getTime();
    };

    function register() {
        window.location.href = "register.jsp";
    }

    function changeLanguage(id) {
        var lang = id.options[id.selectedIndex].value;
        var mySelect = document.getElementById("mySelect");
        location.href = "User_language?request_locale=" + lang;
    }

</script>
</body>
</html>
