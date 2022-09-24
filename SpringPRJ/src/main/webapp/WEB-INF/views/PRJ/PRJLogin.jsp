<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="EUC-KR">
    <title>LoginForm</title>
    <link rel="stylesheet" href="../css/login.css" type="text/css">
    <script src="../js/._jquery-3.2.1.min.js"></script>
</head>
<body>
<section class="login-form">
    <h1>LOGIN</h1>
    <form method="post" action="/PRJ/getUserLoginCheck" onsubmit="return doLoginUserCheck(this);">
        <div class="int-area">
            <input type="text" name="user_id" id="user_id"
                   autocomplete="off" required>
            <label for="user_id">ID</label>
        </div>

        <div class="int-area">
            <input type="password" name="password" id="password"
                   autocomplete="off" required>
            <label for="password">PASSWORD</label>
        </div>

        <div class="btn-area">
            <button id="btn" class="login_button"
                    type="submit">LOGIN</button>
        </div>
    </form>

    <div class="caption">
        <a href="/findId/page">Forget Your ID?</a>
    </div>

    <div class="caption">
        <a href="/PRJ/userRegForm">Create Your ID?</a>
    </div>
</section>

<script>
    let user_id = $('#user_id');
    let password = $('#password');
    let btn = $('#btn');

    $(btn).on('click', function(){
        if($(user_id).val() == ""){
            $(user_id).next('label').addClass('warning');

        }
        else if($(password).val() == ""){
            $(password).next('label').addClass('warning');
        }
    });

    $(".login_button").click(function(){

        alert("로그인 버튼 작동");

    });
</script>
</body>


</html>