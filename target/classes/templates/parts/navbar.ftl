<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <a class="navbar-brand" href="#">MUniverse</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse ml-3" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link" href="/">Main page</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/playlist">Your playlist</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/login">Sign in/Sign up</a>
            </li>
            <li class="nav-tem">
                <#if user??>
                    <form action="/logout" method="post">
                        <button class="btn btn-light" type="submit">Sign Out</button>
                        <input type = "hidden" name = "_csrf" value = "${_csrf.token}"/>
                    </form>
                </#if>
            </li>
            <#--&lt;#&ndash;<li class="nav-item">&ndash;&gt;На будущее-->
                <#--<a class="nav-link disabled" href="#">Disabled</a>-->
            <#--</li>-->
        </ul>

        <#if user??>
            <div class="navbar-text mr-4">${user.getUsername()}</div>
            <img src="/img/${user.getId()}/logo.jpg" alt="..." class="rounded-circle icon">
        </#if>


    </div>
</nav>