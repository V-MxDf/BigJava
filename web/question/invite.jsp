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
    <script type="text/javascript">
        $(function () {
            $("#answerForm").submit(function () {
               $.ajax({
                   url:"addAnswer.action",
                   type:"post",
                   data:$("#answerForm").serialize(),
                   success:function (data) {

                   },
                   error:function (data) {
                       alert("失败");
                   }
               })
            });
        })
    </script>
</head>
<body>
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

    </div>
</div>
<%--问题--%>
<div class="question_content">
    <div class="question_title">
        <s:property value="questionTitle"/>
    </div>
    <div class="question_footer">
        <button class="follow_btn">关注问题</button>
        <button class="write_btn" type="button">写回答</button>
    </div>
</div>
<div class="comment">
    <form id="answerForm" method="post">
        <input type="text" placeholder="写回答..." style="width: 600px;height:150px;border: none;outline: none;padding-bottom: 120px;padding-left: 10px" name="ansewr.answer_content">
        <input type="submit" value="评论" class="comment_Btn">
    </form>
</div>
<%--答案--%>
<div class="answer_main">
    <s:iterator value="list" var="answer">
        <div class="answer_content">
            <%--用户名--%>
            <div class="answer_user">
            <s:iterator value="#answer.userList" var="user">
                <s:property value="#user.username"/>
            </s:iterator>
            </div>
            <s:property value="answer_content"/>
        </div>
    </s:iterator>
</div>
<script>
    $(function () {
        $(".write_btn").click(function () {
            $(".comment").slideToggle();
        })
    })
</script>
</body>
</html>
