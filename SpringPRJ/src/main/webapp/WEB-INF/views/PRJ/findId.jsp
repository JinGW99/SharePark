<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>FIND ID</title>
    <link rel="stylesheet" href="../css/login.css" type="text/css">
    <script src="../js/._jquery-3.2.1.min.js"></script>
</head>
<body>
<section class="login-form">
    <h1>FIND ID</h1>
    <form method="post" action="/findId" >
        <div class="int-area">
            <input type="email" name="email" id="email"
                   autocomplete="off" required>
            <label for="email">EMAIL</label>
        </div>



        <div class="btn-area">
            <button id="btn" class="login_button"
                    type="submit">FIND</button>
        </div>
    </form>


    <div class="caption">
        <a href="/PRJ/loginForm">GO TO LOGIN?</a>
    </div>
</section>


</body>


</html>



<%--
<form id="contactForm" th:action="@{/user/findId}" th:method="post">

    <div>
        <span class="input-group-text" id="inputGroup-sizing-lg1">이메일을 입력해주세요.</span>
        <input type="email" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-lg"
               id="email" name="email">
    </div>


    <button class="btn btn-primary text-uppercase" id="submitButton" type="submit" >내 아이디 전송</button>
</form>--%>
