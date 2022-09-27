`Featherweight` is an ultra-lightweight Jekyll theme, aiming to minimise bandwidth usage and deliver a bare-bones experience (page sizes of ~1kb). 

[![Gem Version](https://img.shields.io/gem/v/featherweight?style=flat-square)][ruby-gems]

[ruby-gems]: https://rubygems.org/gems/featherweight

#### Building on GitHub

If you're using this site on GitHub pages, the built-in build action won't run gems outside of the [supported plugins list](https://pages.github.com/versions/), e.g.: the `jekyll-loading-lazy` gem (which adds `loading="lazy"` tags to `iframes` and `img` tags, enabling faster initial page loads).

To enable these gems, use the `build_and_deploy.yml` action under `.github/workflows` to automatically build your site on pushes, which circumvents this restriction while still hosting using GitHub pages (as advised by [Jekyll](https://jekyllrb.com/docs/continuous-integration/github-actions/)).

The workflow pushes the build to `gh-pages` branch by default, so make sure this exists and your page settings point towards it.

#### Writing blog posts

Create a blank `.md` file in `_pages/`, and add:
```
---
layout: post
title: My blog post.
---
```

Write your blog post in GitHub-flavoured-markdown below the metadata.

When naming blog post files, use the `YYYY-MM-DD-title.md` convention, or else your post won't appear in the blog post list. Read the [Jekyll docs](https://jekyllrb.com/docs/posts/).

#### Cheatsheet

|||
|:--:|:--:|
| _Config_ | Update site URL, personal links, CV experience using `_config.yml`. |
| _Extra config_ | Customise your site (add minimal inline styling, homepage link and footer in blogposts, favicon) via the `compression` options in `_config.yml`. These options add additional bytes to your pages, but can improve UX. |
| _About me_ | Customise the About Me section of the homepage by editing `_pages/about.md`. |
| _Change font_ | Customise fonts for text + footer by editing `_layouts/default.html` and `_layouts/post.html` inline CSS. |
| _RSS_ | The RSS feed can be found at <https://yourgithubusername.github.io/feed>. |
| _Sitemap_ | The sitemap can be found at <https://yourgithubusername.github.io/sitemap>. |
| _Quickstart_ | Test your website locally by following the [Jekyll quickstart guide](https://jekyllrb.com/docs/). |
| _gzip compression_ | Files are compressed using [Zopfli](https://github.com/philnash/jekyll-zopfli) compression. GitHub GZip's files automatically before serving, but we can use more aggressive pre-compression to achieve better compression, and avoid server overhead to compress on-the-fly. Support seems to vary between browsers, and some will fallback to `.html`. |
| _Brotli compression_ | We also compress files using Google's [Brotli](https://en.wikipedia.org/wiki/Brotli) algorithm. We serve `.gz` and `.html` as fallback, although `.br` [has good support](https://caniuse.com/brotli) |
