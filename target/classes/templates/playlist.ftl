<#import "parts/main.ftl" as c>
<@c.page>
<div class="text-center mt-5"><button type = "button" class = "hide-show-form btn btn-primary" >Add song</button></div>
<div class="form mt-2">
    <div class="wrapper">
        <form method = "POST" action = "/playlist" enctype="multipart/form-data">
            <div class="form-group">
                <p class="text-primary"><label for="exampleInputPassword1">Choose your file:</label></p>
                <input type="file" name = "file" accept=".mp3" class="form-control" placeholder="Choose your song">
            </div>
            <input type = "hidden" name = "_csrf" value = "${_csrf.token}"/>
            <button type="submit" class="btn btn-primary">Add song</button>
        </form>
    </div>
</div>
</@c.page>