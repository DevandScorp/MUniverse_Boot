<#import "parts/main.ftl" as c>
<@c.page>
    <#--<form action="/login" method="post">-->
        <#--<div><label> User Name : <input type="text" name="username"/> </label></div>-->
        <#--<div><label> Password: <input type="password" name="password"/> </label></div>-->
        <#--<!--так нужно делать в каждой форме для протоколов безопасности&ndash;&gt;-->
        <#--<input type = "hidden" name = "_csrf" value = "${_csrf.token}"/>-->
        <#--<div><input type="submit" value="Log In"/></div>-->
    <#--</form>-->
<div class="text-center"><p class="text-primary">${message?ifExists}</p></div>
<div class="mt-5">
    <form action="/login" method="post">
        <div class="form-group">
            <p class="text-primary"><label for="exampleInputEmail1">User name:</label></p>
            <input type="text" name = "username" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Username">
        </div>
        <input type = "hidden" name = "_csrf" value = "${_csrf.token}"/>
        <div class="form-group">
            <p class="text-primary"><label for="exampleInputPassword1">Password:</label></p>
            <input type="password" name = "password" class="form-control" id="exampleInputPassword1" placeholder="Password">
        </div>
        <button type="submit" class="btn btn-primary">Log in</button>
    </form>
    <a href="/registration">Add new user</a>
</div>
</@c.page>