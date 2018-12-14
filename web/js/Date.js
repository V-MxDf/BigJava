//生成1900年-2100年
for(var i = 1900; i<=2100;i++){
    var option = document.createElement('option');
    option.setAttribute('value',i);
    option.innerHTML = i;
    $("#select_year").append(option);
    // document.getElementById("select_year").appendChild(option);
}
//生成1月-12月
for(var i = 1; i <=12; i++){
    var option = document.createElement('option');
    option.setAttribute('value',i);
    option.innerHTML = i;
    $("#select_month").append(option);
}
//生成1日—31日
for(var i = 1; i <=31; i++){
    var option = document.createElement('option');
    option.setAttribute('value',i);
    option.innerHTML = i;
    $("#select_day").append(option);

}