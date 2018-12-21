<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: new Thread().start()
  Date: 2018/11/22
  Time: 17:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="question/questionCss/question.css"/>
    <script src="../js/jquery.min.js"></script>
</head>
<body>
<div class="question_top">
    <div class="top_nav">
        <a href="http://www.zhihu.com" title="知乎" class="Zhihu_font">

            知乎

        </a>
        <input type="text" class="top_Search" placeholder="搜索你感兴趣的内容吧~"/>

        <ul class="top_ul">
            <li>
                <p id="zt">首页</p>

            </li>
            <li>
                <a href="#">发现</a>
            </li>
            <li>
                <a href="question_showAllTopic.action">话题</a>
            </li>

        </ul>

        <button type="button" class="question_Btn" onclick="opn()">
            提问
        </button>

    </div>
</div>

<div class="content">
    <s:iterator value="list" var="question">
        <s:debug></s:debug>
        <div class="questionTitle">
                        <a href="question_showAnswer.action?question.id=<s:property value='id'/>">
                            <s:property value="questionTitle"/>
                        </a>
                        <div class="invite">
                                邀请你来回答
                            <span><s:property value=""/></span>
                        </div>
        </div>
    </s:iterator>
    <a href="pagination.action?pager.indexPage=<s:property value="pager.indexPage-1"/>">上一页</a>

    <a href="pagination.action?pager.indexPage=<s:property value="pager.indexPage+1"/> ">下一页</a>
</div>
<s:debug></s:debug>
<script type="text/javascript">
    $(function () {
        $("#zt").click(function () {
           window.location.href="index.jsp";
        });
    })
</script>
</body>
</html>
