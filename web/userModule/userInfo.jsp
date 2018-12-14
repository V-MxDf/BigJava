<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="c" uri="/struts-tags" %>
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

    <script src="../js/jquery.min.js"></script>
    <script src="../js/jquery.form.js"></script>
    <title>个人资料</title>
    <script type="text/javascript">
        var file_sex;
        var file_address;
        var file_Age;
        var file_Email;
        $(function () {
            //当文件改变是触发的事件
            $("#file").on('change', function () {
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
                        $("#block_img").attr("src", $img);
                    },
                    error: function () {
                        alert("上传失败");
                    }

                };
                $("#myform").ajaxSubmit($var_option);
                $("#file").val("");
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
                        setTimeout('$(".fide").fadeOut()', 1500);
                        setTimeout('$(".confirm_sub").fadeOut()', 1500);
                        $("#user_image").attr("src", $img);
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
            });
            //关闭div
            $(".close").click(function () {
                $(".fide").hide();
                $(".confirm_sub").hide();
                $("#light").fadeOut(500, "swing");
                $(".fide").fadeOut(500, "swing");
                $("#body").css("overflow-x", "hidden");
            });

            $("#question_form").bind('submit', function () {
                var v = $("#search_Topic").val();
                if (v == "" || v.trim(v)) {
                    $(".question_classification_error").html("请选择分类");
                    $("#light").show();
                    return false;
                }
                if ($(".ask_question").val() == "") {
                    $(".questionTitle_error").html("请写下你的问题");
                    return false;
                }
                return true;
            });
            /*展开提交问题div*/
            $(".question_Btn").click(function () {
                $(".question_classification_error").html("");
                $(".questionTitle_error").html("");
                $("#light").fadeIn(500, "linear");
                $(".fide").fadeIn(500, "linear");
            });
            //关闭div
            $(".close").click(function () {
                $(".fide").hide();
                $(".confirm_sub").hide();
                $("#light").fadeOut(500, "swing");
                $(".fide").fadeOut(500, "swing");
                $("#body").css("overflow-x", "hidden");
            });
            //话题联想
            $("#search_Topic").keyup(function () {
                var text1 = $("#search_Topic").val();
                $(".q_con").html("");
                var params = {
                    result: text1
                };
                $.ajax({
                    url: "ajax.action",
                    type: "post",
                    data: params,
                    dataType: "json",
                    success: function (data, textStatus) {
                        if (data.result != "") {
                            $.each(data.list, function (i, value) {
                                $(".q_con").append("<div class='query_value'>" + value + "</div>");
                            });
                            //显示，点击替换并隐藏
                            $(".q_con").show();
                            $(".query_value").click(function () {
                                $("#search_Topic").val($(this).text());
                                $(".q_con").hide();
                            });
                        } else {
                            $(".q_con").hide();
                        }

                    },
                    error: function (data, textStatus) {
                    }
                })
            });

            //联想问题
            $("#search_question").keyup(function () {
                var title = $("#search_question").val();
                var params = {
                    questionTitle: title
                };
                $.ajax({
                    url: "searchQuestion.action",
                    type: "get",
                    data: params,
                    dataType: "json",
                    success: function (data, textStatus) {
                        if (data.questionTitle != "") {
                            console.log(data.list);
                            $.each(data.list, function (i, value) {
                                $(".search_title_div").append("<div class='title_value'>" + value.questionTitle + "</div>");
                            });
                            //显示，点击替换并隐藏
                            $(".search_title_div").show();
                            $(".title_value").click(function () {
                                $("#search_question").val($(this).text());
                                $(".search_title_div").hide();
                            });
                        } else {
                            $(".search_title_div").hide();
                        }
                    },
                    error: function (data, textStatus) {

                    }
                })
            });
            //进入个人资料
            $(".user_btn").click(function () {
                window.location = "User_userInfo.action";
            });
            //点击修改性别
            var but = $("#update_Sex");
            $("#update_Sex ").click(function () {
                //取得修改按钮的父元素
                var parent = $(this).closest(".Filed_info");
                //保存父元素下的值，下面好替换
                file_sex = parent.detach();
                $("#filed_Sex").show();

            });
            //点击修改地址
            $("#update_Address").click(function () {
                var parent = $(this).closest(".Filed_info");
                //保存父元素下的值，下面好替换
                file_address = parent.detach();
                $("#filed_Address").show();
            });
            //点击修改出生年月
            $("#update_Age").click(function () {
                var parent = $(this).closest(".Filed_info");
                //保存父元素下的值，下面好替换
                file_Age = parent.detach();
                $("#filed_Age").show();
            });
            //点击修改邮箱
            $("#update_Email").click(function () {
                var parent = $(this).closest(".Filed_info");
                //保存父元素下的值，下面好替换
                file_Email = parent.detach();
                $("#filed_Email").show();
            });
            //鼠标移动显示修改字体 确认修改不能放在这里，否则出现递归现象
            $(".Filed").hover(
                function () {
                    $(this).find(".update").show();
                },
                function () {
                    $(this).find(".update").hide();
                }
            );
