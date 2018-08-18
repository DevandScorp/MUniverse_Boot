<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="/static/style.css">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="/static/style.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script type = "text/javascript">
        var a = true;
        $('document').ready(function(){

            $('.hide-show-form').click(function(){
                if(!a){
                    $('.form').fadeIn();

                }
                else{
                    $('.form').fadeOut();
                }
                a=!a;

            });
        });
    </script>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <script src='https://www.google.com/recaptcha/api.js'></script>
    <link rel="stylesheet" href="/static/css/foundation.min.css">

    <!-- Include font -->
    <link href="https://fonts.googleapis.com/css?family=Lato:400,400i" rel="stylesheet">

    <!-- Include Amplitude JS -->
    <script type="text/javascript" src="/static/js/amplitude.js"></script>

    <!-- Foundation jQuery and Functions -->
    <script type="text/javascript" src="/static/js/jquery.js"></script>
    <script type="text/javascript" src="/static/js/foundation.min.js"></script>
    <script type="text/javascript" src="/static/js/playerjs (1).js"></script>
    <!-- Include Style Sheet -->
    <link rel="stylesheet" type="text/css" href="/static/css/app.css"/>
</head>
<body>

    <#include "parts/navbar.ftl">
<#if !user.activationCode??>
    <div class="container">
    <div class="text-center mt-5"><button type = "button" class = "hide-show-form btn btn-primary" >Add song</button></div>
    <div class="form mt-2">
        <div class="wrapper">
            <form method = "POST" action = "/playlist" enctype="multipart/form-data">
                <div class="form-group">
                    <p class="text-primary"><label for="exampleInputPassword1">Choose your file:</label></p>
                    <input type="file" required name = "file" accept=".mp3" class="form-control" placeholder="Choose your song">
                </div>
                <input type = "hidden" name = "_csrf" value = "${_csrf.token}"/>
                <button type="submit" class="btn btn-primary">Add song</button>
            </form>
        </div>
    </div>
        <div class="grid-x grid-padding-x">
            <div class="large-12 medium-12 small-12 cell">
            <#assign i = 0>
            <#list playlist as music>
                <div class="player">
                    <img src="/img/Songs/${music.filename}.jpg" onerror="this.src='/img/Songs/apple-music-android-logo.jpg'"class="album-art"/>
                    <div class="meta-container">
                        <div class="song-title"><#if music.song??>${music.song}<#else>${music.filename}</#if></div>
                        <div class="song-artist"><#if music.artist??>${music.artist}</#if></div>

                        <div class="time-container">
                            <div class="current-time">
                                <span class="amplitude-current-minutes" amplitude-song-index="${i}"></span>:<span class="amplitude-current-seconds" amplitude-song-index="${i}"></span>
                            </div>

                            <div class="duration">
                                <span class="amplitude-duration-minutes" amplitude-song-index="${i}">03</span>:<span class="amplitude-duration-seconds" amplitude-song-index="${i}">16</span>
                            </div>
                        </div>
                        <progress class="amplitude-song-played-progress" amplitude-song-index="${i}" id="song-played-progress-${i+1}"></progress>
                        <div class="control-container">
                            <div class="amplitude-prev">

                            </div>
                            <div class="amplitude-play-pause" amplitude-song-index="${i}">

                            </div>
                            <div class="amplitude-next">

                            </div>
                        </div>
                    </div>

                </div>
                    <script type = "text/javascript">
                        document.getElementById('song-played-progress-${i+1}').addEventListener('click', function( e ){
                            if( Amplitude.getActiveIndex() == ${i} ){
                                var offset = this.getBoundingClientRect();
                                var x = e.pageX - offset.left;

                                Amplitude.setSongPlayedPercentage( ( parseFloat( x ) / parseFloat( this.offsetWidth) ) * 100 );
                            }
                        });
                    </script>
                <#assign i++>
            </#list>
            </div>
        </div>
        <div id="preload">
            <img src="/static/img/previous.svg"/>
            <img src="/static/img/play.svg"/>
            <img src="/static/img/pause.svg"/>
            <img src="/static/img/next.svg"/>
        </div>
    </div>
<#else>
<p class="text-center text-danger">Your email is not verified.Please,verify it and then come back.</p>
</#if>
<script type="text/javascript">
    Amplitude.init({
        "songs": [
        <#list playlist as music>
            {
                "name": "<#if music.song??>${music.song}<#else>${music.filename.substring(0,music.filename.indexOf(".mp3"))}</#if>",
                "artist": "<#if music.artist??>${music.artist}</#if>",
                "url": "/img/Songs/${music.filename}.mp3",
            },
        </#list>
        ]


    });
</script>
<#--<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>-->
<script type="text/javascript" src="/static/js/functions.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>