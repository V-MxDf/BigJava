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
    <link rel="stylesheet" type="text/css" href="question/questionCss/topic.css"/>
</head>
<body>
<div class="question_top">
    <div class="top_nav">
        <a href="userModule/index.jsp" title="知乎" class="Zhihu_font">

            BigJava

        </a>
        <input type="text" class="top_Search" placeholder="搜索你感兴趣的内容吧~"/>

        <ul class="top_ul">
            <li>
                <a href="#">首页</a>
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
    <s:iterator value="list" var="topic">
        <div class="topic_content">
            <a href="question_showById.action?topic.id=<s:property value='id'/>" class="a_c" name="">
                <s:property value="#topic.topicTitle"/>
            </a
        </div>
    </s:iterator>
</div>
</body>
</html>
