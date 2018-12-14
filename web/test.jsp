<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Demo</title>
</head>
<body>
<div id="box">
    <select name="sel1" id="sel1">
        <option value="year">年</option>
    </select>
    <select name="sel2" id="sel2">
        <option value="month">月</option>
    </select>
    <select name="sel3" id="sel3">
        <option value="day">日</option>
    </select>
    <span id="result"></span>
</div>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="js/jquery.color.js"></script>
<script type="text/javascript">
    //生成1900年-2100年
    for(var i = 1900; i<=2100;i++){
        var option = document.createElement('option');
        option.setAttribute('value',i);
        option.innerHTML = i;
        sel1.appendChild(option);
    }
    //生成1月-12月
    for(var i = 1; i <=12; i++){
        var option = document.createElement('option');
        option.setAttribute('value',i);
        option.innerHTML = i;
        sel2.appendChild(option);
    }
    //生成1日—31日
    for(var i = 1; i <=31; i++){
        var option = document.createElement('option');
        option.setAttribute('value',i);
        option.innerHTML = i;
        sel3.appendChild(option);
    }
</script>
</body>
</html>