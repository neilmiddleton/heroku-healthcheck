Heroku HealthCheck
==================

Heroku CLI plugin that returns a basic overview of your applications current
health:

    heroku plugins:install https://github.com/neilmiddleton/heroku-healthcheck.git

Running

    heroku healthcheck -a app_name

outputs:

    === Heroku Status
    Development: No known issues at this time.
    Production:  No known issues at this time.

    === Checking processes
    === web: `bin/start_nginx`
    web.1: up 2013/01/25 16:58:19 (~ 4h ago)

    === Checking neilmiddleton domains...
    neilmiddleton.com: OK

    === Recent Releases
    === neilmiddleton Releases
    v33  Deploy 60250e2   neil@neilmiddleton.com  2013/01/23 16:22:01
    v32  Deploy cf32303   neil@neilmiddleton.com  2013/01/18 15:42:56
    v31  Deploy e29f821   neil@neilmiddleton.com  2013/01/17 09:35:56
    v30  Deploy 6e46165   neil@neilmiddleton.com  2013/01/16 20:13:40
    v29  Rollback to v27  neil@neilmiddleton.com  2013/01/16 10:47:10

    === Analyzing recent log entries
    Analyzing 740 requests
    H errors: 0 (0.0%)
    R errors: 0 (0.0%)
    L errors: 0 (0.0%)
