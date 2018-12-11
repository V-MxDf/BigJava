<%@ page import="com.bigjava.bean.User" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: HASEE
  Date: 2018/10/15
  Time: 16:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="userModule/userModuleCss/index.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <%--<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"--%>
          <%--integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"--%>
          <%--crossorigin="anonymous">--%>
    <style type="text/css">

    </style>
</head>
<%
    User user = (User) request.getSession().getAttribute("loginSuccess");
    if (user == null) {
        request.setAttribute("LoginError", "请登录");
        request.getRequestDispatcher("userModule/login.jsp").forward(request, response);
    }
%>
<body id="body">
<div class="Zhihu_top" id="top_id">
    <div class="top_nav">
        <a href="http://www.zhihu.com" title="知乎" class="Zhihu_font">

            知乎

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

<div id="root">

    <div class="Zhihu_center">
        <s:iterator value="set.value" var="answer">
            <s:property value="#answer.id"/>
        </s:iterator>
        <s:iterator value="errorMap" var="map">
            <%--问题--%>
        <s:iterator value="#map.key" var="question">
            <div class="question" style="border: 1px solid red;">
            <s:property value="#question.questionTitle"/>
            </s:iterator>
                <%--答案--%>
            <div class="answer">
                <s:iterator value="#map.value" var="answer">
                    <s:property value="#answer.answer_content"/>
                </s:iterator>
            </div>

            </s:iterator>
        </div>

    </div>

    <div class="Zhihu_right" id="float">
        <div class="Zhihu_right_top" id="right_top_id">
            <a href="pagination.action" class="write_answer">写回答</a>
            <a href="#" class="write_answer">写文章</a>
            <a href="#" class="write_answer">写想法</a>
        </div>


        <div class="Zhihu_right_middle">

            <ul class="live_ul">
                <li>

                    <a href="#" class="live_Book">
                        <img src="../image/index/Live.png" class="live_Img"/>
                        <nobr class="live_Font">Live</nobr>

                    </a>
                </li>
                <li>
                    <a href="#" class="live_Book">
                        <img src="../image/index/Book.png" class="live_Img"/>
                        <nobr class="live_Font">书店</nobr>
                    </a>
                </li>
                <li>
                    <a href="#" class="live_Book">
                        <img src="../image/index/圆桌.png" class="live_Img"/>
                        <nobr class="live_Font">圆桌</nobr>
                    </a>
                </li>

                <li>
                    <a href="#" class="live_Book">
                        <img src="../image/index/专栏.png" class="live_Img"/>
                        <nobr class="live_Font">专栏</nobr>
                    </a>
                </li>

                <li>
                    <a href="#" class="live_Book">
                        <img src="../image/index/付费咨询.png" class="live_Img"/>
                        <nobr class="live_Font_1">付费咨询</nobr>
                    </a>
                </li>
            </ul>
        </div>

        <div class="Zhihu_right_bottom">
            <ul class="my_Follow">
                <li>
                    <a href="#" class="">我的收藏</a>
                </li>
                <li>
                    <a href="#" class="">我关注的问题</a>
                </li>
                <li>
                    <a href="#" class="">我的邀请</a>
                </li>
                <li>
                    <a href="#" class="">我的礼券</a>
                </li>
                <li>
                    <a href="#" class="">社区服务中心</a>
                </li>
                <li>
                    <a href="#" class="">版权服务中心</a>

                </li>
            </ul>
        </div>
    </div>
</div>
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
    <%--<a href = "javascript:void(0)" onclick = "document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'">--%>
    <%--点这里关闭本窗口</a>--%>
    <span id="close"><a href="javascript:void(0)">点这里关闭</a></span>

</div>
<div id="fade" class="black_overlay"></div>

<script>
    function ask() {
        $("form").bind('submit', function () {
            var v = $("#search_Topic").val();
            if (v == "") {
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
    }

    $(function () {
        /*展开提交问题div*/
        $(".question_Btn").click(function () {
            $("#light").fadeIn(500, "linear");
            $("#fade").fadeIn(500, "linear");
        });
        /*收起*/
        $("#close").click(function () {
            $("#light").fadeOut(500, "swing");
            $("#fade").fadeOut(500, "swing");
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


        //滚轮隐藏
        window.onscroll = function () {
            var oDiv = document.getElementById("float");
            var id = document.getElementById("right_top_id");
            var top_id = document.getElementById("top_id");
            var s = document.body.scrollTop || document.documentElement.scrollTop;
            if (s > 100) {
                oDiv.style = "position:fixed;top:50px;width:296px;;height: 170px;";
                id.style = "display:none;";
            } else {
                id.style = "";
                oDiv.style = "";
                top_id.style = "";
            }
        };
    });

</script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
        integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
        integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
        crossorigin="anonymous"></script>
</body>
</html>

