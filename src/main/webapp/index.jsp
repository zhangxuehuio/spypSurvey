<%--
  Created by IntelliJ IDEA.
  User: KingLf
  Date: 2016/5/18
  Time: 15:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=gb2312"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>国家食品药品监督总局统计指标体系调研</title>
    <meta http-equiv="content-type" content="text/html;charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
    <link rel="stylesheet" href="assets/css/main.css" />
    <script src="assets/js/jquery.min.js"></script>
    <script type="text/javascript" src="assets/js/jquery-1.10.2.js"></script>
    <!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
    <!--[if lte IE 9]><link rel="stylesheet" href="assets/css/ie9.css" /><![endif]-->
    <script type="text/javascript">

        function ajaxLogin(){
            var name=$("#username").val();
            var pass=$("#password").val();
            if(name==""||pass==""){
                $("#errMsg").text("用户名或密码不能为空");
                return;
            }else{
                $.getJSON("/login.do","username="+name+"&password="+pass,function(data,status){
                    //应该用ajax方式
                    if(data.msg=="success"){
                        window.location.href="/home";
                    }else{
                        $("#errMsg").text(data.msg);
                    }
                });
            }

        }

    </script>
</head>
<body class="landing">
<div id="page-wrapper">
    <section id="banner">
        <div class="inner">
            <h2>食药监管统计指标体系研究网络调研</h2>
            <div class="row uniform">
                <p class="3u"></p>
                <p class="6u text-left">　
                </p>
            </div>

            <span style="color:#F08080;font:18px/2 tahoma,arial,'Hiragino Sans GB','\5b8b\4f53',sans-serif" id="errMsg"></span>
            <ul class="actions">
                <form method="get" action="login" id="loginForm">
                    <li><input type="text" name="username" id="username" value="" placeholder="用户名"  style="width: 400px"/></li><br/><br/>
                    <li><input type="password" name="password" id="password" value="" placeholder="密码"  style="width: 400px"/></li><br/><br/>
                    <li class="align-center"><input type="button" onclick="ajaxLogin()" value="提交" class="button special"/></li>
                </form>
                <div id="browserError" style="display: none">
                    <img src="/images/error.gif"/>
                    <p>对不起,为了给您更好的问卷体验,请您使用 <strong>金山猎豹浏览器</strong> 再次访问本页面</p>
                    <p>下载地址:<a href="http://www.liebao.cn/windows.html">金山猎豹官网下载</a></p>

                </div>
            </ul>
        </div>
        <a href="#footer" class="more scrolly">About Us</a>
    </section>


    <!-- Footer -->
    <footer id="footer">
        <header>
            <h2 style="">中国统计信息服务中心</h2>
            <p>大数据技术：安标联盟（北京）技术咨询中心<br/>(010-63375716)</p>
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

<script src="assets/js/jquery.scrollex.min.js"></script>
<script src="assets/js/jquery.scrolly.min.js"></script>
<script src="assets/js/skel.min.js"></script>
<script src="assets/js/util.js"></script>
<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
<script src="assets/js/main.js"></script>
<script type="application/javascript">
    var userAgent = navigator.userAgent;
    if(userAgent.indexOf("LBBROWSER")<0){
        document.getElementById("loginForm").style.display="none";
        document.getElementById("browserError").style.display="";

    }

</script>



</body>
</html>
