<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Login</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">

    </head>
    <body>
        <div class="login-box">

            <h2>Login</h2>

            <form action="login" method="post">

                <div class="input-group">
                    <input name="username" required>
                    <label>Username</label>
                </div>

                <div class="input-group">
                    <input type="password" name="password" required>
                    <label>Password</label>
                </div>

                <button type="submit">Login</button>

            </form>
            <p class="error">
                ${error}
            </p>

        </div>
    </body>
</html>