# tagtrue-redirect

This is a light-weight, high-performing rack application whose sole purpose is
to redirect requests from the legacy `tagtrue.com` domains to the new `datatrue.com`
domain.

It uses [Rack::Rewrite](https://github.com/jtrupiano/rack-rewrite) to redirect:

```
staging.tagtrue.com     https://staging.datatrue.com/?via=tagtrue-redirect
*                       https://datatrue.com/?via=tagtrue-redirect
```

The path is preserved across redirects but the [query string](https://github.com/jtrupiano/rack-rewrite#keeping-your-querystring) is not.

It runs in Heroku under tagtrue-redirect.herokuapp.com.

## Installation

1. Clone this repository.
2. Create a new Heroku application.
3. Add the Heroku application repository as a git remote.
4. Push to the Heroku remote.
5. [Add the tagtrue.com domains to the Heroku application](https://devcenter.heroku.com/articles/custom-domains#add-a-custom-domain-with-a-subdomain).
5. Install the [SSL add-on](https://elements.heroku.com/addons/ssl) to the application.
6. Point the [DNS entries](https://devcenter.heroku.com/articles/ssl-endpoint#dns-and-domain-configuration) for tagtrue.com to the Heroku SSL end-point.

For better performance you should increase the default number of processes and threads on the [puma web server](http://puma.io/); e.g.:

    heroku config:set WEB_CONCURRENCY=8 MAX_THREADS=10 -a tagtrue-redirect

## Performance

I ran some [Apache Bench](https://httpd.apache.org/docs/2.2/programs/ab.html) tests against this application
and it handled around 100 reqs/s for https and 200 reqs/s for https.  The hosting costs in Heroku are USD 27/mo ($20 for the SSL add-on, $7 for the hobby Dyno).

## Development

All the work happens in config.ru.

```bash
gem install bundler
bundle install
bundle exec rackup config.ru
```

Rack requires a `run` or `map` command in config.ru so there's a fall-back inline function that redirects to datatrue by default.
