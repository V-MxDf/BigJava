<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Demo</title>
</head>
<body>
<div class="txt_bos"><!--在每一个放置文字的class外面包一个div，以便设置动画样式用，同样用class-->
    <div class="txt1"><!--为了保证功能的通用性，这里全用class-->
        石村，位于苍莽山脉中，四周高峰大壑，茫茫群山巍峨。

        清晨，朝霞灿灿，仿若碎金一般洒落，沐浴在人身上暖洋洋。

        一群孩子，从四五岁到十几岁不等，能有数十人，在村前的空地上迎着朝霞，正在哼哈有声的锻炼体魄。一张张稚嫩的小脸满是认真之色，大一些的孩子虎虎生风，小一些的也比划的有模有样。

        一个肌体强健如虎豹的中年男子，穿着兽皮衣，皮肤呈古铜色，黑发披散，炯炯有神的眼眸扫过每一个孩子，正在认真指点他们。
    </div>
</div>
<div class="txt_bos">
    <div class="txt1">
        “太阳初升，万物初始，生之气最盛，虽不能如传说中那般餐霞食气，但这样迎霞锻体自也有莫大好处，可充盈人体生机。一天之计在于晨，每曰早起多用功，强筋壮骨，活血炼筋，将来才能在这苍莽山脉中有活命的本钱。”站在前方、指点一群孩子的中年男子一脸严肃，认真告诫，而后又喝道：“你们明白吗？”

        “明白！”一群孩子中气十足，大声回应。

        山中多史前生物出没，时有遮蔽天空之巨翼横过，在地上投下大片的阴影，亦有荒兽立于峰上，吞月而啸，更少不了各种毒虫伏行，异常可怖。

        “明白呀。”一个明显走神、慢了半拍的小家伙奶声奶气的叫道。
    </div>
</div>
<div class="txt_bos">
    <div class="txt1">
        这是一个很小的孩子，只有一两岁的样子，刚学会走路没几个月，也在跟着锻炼体魄。显然，他是自己凑过来的，混在了年长的孩子中，分明还不应该出现在这个队伍里。

        “哼哼哈嘿！”小家伙口中发声，嫩嫩的小手臂卖力的挥动着，效仿大孩子们的动作，可是他太过幼小，动作歪歪扭扭，且步履蹒跚，摇摇摆摆，再加上嘴角间残留的白色奶渍，引人发笑。

        一群大孩子看着他，皆挤眉弄眼，让原本严肃的晨练气氛轻缓了不少。

        小不点长的很白嫩与漂亮，大眼睛乌溜溜的转动，整个人像是个白瓷娃娃，很可爱，稚嫩的动作，口中咿咿呀呀，憨态可掬。这让另一片场地中盘坐在一块块巨石上正在吞吐天精的一些老人也都露出笑容。

        就是那些身材高大魁梧、上半身**、肌腱光亮并隆起的成年男子们，也都望了过来，带着笑意。他们是村中最强壮的人，是狩猎与守护这个村落的最重要力量，也都在锻体，有人握着不知名的巨兽骨骼打磨而成的白骨大棒，也有人持着黑色金属铸成的阔剑，用力舞动，风声如雷。
    </div>
</div>
</body>
<style type="text/css">
    * {
        -moz-user-select: -moz-none;
        -moz-user-select: none;
        -o-user-select: none;
        -khtml-user-select: none;
        -webkit-user-select: none;
        -ms-user-select: none;
        user-select: none;
    }

    .txt_bos {
        position: relative;
        width: 500px;
        height: 25px;
        margin-top: 50px;
        left: 400px;
        background-color: yellow;
        overflow: hidden;
    }

    .txt1 {
        position: relative;
        width: 100%;
        height: 25px;
        font-family: "微软雅黑", serif;
        font-size: 20px;
        word-wrap: break-word;
        overflow: hidden;
    }
</style>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="js/jquery.color.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        var MaxLength = 36;//先设置一个变量用做第一行最多显示的长度
        var txt = new Array();//定义一个数组

        var texts = $(".txt1");//获取一下每一个放置文字的div，一组div
        for (var i = 0; i < texts.length; i++) {//写一个循环，循环次数为所有放置文字div的数量
            if (texts.eq(i).text().length > MaxLength) {
                texts.eq(i).parent().index(i);//给每个索引上的div的父级赋一个index属性，也就是这个段文字在数组内的索引
                txt[i] = texts.eq(i).text();//将获取的一组文字div按照索引一次将文字放进数组
                var st = texts.eq(i).text().substr(0, MaxLength) + '...';//一上来默认第一行显示长度为上面定义的变量长度，后面加...放进变量
                texts.eq(i).text(st);//再将变量给每组文字的显示
            }
        }

        //每组文字div的点击事件
        $(".txt1").click(function () {

            if ($(this).outerHeight() > 27) {//如果这个div的高度超过了每行的高度，则执行超出部分隐藏
                $(this).text($(this).text().substr(0, MaxLength) + '...');//将显示文字重新定义为初始状态
                //给外面包着的div，也就是父级div写一个动画，高度为目前重新定以后文字高度，400毫秒慢慢缩回，用到animate
                $(this).parent().animate({ height: $(this).outerHeight(), backgroundColor: 'yellow' }, 400);
            }
            else {//如果没有超过每行高度，也就是为初始状态的时候，点击需要慢慢下拉打开
                $(this).text(txt[$(this).parent().index()]);//通过父级的index值找到数组内对应索引的文字，将其显示
                $(this).css('height', 'auto');//设置这个div的css样式，高度为文字显示高度
                //因为父级div样式表中设置超出部分隐藏，用animate将高度慢慢下拉至子及div，也就是文字div目前的高度，400毫秒执行完毕
                $(this).parent().animate({ height: $(this).outerHeight(), backgroundColor: 'white' }, 400);

            }
        });
    });
</script>
</html>