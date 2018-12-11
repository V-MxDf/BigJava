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
    <script src="../js/jquery.form.js"></script>
    <title>个人资料</title>
    <script type="text/javascript">
        <!--
        $(function () {
            //当文件改变是触发的事件
            $("#file").change(function () {
                $(".fide").show();
                $(".confirm_sub").show();
                $(".img_msg").html("");
                var $var_option = {
                    url: 'login.action',
                    dataTpye: 'json',
                    type: "post",
                    //成功时触发的函数
                    success: function (data) {
                        var $data = jQuery.parseJSON(data);
                        //获取文件路径
                        var $img = $data.path;
                        //动态添加标签
                        // $("#user_image").attr("src", $img);
                        $("#block_img").attr("src",$img);
                        // $("#showing").html("<img src='" + $img + "'   style='width:100px;height:100px;'/>");
                    },
                    error: function () {
                        alert("上传失败");
                    }
                };
                $("#myform").ajaxSubmit($var_option);

            });
            //关闭div
            $(".close").click(function () {
                $(".fide").hide();
                $(".confirm_sub").hide();
            });
            //确认修改图片
            $("#confirm_btn").click(function () {
                $.ajax({
                    url: "update.action",
                    type: "post",
                    clearForm: true,
                    success: function (data) {
                        var $data = jQuery.parseJSON(data);
                        //获取文件路径
                        var $img = $data.userPath;
                        $(".img_msg").html("保存成功");
                        $(".img_msg").append("<p>俩秒后消失</p>");
                        setTimeout( '$(".fide").fadeOut()',1500);
                        setTimeout( '$(".confirm_sub").fadeOut()',1500);
                        $("#user_image").attr("src",$img);
                    },
                    error: function (data) {
                        alert("失败");
                    }
                })
            });
            //鼠标停留在头像上
            $("#main").hover(
                function () {
                    $(".show_back").show();
                }, function () {
                    $(".show_back").hide();
                }
            );
            $(".show_back").click(function () {
                $("#file").click();
            })
        })
        //-->
    </script>
</head>
<body style="background-color: #F6F6F6;z-index: 0">
<s:iterator value="list" var="user">
</s:iterator>
<div class="Header">

    <div class="confirm_sub">
        <div class="close_div">
            <button class="close">
                &times;
            </button>
        </div>
        <div>
            <div class="test"></div>
            <img src="/photo/<s:property value="#user.image"/> " id="block_img" style=""/>
            <button type="button" id="confirm_btn">保存</button>
            <p class="img_msg"></p>
        </div>
    </div>

    <div class="user_info">
        <hr/>
        <div id="main" style="">
            <form id='myform' method='post' enctype='multipart/form-data'>
                <input id="file" type="file" name="upload" style="display: none"/>
                <div id="showing">
                    <div  class="show_back">修改头像
                    </div>
                    <img src="/photo/<s:property value="#user.image"/> " id="user_image" style=""/>
                </div>
            </form>
        </div>


        <s:if test="%{#user.image == null}">
            <img src="/photo/<s:property value="#user.image"/> "/>
        </s:if>

        <div class="user_info_right">
            <h1 id="uname">
                <s:property value="#user.username"/>
            </h1>
            <form class="Filed">
                <h5>性别</h5>
                <div class="Filed_info">
                    <s:property value="#user.sex"/>
                    <button class="update" lay-id="update_1">修改</button>
                    <div id="div5" style="border:1px solid red;width: 180px;height: 60px;display:none;">
                        <input type="radio" value="男"/>男
                        <input type="radio" value="女"/>女

                        <br/>
                        <input type="submit" value="保存"/>
                        <input type="reset" value="取消"/>

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
<div class="fide"></div>

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
                    0
                })
            },
            function () {
                $(this).find(".update").hide();
            }
        );
    });

</script>
</body>
</html>