//确认修改
            $(".sex_sub").click(function () {
                cancel();
                $.ajax({
                    url: "updateInfo.action",
                    type: "POST",
                    dataType: "json",
                    async: false,
                    data: $(".Filed").serialize(),
                    success: function (data) {
                        $(".show_sex").html(data.sex);
                        $(".show_age").html(data.age);
                        $(".show_address").html(data.address);

                    },
                    error: function (data) {
                        alert("filed");
                    }
                })
            });
        });


        //    取消更改
        function cancel() {
            $("#filed_Sex").hide();
            $("#filed_Address").hide();
            $("#filed_Age").hide();
            $("#filed_Email").hide();
            //由于技术问题无法还原，直接新的div替换
            $(".sex").show();
            $(".address").show();
            $(".age").show();
            $(".email").show();
            //还原性别
            $(".sex").prepend(file_sex);
            $(".address").prepend(file_address);
            $(".age").prepend(file_Age);
            $(".email").prepend(file_Email);
        }
    </script>
</head>
<body style="background-color: #F6F6F6;">

<s:iterator value="list" var="user">
</s:iterator>
<%--导航--%>
<div class="Zhihu_top" id="top_id">
    <div class="top_nav">
        <a href="http://www.zhihu.com" title="知乎" class="Zhihu_font">
            BigJava
        </a>
        <ul class="top_ul">
            <li>
                <a href="#">首页</a>
            </li>
            <li>
                <a href="#">发现</a>
            </li>
            <li>
                <a href="question_showAllTopic.action" id="topic">话题</a>
            </li>

        </ul>
        <input type="text" class="top_Search" placeholder="你认为最好听的广告音乐是哪首？"/>

        <button type="button" class="question_Btn">
            提问
        </button>
        <button class="user_btn" type="button">头像</button>

    </div>
</div>
<%--弹出div--%>
<div id="light" class="white_content">
    <form action="question_askQuestion.action" method="post" id="question_form">
        <input type="text" name="question.questionTitle" placeholder="写下你的问题" class="ask_question"
               id="search_question"/><br/>
        <p class="questionTitle_error" style="color: red;"></p>
        <div class="search_title_div"></div>
        <input type="text" name="topic.topicTitle" placeholder="选择话题" id="search_Topic"
        />
        <p class="question_classification_error" style="color: red;"></p>
        <div class="q_con" style="width: 162px;border: 1px solid #cccccc"></div>
        <s:property value="exception.message"/>
        <input type="submit" value="发布问题" onclick="return ask()"/>
    </form>
    <%--关闭按钮--%>
    <button class="close" style="outline: none">
        &times;
    </button>
