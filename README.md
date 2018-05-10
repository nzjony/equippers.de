# equippers.de

Equippers website for Germany. Hosted on [Cloudcannon](https://cloudcannon.com).

## Install

```
sudo gem install bundler
git clone git@github.com:equippers/equippers.de
cd equippers.de
bundle install
```

## Local Development

```
bundle exec jekyll serve
```

Now you can open http://localhost:4000 in your browser. If you add the cli argument `--host=0.0.0.0`, then you'll also be able to access the site from other devices in your network (like your phone) by opening `http://<LOCAL_IP_OF_HOST>:4000` in the device's browser (or `http://<HOST_NAME>.local:4000` on Apple devices).

## Workflow

Cloudcannon is set up to track changes on the `master` branch of this repository. If you work on major changes, please create a branch and then create a pull request for code review.

## Documentation

* https://learn.cloudcannon.com
* https://docs.cloudcannon.com
* https://jekyllrb.com/docs/home
* http://stylus-lang.com
