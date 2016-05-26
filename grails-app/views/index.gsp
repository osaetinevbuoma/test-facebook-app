<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Welcome to Grails</title>

    <asset:link rel="icon" href="favicon.ico" type="image/x-ico" />
</head>
<body>
    <g:render template="layouts/facebookSDK" />

    <content tag="nav">
        <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Application Status <span class="caret"></span></a>
            <ul class="dropdown-menu">
                <li><a href="#">Environment: ${grails.util.Environment.current.name}</a></li>
                <li><a href="#">App profile: ${grailsApplication.config.grails?.profile}</a></li>
                <li><a href="#">App version:
                    <g:meta name="info.app.version"/></a>
                </li>
                <li role="separator" class="divider"></li>
                <li><a href="#">Grails version:
                    <g:meta name="info.app.grailsVersion"/></a>
                </li>
                <li><a href="#">Groovy version: ${GroovySystem.getVersion()}</a></li>
                <li><a href="#">JVM version: ${System.getProperty('java.version')}</a></li>
                <li role="separator" class="divider"></li>
                <li><a href="#">Reloading active: ${grails.util.Environment.reloadingAgentEnabled}</a></li>
            </ul>
        </li>
        <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Artefacts <span class="caret"></span></a>
            <ul class="dropdown-menu">
                <li><a href="#">Controllers: ${grailsApplication.controllerClasses.size()}</a></li>
                <li><a href="#">Domains: ${grailsApplication.domainClasses.size()}</a></li>
                <li><a href="#">Services: ${grailsApplication.serviceClasses.size()}</a></li>
                <li><a href="#">Tag Libraries: ${grailsApplication.tagLibClasses.size()}</a></li>
            </ul>
        </li>
        <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Installed Plugins <span class="caret"></span></a>
            <ul class="dropdown-menu">
                <g:each var="plugin" in="${applicationContext.getBean('pluginManager').allPlugins}">
                    <li><a href="#">${plugin.name} - ${plugin.version}</a></li>
                </g:each>
            </ul>
        </li>
    </content>

    <div class="svg" role="presentation">
        <div class="grails-logo-container">
            <asset:image src="grails-cupsonly-logo-white.svg" class="grails-logo"/>
        </div>
    </div>

    <div id="content" role="main">
        <section class="row colset-2-its">
            <div class="col-md-4 col-md-offset-4">
                <h1 style="font-size: 30pt;">Facebook App</h1>

                <button class="btn btn-lg btn-primary login-btn" id="js-login">
                    <i class="fa fa-2x fa-facebook-official"></i>
                    <span style="font-size: 20pt;">Login with Facebook</span>
                </button>

                <button class="btn btn-lg btn-primary logout-btn" id="js-logout">
                    <i class="fa fa-2x fa-facebook-official"></i>
                    <span style="font-size: 20pt;">Logout of Facebook</span>
                </button>
            </div>
        </section>
    </div>

    <asset:javascript src="application.js"/>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".logout-btn").hide();

            $("#js-login").click(function (event) {
                event.preventDefault();

                FB.login(function (response) {
                    if (response.status == "connected") {
                        console.log(response);
                        $(".login-btn").hide();
                        $(".logout-btn").show();

                        $.ajax("facebook/getLongLivedToken", {
                            method: "GET",
                            data: { token: response.authResponse.accessToken },
                            success: function (data, status, jqXHR) {
                                console.log(data);
                            },
                            error: function (jqXHR, status, error) {
                                console.log(error);
                            }
                        });
                    } else if (response.status == "not_authorized") {
                        console.log("Not authorized");
                        console.log(response);
                    } else {
                        console.log("Not logged in");
                        console.log(response);
                    }
                }, { scope: "manage_pages, ", auth_type: "rerequest" });
            });

            $("#js-logout").click(function (event) {
                event.preventDefault();

                FB.logout(function (response) {
                    console.log(response);
                    $(".login-btn").show();
                    $(".logout-btn").hide();
                });
            });
        });
    </script>
</body>
</html>
