<#import "parts/main.ftl" as c>
<@c.page>
<div class="mt-2">
    <#if user??>
    <div class="jumbotron jumbotron-fluid mt-5">
        <div class="container">
            <p class="text-center"><h1 class="display-4 text-center">Hi,${user.getUsername()}</</p>
            <p class="lead">This is my project MUniverse.Here you can listen to your favourite music,add and edit your own playlist.</p>
        </div>
    </div>
        <#else>
        <div class="jumbotron jumbotron-fluid mt-5">

            <div class="container">
                <p class="text-center"><h1 class="display-4 text-center">Hi</h1></p>
                <p class="lead">This is my project MUniverse.Here you can listen to your favourite music,add and edit your own playlist.</p>
                <p class="lead">It seems to me,you don't have an account.Please,go and sign up.</p>
            </div>

        </div>
    </#if>

</div>
</@c.page>