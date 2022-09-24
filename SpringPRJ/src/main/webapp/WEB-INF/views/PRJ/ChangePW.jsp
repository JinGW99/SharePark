<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Bootstrap Elegant Account Login Form with Avatar Icon</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <script type="text/javascript">
        function password() {
            var p1 = document.getElementById('password').value;
            var p2 = document.getElementById('password2').value;
            if (p1 != p2){
                alert("비밀번호가 일치하지 않습니다");
                return false;
            }else{
                return true;
            }
        }
    </script>

    <style>
        body {
            background-color: #74992e;

            font-family: 'Varela Round', sans-serif;
            margin-top: 200px;
        }

        .form-control {
            box-shadow: none;
            border-color: #ddd;
        }

        .form-control:focus {
            border-color: #4aba70;
        }

        .login-form {
            width: 600px;
            margin: 0 auto;
            padding: 30px 0;
        }

        .login-form form {
            color: #434343;
            border-radius: 1px;
            margin-bottom: 15px;
            background: #fff;
            border: 1px solid #f3f3f3;
            box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
            padding: 30px;
        }

        .login-form h4 {
            text-align: center;
            font-size: 22px;
            margin-bottom: 20px;
        }

        .login-form .avatar {
            color: #fff;
            margin: 0 auto 30px;
            text-align: center;
            width: 100px;
            height: 100px;
            border-radius: 50%;
            z-index: 9;
            background: #ACB992;
            padding: 15px;
            box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.1);
        }

        .login-form .avatar i {
            font-size: 62px;
        }

        .login-form .form-group {
            margin-bottom: 20px;
        }

        .login-form .form-control, .login-form .btn {
            min-height: 40px;
            border-radius: 2px;
            transition: all 0.5s;
        }

        .login-form .close {
            position: absolute;
            top: 15px;
            right: 15px;
        }

        .login-form .btn {
            background: #ACB992;
            border: none;
            line-height: normal;
        }

        .login-form .btn:hover, .login-form .btn:focus {
            background:#ACB992;
        }

        .login-form .checkbox-inline {
            float: left;
        }

        .login-form input[type="checkbox"] {
            margin-top: 2px;
        }

        .login-form .forgot-link {
            float: right;
        }

        .login-form .small {
            font-size: 18px;
            margin-top: 10px;
        }

        .login-form a {
            color:#464E2E;
        }
    </style>

</head>
<body>
<div class="login-form">
    <form action="/updateUserPw" method="post">
        <div class="avatar"></div>
        <h4 class="modal-title">비밀번호 변경</h4>




        <div class="form-group">
            <input type="password" class="form-control" placeholder="Enter Password" required="required" name="password">
        </div>
        <div class="form-group">

            <input type="password" class="form-control" placeholder="Confirm Password" required="required" name="password2">
        </div>

        <input type="submit" class="btn btn-primary btn-block btn-lg" value="변경하기">
        <div class="text-center small">홈으로<a href="/PRJmain">home</a></div>

    </form>

</div>
</body>
</html>