</div>
<%--用户信息--%>
<div class="Header">
    <%--图片弹出--%>
    <div class="confirm_sub">
        <div class="close_div">
            <%--关闭按钮--%>
            <button class="close">
                &times;
            </button>
        </div>
        <img src="/photo/<s:property value="#user.image"/> " id="block_img" style=""/>
        <button type="button" id="confirm_btn">保存</button>
        <p class="img_msg"></p>
    </div>

    <%--用户信息--%>
    <div class="user_info">
        <%--修改头像--%>
        <div id="main">
            <form id='myform' method='post' enctype='multipart/form-data'>
                <input id="file" type="file" name="upload" style="display: none"/>
                <div id="showing">
                    <div class="show_back">修改头像
                    </div>
                    <img src="/photo/<s:property value="#user.image"/> " id="user_image" style=""/>
                </div>
            </form>
        </div>
        <%--<s:if test="%{#user.image == null}">
            <img src="/photo/<s:property value="#user.image"/> "/>
        </s:if>--%>
        <div class="user_info_right">
            <h1>
                <s:property value="#user.username"/>
            </h1>
            <%--Sex--%>
            <form class="Filed" method="post">
                <h5>性别</h5>
                <div class="Filed_info">
                    <span class="show_sex">
                        <s:property value="#user.sex"/>
                    </span>
                    <button class="update" id="update_Sex">修改</button>
                </div>
                <div class="sex" style="display: none">
                </div>
                <div id="filed_Sex" class="update_css">
                    <input type="radio" value="男" name="user.sex" id="nan"
                            <c:if test='%{#user.sex == "男"}'>
                                checked="true"
                            </c:if>
                    />男 &nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" value="女" name="user.sex" id="nv"
                            <c:if test='%{#user.sex == "女"}'>
                                checked="true"
                            </c:if>
                    />女
                    <br/>

                    <input type="button" value="保存" class="sex_sub" id="test"/>
                    <input type="button" value="取消" class="cancel" onclick="cancel()"/>
                </div>

            </form>

            <%--Age--%>
            <form class="Filed">
                <h5>年龄</h5>
                <div class="Filed_info">
                    <span class="show_age">
                        <s:property value="#user.age"/>
                    </span>
                    <button class="update" id="update_Age">修改</button>
                </div>
                <div class="age" style="display: none">
                </div>
                <div id="filed_Age" class="update_css">
                    <select name="user.year" id="select_year">
                        <option value="year">年</option>
                    </select>
                    <select name="user.month" id="select_month">
                        <option value="month">月</option>
                    </select>
                    <select name="user.day" id="select_day">
                        <option value="day">日</option>
                    </select>
                    <br/>
                    <input type="button" value="保存" class="sex_sub"/>
                    <input type="button" value="取消" class="cancel" onclick="cancel()"/>
                </div>
            </form>

            <%--Address--%>
            <form class="Filed">
                <h5>居住地</h5>
                <div class="Filed_info">
                    <span class="show_address">
                    <s:property value="#user.address"/>
                    </span>
                    <button id="update_Address" class="update">修改</button>
                </div>
                <div class="address" style="display: none">
                </div>
                <div id="filed_Address" class="update_css">
                    <input type="text" name="user.address" placeholder="地址" id="address_input"/>
                    <br/>
                    <input type="button" value="保存" class="sex_sub"/>
                    <input type="button" value="取消" class="cancel" onclick="cancel()"/>
                </div>
            </form>
            <%--Email--%>
            <form class="Filed">
                <h5>Email</h5>
                <div class="Filed_info">
                    <span class="show_email">
                        <s:property value="#user.email"/>
                    </span>
                    <button class="update" id="update_Email">修改</button>
                </div>
                <div class="email" style="display: none"></div>
                <div id="filed_Email" class="update_css">
                    <input type="text" placeholder="填写你的邮箱" name="user.email"/>
                    <input type="button" value="保存" class="sex_sub"/>
                    <input type="button" value="取消" class="cancel" onclick="cancel()"/>
                </div>
            </form>

        </div>
    </div>
</div>
<%--弹出背景--%>
<div class="fide"></div>
<%--Date--%>
<script type="text/javascript">

</script>
<script src="../js/Date.js"></script>
</body>
</html>
