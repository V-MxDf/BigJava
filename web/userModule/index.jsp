<%@ page import="com.bigjava.bean.User" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="c" uri="/struts-tags" %>
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
    <script src="../js/jquery.min.js"></script>
    <%--<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"--%>
    <%--integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"--%>
    <%--crossorigin="anonymous">--%>

</head>
<%
    User user = (User) request.getSession().getAttribute("loginSuccess");
    if (user == null) {
        request.setAttribute("LoginError", "请登录");
        request.getRequestDispatcher("userModule/login.jsp").forward(request, response);
    }
%>
<%----%>
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
        <s:iterator value="errorMap" var="map">
            <div class="Item">
                <div class="questionAndAnswer">
                        <%--问题--%>
                    <s:iterator value="#map.key" var="question">
                        <div class="question">
                            <a href="#">
                                <s:property value="#question.questionTitle"/>
                            </a>
                        </div>
                    </s:iterator>
                        <%--答案--%>
                    <div class="answer">
                        <s:iterator value="#map.value" var="answer">
                            <s:property value="#answer.answer_content"/>
                        </s:iterator>
                    </div>
                    <div class="ContentItem-actions">
                        <div>
                            <button type="button" title="赞同" class="likeBtn b" id="like">
                                <span class="Triangle positiveTriangle-blue"></span>
                                赞同
                                <span class="likeNum"><s:property value="#answer.liked"/> </span>
                                <input type="hidden" id="answerId" class="answerId" value='<s:property value="#answer.id"/> '/>
                            </button>
                            <button type="button" title="反对" class="dislike dis">
                                <span class="antiTriangle antiTriangle-blue"></span>
                            </button>
                            <button class="Comment c " type="button" id="Comment">
                                <img src="../image/index/comment.svg" style="margin-bottom: 5px;margin-right: 2px"/>
                                29条评论
                            </button>

                            <button class="Comment" type="button">
                                <img src="../image/index/share.svg" style="margin-bottom: 5px;margin-right: 2px"/>
                                分享
                            </button>
                            <button class="Comment" type="button">
                                <img src="../image/index/collection.svg" style="margin-bottom: 5px;margin-right: 2px"/>
                                收藏
                            </button>
                            <button class="Comment" type="button">
                                <img src="../image/index/like.svg" style="margin-bottom: 5px;margin-right: 2px"/>
                                感谢
                            </button>
                            <button class="Comment" type="button">
                                <img src="../image/index/more.svg" style="margin-bottom: 5px;margin-right: 2px"/>
                            </button>
                        </div>
                    </div>
                </div>
                <div style="" class="show_Comment">
                    <div class="Topbar" >
                        <sapn style="">
                            <span>29条评论</span>
                        </sapn>
                        <sapn style="float:right;">
                            <button type="button" class="Comment">切换为时间排序</button>
                        </sapn>
                    </div>
                    <div class="subComment">
                        <input type="text" class="commentContent" name="comment.commentContent"/>
                        <button type="button" class="subCommentBtn follow_btn" >
                            发布
                        </button>
                    </div>
                </div>
            </div>
        </s:iterator>
    </div>
    <div class="Zhihu_right" id="float">

        <div class="Zhihu_right_top" id="right_top_id">
            <a href="pagination.action" class="write_answer my-item">写回答</a>
            <a href="#" class="write_answer my-item">写文章</a>
            <a href="#" class="write_answer my-item">写想法</a>
        </div>

        <div class="Zhihu_right_middle" id="right_middle_id">

            <ul class="live_ul">
                <li>

                    <a href="#" class="live_Book">
                        <img src="../image/index/Live.png" class="live_Img"/>
                        <nobr class="live_Font my-item">Live</nobr>

                    </a>
                </li>
                <li>
                    <a href="#" class="live_Book">
                        <img src="../image/index/Book.png" class="live_Img"/>
                        <nobr class="live_Font my-item">书店</nobr>
                    </a>
                </li>
                <li>
                    <a href="#" class="live_Book">
                        <img src="../image/index/圆桌.png" class="live_Img"/>
                        <nobr class="live_Font my-item">圆桌</nobr>
                    </a>
                </li>

                <li>
                    <a href="#" class="live_Book">
                        <img src="../image/index/专栏.png" class="live_Img"/>
                        <nobr class="live_Font my-item">专栏</nobr>
                    </a>
                </li>

                <li>
                    <a href="#" class="live_Book">
                        <img src="../image/index/付费咨询.png" class="live_Img"/>
                        <nobr class="live_Font_1 my-item">付费咨询</nobr>
                    </a>
                </li>
            </ul>
        </div>

        <div class="Zhihu_right_bottom" id="right_bottom_id">
            <ul class="my_Follow">
                <li>
                    <a href="#" class="my-item">我的收藏</a>
                </li>
                <li>
                    <a href="#" class="my-item">我关注的问题</a>
                </li>
                <li>
                    <a href="pagination.action" class="my-item">我的邀请</a>
                </li>
                <li>
                    <a href="#" class="my-item">我的礼券</a>
                </li>
                <li>
                    <a href="#" class="my-item">社区服务中心</a>
                </li>
                <li>
                    <a href="#" class="my-item">版权服务中心</a>

                </li>
            </ul>
        </div>

        <div class="Zhihu_ring_bottom_info" style="padding-top: 10px">
            <a class="Footer-item" href="#">bigjava&nbsp;·</a>
            <a class="Footer-item" href="#">bigjava·指南&nbsp;·</a>
            <a class="Footer-item" href="#">协议&nbsp;·</a>
            <a class="Footer-item" href="#" style="display: inline-block">隐私保护指引</a><br/>
            <a class="Footer-item" href="#">应用&nbsp;·</a>
            <a class="Footer-item" href="#">工作&nbsp;·</a>
            <a class="Footer-item" href="#">申请开通bigjava机构号</a><br/>
            <a class="Footer-item" href="https://zhuanlan.zhihu.com/p/51068775">侵权举报</a>
            <span class="Footer-dot"></span>
            <a class="Footer-item" target="_blank" href="http://www.12377.cn">网上有害信息举报专区</a><br/>
            <span class="Footer-item">违法和不良信息举报：010-82716601</span><br/>
            <a class="Footer-item" target="_blank" href="/jubao">儿童色情信息举报专区</a><br/>
            <a class="Footer-item" target="_blank">电信与服务业务经营许可证</a><br/>
            <a class="Footer-item" target="_blank" href="/contact">联系我们</a>
            <span> © 2018 BigJava</span>
        </div>

    </div>
