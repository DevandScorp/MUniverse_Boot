<#import "parts/main.ftl" as c>
<@c.page>
<div class="mt-5">
    <#if message??>
        <div class="alert alert-danger" role="alert">
            ${message}
        </div>
        <#else>
    </#if>
    <form action="/registration" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <p class="text-primary"><label for="exampleInputEmail1">Email:</label></p>
            <input type="email" name = "email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
        </div>
        <div class="form-group">
            <p class="text-primary"><label for="exampleInputEmail1">User name:</label></p>
            <input type="text" name = "username" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Username">
        </div>
        <input type = "hidden" name = "_csrf" value = "${_csrf.token}"/>
        <div class="form-group">
            <p class="text-primary"><label for="exampleInputPassword1">Password:</label></p>
            <input type="password" name = "password" class="form-control" id="exampleInputPassword1" placeholder="Password">
        </div>
        <div class="form-group">
            <p class="text-primary"><label for="exampleInputPassword1">Icon image:</label></p>
            <input type="file" multiple accept="image/jpeg" name = "file" class="form-control" id="exampleInputPassword1" placeholder="Password">
        </div>
        <button type="submit" class="btn btn-primary">Submit</button>
    </form>
</div>
</@c.page>