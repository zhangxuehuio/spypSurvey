<%--
  Created by IntelliJ IDEA.
  User: KingLf
  Date: 2016/5/18
  Time: 16:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<!--
Spectral by HTML5 UP
html5up.net | @n33co
Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
<head>
    <title>问卷调查</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
    <link rel="stylesheet" href="assets/css/main.css" />
    <!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
    <!--[if lte IE 9]><link rel="stylesheet" href="assets/css/ie9.css" /><![endif]-->
    <script src="assets/js/jquery-1.10.2.js"></script>
    <script src="assets/js/dialog-min.js"></script>
    <link href="assets/css/ui-dialog.css" rel="stylesheet" >
    <script type="text/javascript">
        function iFrameHeight() {
            //修改加载好的页面的背景色
            $("iframe").contents().find("table").css("margin","0 auto");
            $("iframe").contents().find("td").each(function(index,domEle){
                if($(domEle).css("background-color")=="rgba(0, 0, 0, 0)"){
                    $(this).css("background-color","#666666");
                }
            });
            //从数据库得到结果渲染到页面
            $("#ComResult").val("");
            loadAnswer();


            //给每个td绑定事件
            $("iframe").contents().ready(function(){
                $("iframe").contents().find("td").click(function(){
                    var _obj=$(this);
                    var _result=_obj.attr("result");
                    if(_result==null){
                        _result="没有意见";
                    }
                    var color=_obj.css("background-color");
                    console.log(color);
                    if(color!="rgb(102, 102, 102)"){

                        var d = dialog({
                            title: "指标:"+_obj.text(),
                            content:'<center>您的意见是:'+_result+'</center><br/><br/><br/><br/><br/><br/><br/><form class=\"question\" action=\"\" method=\"get\"><label><input name=\"question\" type=\"radio\" />A.重复填报</label><br/><label><input name=\"question\" type=\"radio\" />B.没有统计数据 </label><br/><label><input name=\"question\" type=\"radio\" />C.指标没有统计意义 </label><br/><label><input name=\"question\" type=\"radio\" />D.解释含糊不清楚 </label><br/><label><input name=\"question\" id="other" type=\"radio\" />其他意见:<input id=\"other2\"/></label><br/><label><input name=\"question\" id="cancel" type=\"radio\" />没有意见</label></form>',
                            okValue:'确定',
                            ok:function(){
                                var _changed=$("input:radio:checked");
                                var _res="";
                                if(_changed.size()>0){
                                    if(_changed.attr("id")=="other"){
                                        _res="其他意见:"+_changed.next().val();
                                        _obj.css("background-color","#FF4040");
                                    }else if(_changed.attr("id")=="cancel"){
                                        _res=null;
                                        _obj.css("background-color","rgb(0, 176, 80)");
                                    }else{
                                        _res=_changed.parent().text();
                                        _obj.css("background-color","#FF4040");
                                    }
                                    _obj.attr("result",_res);
                                }
                            }
                        });
                        d.showModal();
                    }
                });
            });
            //根据加载的页面对框架进行宽高定制
            var ifm=document.getElementById("iframepage");
            var subWeb=document.frames ? document.frames["iframepage"].document :ifm.contentDocument;
            if(ifm!=null&&subWeb!=null){
                ifm.height=subWeb.body.scrollHeight;
                ifm.width="100%";
            }
        }
        $(document).ready(function () {
            //跳转问卷操作
            $("div#menu ul li a").click(function () {
                var iframe= $("#iframepage");
                var framesrc="page/"+iframe.attr("level")+"/"+$(this).parent().index()+".htm";
                iframe.attr("page",$(this).parent().index());
                iframe.attr("src",framesrc);
            });
        });
        function save(){
            var page=$("#iframepage").attr("page");
            var comResult=$("#ComResult").val();
            var result="{\"page\":"+page+",\"comResult\":\""+comResult+"\",\"result\":[";
            $("iframe").contents().find("td").each(function(index,domEle){
                if($(domEle).css("background-color")=="rgb(255, 64, 64)"){
                    result+="{\"id\":"+index+",\"answer\":\""+$(domEle).attr('result')+"\"},"
                }
            });
            if(result.substring(result.length-1,result.length)==","){
                result=result.substring(0, result.length-1);
            }
            result+="]}";
            console.log(result);
            console.log(qnmd);
            var qnmd = dialog({
                zIndex: 107,
                content:'正在提交...请稍后...'
            });
            qnmd.showModal();



            $.post("home/postAnswer","postAnswer="+result+"&page="+page,function(data,status){
                if(data!="OK"){
                    alert("您的账户没有登录,请重新登录");
                    window.location.href='<%=request.getContextPath()%>/index.jsp';
                }else{
                    qnmd.close().remove();
                    message();
                }
            });

        }

        function loadAnswer(){
            //加载已经填写的问卷
            var tds=$("iframe").contents().find("td").toArray();
            var page=$("#iframepage").attr("page");
            $.getJSON("home/getAnswer","page="+page,function(data,status){

                $.each(data.result,function(i,item){
                    tds[item.id].setAttribute("result",item.answer);
                    tds[item.id].style.backgroundColor="#FF4040";
                    console.log(item.id+item.answer);
                });
                $("#ComResult").val(data.comResult);

            });
        }
        function message(){
            var d = dialog({
                title: '提示',
                content: '提交成功,是否进入下一页',
                okValue: '确定',
                ok: function () {
                    NextPage();
                },
                cancelValue: '取消',
                cancel: function () {}
            });
            d.showModal();
        }
        function NextPage(){
            var iframe= $("#iframepage");
            var nextPage=parseFloat(iframe.attr("page"))+1;
            var framesrc="page/"+iframe.attr("level")+"/"+nextPage+".htm";
            var total=$("#menu ul li").size();
            if(nextPage>=total){
                dialog({
                    title:'提示',
                    content:'已到达最后一页',
                }).show();
            }else{
                iframe.attr("page",nextPage);
                iframe.attr("src",framesrc);

            }
        }


    </script>
