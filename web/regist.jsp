<%--
  Created by IntelliJ IDEA.
  User: 李旦
  Date: 2019/12/22
  Time: 14:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>注册\(^o^)/~</title>
    <link rel="stylesheet" href="static/stylesheets/ucenter.css">
    <link rel="stylesheet" href="static/stylesheets/bootstrap.min.css">
    <script src="static/scripts/jquery-3.4.1.min.js"></script>
    <script src="static/scripts/bootstrap.bundle.min.js"></script>
    <script src="static/scripts/bootstrap.min.js"></script>
    <link rel="stylesheet" href="static/stylesheets/drophover.css">
    <link rel="stylesheet" href="static/stylesheets/regist.css">
</head>
<body>
<nav class="navbar sticky-top navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="index1.jsp" title="╰(￣▽￣)╭">(๑•̀ㅂ•́)و✧</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="index1.jsp">首页 <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="leaderboard.jsp">排行</a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    分类
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="material.jsp">食材</a>
                    <a class="dropdown-item" href="taste.jsp">口味</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="all.jsp">所有</a>
                </div>
            </li>
            <li class="nav-item drop-menu">
                <a class="nav-link hover-btn" tabindex="-1" aria-disabled="true">
                    <img src="static/images/phone.png" alt="phone" height="20">
                    下载app
                </a>
                <div class="drop-content">
                    <img src="static/images/22.png" alt="二维码" width="150" height="150">
                </div>
            </li>
            <c:if test="${not empty user}">
                <li class="nav-item drop-menu">
                    <a class="nav-link hover-btn" tabindex="-1" aria-disabled="true">
                        <c:if test="${empty user.facepath}">
                            <img src="static/images/user.jfif" alt="user" height="30" style="position: relative;border-radius: 50%">
                        </c:if>
                        <c:if test="${not empty user.facepath}">
                            <img src="showImg" alt="user" height="30" style="position: relative;border-radius: 50%">
                        </c:if>
                    </a>
                    <div class="drop-content bg-light" style="width: 100px">
                        <a class="nav-link" target="_blank" href="ucenter.jsp" style="color: #533f03">个人中心</a>
                        <a class="nav-link" target="_blank" href="mymenusTransition.jsp" style="color: #533f03">我的菜谱</a>
                        <a class="nav-link" target="_blank" href="mycollect.jsp" style="color: #533f03">我的收藏</a>
                        <div style="height: 1px"><hr color="orange"></div>
                        <a class="nav-link" href="exit" style="color: gray">退出登录</a>
                    </div>
                </li>
            </c:if>
            <c:if test="${empty user}">
                <li class="nav-item">
                    <a class="nav-link" href="login.jsp">登录</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="regist.jsp">注册</a>
                </li>
            </c:if>
        </ul>
        <form class="form-inline my-2 my-lg-0">
            <input class="form-control mr-sm-2" type="search" placeholder="你想要的都在这里..." aria-label="Search">
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">搜索</button>
        </form>
    </div>
</nav>

<div class="main">
    <p class="sign" align="center">注册</p>
    <form class="form1" action="${pageContext.request.contextPath}/regist" method="post" autocomplete="off">
        <input class="un " required type="text" align="center" placeholder="用户名" name="username" id="username">
        <span id="error-username"></span>
        <input class="pass" required type="password" align="center" placeholder="密码" name="password" id="password">
        <span id="error-password"></span>
        <input class="pass" required type="password" align="center" placeholder="确认密码" name="repassword" id="repassword" onkeyup="validate()">
        <span id="error-repassword"></span>
        <input type="submit" value="注册" class="submit">
        <p class="regi" align="center">已有账号？点击<a href="login.jsp">登录</a></p>
    </form>
</div>
</body>
<script type="application/javascript" src="static/scripts/jquery-3.4.1.min.js"></script>
<script src="static/scripts/bootstrap.bundle.min.js"></script>
<script src="static/scripts/bootstrap.min.js"></script>
<script>
    //判断用户名是否已被占用
    $("#username").change(function(){
        var url = "${pageContext.request.contextPath}/checkUser";
        var param = {"username":$("#username").val()};
        $.ajax({
            url:url,
            type:"post",
            data:param,
            dataType:"json",
            success:function (d) {
                if (d.code == 1){
                    $("#error-username").html("<font title='该用户名已被使用' color='red'>&times;</font>");
                    $(".submit").attr("disabled","disabled");
                }else{
                    $("#error-username").html("<font title='可以使用' color='green'>&radic;</font>");
                    $(".submit").removeAttr("disabled");
                }
            }
        });
    });

    //判断密码和确认密码是否一样
    function validate() {
        if ($("#repassword").val() == $("#password").val()){
            $("#error-password").html("<font color='green'>&radic;</font>");
            $("#error-repassword").html("<font color='green'>&radic;</font>");
            $(".submit").removeAttr("disabled");
        }else {
            $("#error-repassword").html("<font title='两次密码不一致' color='red'>&times;</font>");
            $(".submit").attr("disabled","disabled");
        }
    }

    //提交注册信息
    $("form").submit(function (event) {
        event.preventDefault();
        var form = $(this);
        $.ajax({
            url:form.attr("action"),
            type:form.attr("method"),
            data:form.serialize(),
            dataType:"json",
            success:function () {
                alert("注册成功，请登录");
                window.location.href="login.jsp";
            }
        })
    })
</script>
</html>