</div>
<div id="light" class="white_content">
    <form method="post" id="question_form">
        <input type="text" name="question.questionTitle" placeholder="写下你的问题" class="ask_question"
               id="search_question"/><br/>
        <p class="questionTitle_error" style="color: red;"></p>
        <div class="search_title_div"></div>
        <input type="text" name="topic.topicTitle" placeholder="选择话题" id="search_Topic"
        />
        <p class="question_classification_error" style="color: red;"></p>
        <div class="q_con" style="width: 162px;border: 1px solid #cccccc"></div>
        <s:property value="exception.message"/>
        <input type="button" value="发布问题" class="questionBtn"/>
    </form>
    <%--<a href = "javascript:void(0)" onclick = "document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'">--%>
    <%--点这里关闭本窗口</a>--%>
    <span id="close"><a href="javascript:void(0)">点这里关闭</a></span>

</div>
<div id="fade" class="black_overlay"></div>

<script>

    $(function () {
        /*评论*/
     /*   $(".subCommentBtn").click(function () {
            $.ajax()
        });*/
        /*显示评论div*/
        $(".c").click(function () {
            /*拿到顶级父元素*/
            var Item = $(this).parent().parent(".ContentItem-actions").parent(".questionAndAnswer").parent(".Item");
            /*要显示的div*/
            var comment = Item.find($(".show_Comment"));
            /*答案id*/
            var answerId = Item.find($(".answerId")).val();
            /*评论内容*/
            /*此评论按钮*/
            var sub = comment.find($(".subCommentBtn"));

            sub.click(function () {
                commentContent = comment.find($(".commentContent")).val();
                $.ajax({
                    url:"comment.action",
                    type:"post",
                    data: {'comment.answerId': parseInt(answerId), 'comment.commentContent': commentContent},
                    success:function (data) {
                         // comment.find($(".commentContent")).val(" ") ;
                        alert("发布成功");
                    },
                    error:function (data) {
                        alert("请检查你的网络连接");
                    }
                })
            });
            comment.toggle();
        });
        /*赞同*/
        $(".b").click(function () {
            var like = $(this);
            var likeNum = $(this).find($(".likeNum")).text();
            //用算法变成数字类型 减一加一
            var disLikeNum = likeNum - 1 + 1;
            var answerId = $(this).find($("#answerId")).val();
            //判断是否已赞同
            if (like.hasClass("liked")) {
                //替换添加class
                like.attr("class", "likeBtn b");
                like.html('<span class="Triangle positiveTriangle-blue"></span>' + "赞同" + '<span class="likeNum">' + (disLikeNum - 1) + '</span>');
            } else {
                $.ajax({
                    url: "liked.action",
                    type: "post",
                    data: {'answer.id': parseInt(answerId), 'answer.liked': parseInt(disLikeNum)},
                    success: function (data) {
                        like.html('<span class="Triangle positiveTriangle-write"></span>' + "已赞同"
                            + '<span class="likeNum ">' + (data.answer.liked) + '</span>');
                    },
                    error: function (data) {
                        like.html('<span class="Triangle positiveTriangle-write"></span>' + "已赞同"
                            + '<span class="likeNum">' + (disLikeNum + 1) + '</span>');
                    }
                });
                like.attr("class", "liked b ");
            }
        });
        /*反对*/
        $(".dis").click(function () {
            var like = $(this);
            if (like.hasClass("unDis")) {
                //替换添加class
                like.attr("class", "dislike dis");
                like.html('<span class="antiTriangle antiTriangle-blue"></span>');
            } else {
                like.attr("class", "unDis dis ");
                like.html('<span class="antiTriangle antiTriangle-write"></span>');
            }
        });
        $(".questionBtn").click(function () {

            if ($("#search_Topic").val() == "") {
                $(".question_classification_error").html("请选择分类?");
                $("#light").show();
                return false;
            }
            if ($(".ask_question").val() == "") {
                $(".questionTitle_error").html("请写下你的问题");
                return false;
            }
            $.ajax({
                url: "ask.action",
                type: "post",
                dataType: "json",
                data: $("#question_form").serialize(),
                success: function (data) {
                    alert("发布成功");
                    $("#light").fadeOut(500, "swing");
                    $("#fade").fadeOut(500, "swing");
                    $("#body").css("overflow-x", "hidden");

                },
                error: function (data) {
                    alert("filed");
                }
            })
        });
        /*展开提交问题div*/
        $(".question_Btn").click(function () {
            $(".question_classification_error").html("");
            $(".questionTitle_error").html("");
            $("#light").fadeIn(500);
            $("#fade").fadeIn(500);
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
            $(".search_title_div").html("");
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
            var Zhihu_right_middle = document.getElementById("right_middle_id");
            var Zhihu_right_bottom = document.getElementById("right_bottom _id");
            var s = document.body.scrollTop || document.documentElement.scrollTop;
            if (s > 290) {
                oDiv.style = "position:fixed;top:50px;width:296px;;height: 70px;";
                id.style = "display:none";
                Zhihu_right_middle.style = "display:none";
            } else {
                Zhihu_right_middle.style = "";
                id.style = "";
                oDiv.style = "";
            }
        };
    });

</script>
<%--<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
        integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
        integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
        crossorigin="anonymous"></script>--%>
</body>
</html>

