<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: new Thread().start()
  Date: 2018/12/4
  Time: 11:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="userModule/userModuleCss/userInfo.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
          integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <title>个人资料</title>
</head>
<body style="background-color: #F6F6F6">
<div class="Header">
    <div class="user_info">
        <div class="user_info_right">
            <h1>
                <s:iterator value="list" var="user">
                    <s:property value="#user.username"/>
                </s:iterator>
            </h1>
            <form class="Filed">
                <h5>性别</h5>
                <div class="Filed_info">
                <s:property value="#user.sex"/>
                    <button class="update" lay-id="update_1">修改</button>
                    <div id="div5" style="border:1px solid red;width: 180px;height: 60px;display:none;">
                        <input type="radio" value="男" />男
                        <input type="radio" value="女" />女

                        <br />
                        <input type="submit" value="保存" />
                        <input type="reset" value="取消" />

                    </div>
                </div>

            </form>
            <form class="Filed">
                <h5>年龄</h5>
                <div class="Filed_info">
                    <s:property value="#user.age"/>
                    <button class="update" lay-id="update_2">修改</button>
                </div>
            </form>
            <form class="Filed">
                <h5>居住地</h5>
                <div class="Filed_info">
                    <s:property value="#user.address"/>
                </div>
            </form>
            <form class="Filed">
                <h5>Email</h5>
                <div class="Filed_info">
                    <s:property value="#user.email"/>
                </div>
            </form>
        </div>
    </div>
</div>
<%--<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"--%>
        <%--integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"--%>
        <%--crossorigin="anonymous"></script>--%>
<%--<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"--%>
        <%--integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"--%>
        <%--crossorigin="anonymous"></script>--%>
<%--<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"--%>
        <%--integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"--%>
        <%--crossorigin="anonymous"></script>--%>
<script>
    $(function () {
        $(".update").hide();
        $(".Filed_info > input").hide();
       $(".Filed").hover(
            function () {
                $(this).find(".update").show();
                $(this).find(".update").click(function () {
                    $("#div5").show();
0                })
            },
            function () {
                $(this).find(".update").hide();
            }
        );

    });

</script>
</body>
</html>