</head>
<body>

<div id="infodiv">

</div>
<!-- Page Wrapper -->
<div id="page-wrapper">

    <!-- Header -->
    <header id="header">
        <h1><a href="index.jsp" >CSISC食药监调研问卷系统</a></h1>
        <center><button id="save" type="button" value="" onclick="save()">提交并跳转到下一页</button>
            <%--<button id="info" type="button" onclick="info()" style="background-color: gray">填写说明</button>--%>
        </center>
        <nav id="nav">
            <ul>
                <li class="special">
                    <a href="#menu" class="menuToggle"><span>${loginUser.legalName }-问卷目录</span></a>
                    <div id="menu">

                        <ul>
                            <li><a href="index.html" id="1">Home</a></li>
                            <c:forEach items="${list }" var="al">
                                <li><a href="#">${al } </a></li>
                            </c:forEach>

                        </ul>
                    </div>
                </li>
            </ul>
        </nav>
    </header>

    <!-- Main -->
    <article id="main">
        <iframe level='${loginUser.level }' page="1" id="iframepage" name="iframepage" onLoad="iFrameHeight()" scrolling="no" src="page/${loginUser.level }/1.htm" style="background-color:rgba(29, 36, 42, 0.290196);"></iframe>
        <div class="row">
            <div class="1u">　</div>
            <div class="10u"><p>您对整张报表的意见是?</p>
                <textarea id="ComResult" type="text" style="height: 115px;resize: none;background-color:white;color:#000000"></textarea>
            </div>
        </div>
        <br><br>
    </article>

    <!-- Footer -->
    <footer id="footer">
        <header>
            <h2 style="">中国统计信息服务中心</h2>
            <p>技术支持：安标联盟（北京）技术咨询中心<br/>(010-63375716)</p>
        </header>
        <ul class="icons">
            <li><a href="tencent://message/?uin=1245076871&Site=www.12340.net.cn&Menu=yes" class="icon fa-qq"><span class="label">QQ</span></a></li>
            <li><a href="mailto:yuqing@stats.gov.cn" class="icon fa-envelope-o"><span class="label">Email</span></a></li>
        </ul>
        <ul class="copyright">
            <li>&copy; China CSISC</li><li>Design: <a href="http://www.12340.net.cn">CSISC</a></li>
        </ul>
    </footer>

</div>

<!-- Scripts -->
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/jquery.scrollex.min.js"></script>
<script src="assets/js/jquery.scrolly.min.js"></script>
<script src="assets/js/skel.min.js"></script>
<script src="assets/js/util.js"></script>
<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
<script src="assets/js/main.js"></script>

</body>
</html>