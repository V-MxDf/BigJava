<%@ page import="com.bigjava.bean.Question" %>
<%@ page import="com.bigjava.bean.Topic" %>
<%@ page import="com.bigjava.biz.QuestionBiz" %>
<%@ page import="com.bigjava.biz.UserBizImpl.QuestionBizImpl" %>
<%@ page import="com.bigjava.util.UserException" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bigjava.bean.Answer" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: new Thread().start()
  Date: 2018/11/27
  Time: 18:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="question/questionCss/answer.css"/>
    <title>答案</title>
</head>
<body>
<div id="root">
    <%--循环用户信息--%>
        <s:iterator value="integerAnswerMap" var="map">
            <div class="questionAndAnswer">
            <h4>
                    <%--问题--%>
                <a href="#">
                    <s:property value="#map.key.questionTitle"/>
                </a>
            </h4>
            <%--用户值--%>

            <%--循环答案List--%>
            <s:iterator value="#map.value" var="value" status="i">
                <div style="">
                    <s:if test="%{#i.index == 0}">
                        <%--根据答案显示用户--%>
                        <s:iterator value="list" var="user">
                            <s:iterator value="#user" var="u">
                                <s:if test="%{#value.answer_user_id == #u.id}">
                                    <div class="user_info">
                                    <s:property value="#u.username"/>
                                    </div>
                                </s:if>
                            </s:iterator>
                        </s:iterator>
                        <s:property value="#value.answer_content"/>
                    </s:if>

                </div>
                </div>
            </s:iterator>
        </s:iterator>
</div>
<script>

</script>
</body>
</html>
