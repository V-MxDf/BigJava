<%@ taglib prefix="s" uri="/struts-tags" %>
<%--
  Created by IntelliJ IDEA.
  User: new Thread().start()
  Date: 2018/12/3
  Time: 8:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <script src="../js/jquery.min.js"></script>
    <title>邀请回答</title>
    <link rel="stylesheet" href="question/questionCss/invite.css"/>

    <style>
            .followB{

                background-color: #0084FF;
            }

        .closeB{

            background-color: #6f6f6f;
        }


    </style>

</head>
<body>
<div class="Zhihu_top" id="top_id">
    <div class="top_nav">
        <a href="http://www.zhihu.com" title="知乎" class="Zhihu_font">

            BigJava

        </a>

        <ul class="top_ul">
            <li>
                <a id="zt">首页</a>
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

    </div>
</div>
<s:iterator value="questionList" var="question">

</s:iterator>
<%--问题--%>
<div class="question_content">
    <div class="question_title">
        <s:property value="#question.questionTitle"/>
    </div>
    <div class="question_footer">



        <s:if test="%{follow.state == 1}">
            <button id="btn" class="follow" onclick="show()">已关注</button>
        </s:if>
        <s:else>
            <button id="btn" class="follow_btn" onclick="show()">关注</button>
        </s:else>
        <script>
            function ajax() {
                $.ajax({
                    url: "question_followQuestion.action",
                    type: "post",
                    //传个id
                    data: {'follow.questionId': '<s:property value="#question.id"/>'},
                    success: function (data) {
                    },
                    error: function (data) {
                        alert("关注失败");
                    }
                })
            }

                function show() {
                    var btn = document.getElementById("btn");
                    //如果是已关注状态,点击取消关注
                    if(btn.className=="follow") {
                        btn.className = "follow_btn";
                        btn.innerHTML="关注";
                        ajax();
                    }else{
                        //未关注
                        btn.className="follow";
                        btn.innerHTML="已关注";
                        ajax();
                    }
                }
        </script>
        <button class="write_btn" type="button">写回答</button>
        <input type="hidden" name="follow.questionId" value="<s:property value='#question.id'/>"/>
    </div>
</div>
<div class="comment">
    <form id="answerForm" method="post">
        <input type="text" placeholder="写回答..."
               style="width: 600px;height:150px;border: none;outline: none;padding-bottom: 120px;padding-left: 10px"
               name="answer.answer_content" id="answerInput">
        <input type="submit" value="评论" class="comment_Btn">
    </form>
</div>
<%--答案--%>
<div class="answer_main">
    <s:iterator value="list" var="answer">
        <div class="answer_content">
                <%--用户名--%>
            <div class="answer_user">
                <a href="#">
                    <s:iterator value="#answer.userList" var="user">
                        <img src="/photo/<s:property value="#user.image"/> " id="user_image" style=""/>
                        <span style="position:relative;bottom:23px;">
                <s:property value="#user.username"/>
                    </span>
                    </s:iterator>
                </a>
            </div>
            <s:property value="answer_content"/>
        </div>
    </s:iterator>
</div>
<script type="text/javascript">
    $(function () {
        $("#zt").click(function(){
            alert("go")
            location.href="index.jsp";
        });
        $("#answerForm").submit(function () {
            $.ajax({
                url: "question_addAnswer.action",
                type: "post",
                data: $("#answerForm").serialize(),
                success: function (data) {

                },
                error: function (data) {
                    alert("失败");
                }
            })
        });
        $(".write_btn").click(function () {
            $(".comment").slideToggle();
        });
    })
</script>
</body>
</html>
