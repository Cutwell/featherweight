`Featherweight` is an ultra-lightweight Jekyll theme, aiming to minimise bandwidth usage and deliver a bare-bones experience (page sizes of ~1kb). 

[![Gem Version](https://img.shields.io/gem/v/featherweight?style=flat-square)][ruby-gems]

[ruby-gems]: https://rubygems.org/gems/featherweight

#### Building on GitHub

If you're using this site on GitHub pages, the built-in build action won't run gems outside of the [supported plugins list](https://pages.github.com/versions/).

To enable these gems, use the `build_and_deploy.yml` action under `.github/workflows` to automatically build your site on pushes, which circumvents this restriction while still hosting using GitHub pages (as advised by [Jekyll](https://jekyllrb.com/docs/continuous-integration/github-actions/)).

The workflow pushes the build to `gh-pages` branch by default, so make sure this exists and your page settings point towards it.

#### Writing blog posts

Create a blank `.md` file in `_pages/`, and add:
```
---
layout: post
title: My blog post.
description: A description of the post, used for metadata.
image: (optional) an image to display when linking to the post on e.g.: Twitter or Facebook
---
```

Write your blog post in GitHub-flavoured-markdown below the metadata.

When naming blog post files, use the `YYYY-MM-DD-title.md` convention, or else your post won't appear in the blog post list. Read the [Jekyll docs](https://jekyllrb.com/docs/posts/).

#### Cheatsheet

|||
|:--:|:--:|
| _Config_ | Update site URL, social links, and CV experience using `_config.yml`. |
| _About me_ | Customise the About Me section of the homepage by editing `_pages/about.md`. This is rendered as markdown at build time. |
| _RSS_ | The RSS feed can be found at <https://yourgithubusername.github.io/feed>. |
| _Sitemap_ | The sitemap can be found at <https://yourgithubusername.github.io/sitemap>. |
| _Quickstart_ | Test your website locally by following the [Jekyll quickstart guide](https://jekyllrb.com/docs/). |
| _gzip compression_ | Files are compressed using [Zopfli](https://github.com/philnash/jekyll-zopfli) compression. GitHub GZip's files automatically before serving, but we can use more aggressive pre-compression to achieve better compression, and avoid server overhead to compress on-the-fly. Support seems to vary between browsers, and some will fallback to `.html`. |
| _Brotli compression_ | We also compress files using Google's [Brotli](https://en.wikipedia.org/wiki/Brotli) algorithm. We serve `.gz` and `.html` as fallback, although `.br` [has good support](https://caniuse.com/brotli). |
| _Page reflow protection_ | To prevent page-reflow whilst lazy-loading images, we set image height and width using the `_plugins/jekyll-anti-image-reflow.rb` plugin. Note it will not override existing styling to loading, width or height attributes. |

#### Cosmetics
`Featherweight` allows you to enable numerous cosmetic upgrades for your site. Toggle these options in the `compression` settings in `_config.yml`. These cosmetics all add to the total page weight, but can significantly improve the UX.

Many of these are entirely optional settings. If you're looking to create a truly minimal webpage, read the comments inside `_config.yml`.

|||
|:--:|:--:|
| _SEO_ | Enabling search engine optimisations will add metadata for search engines and sharing on social media. |
| _Reading time_ | To display an estimated reading time for blog posts. |
| _Change font_ | Customise fonts for text + footer by editing `_layouts/default.html` and `_layouts/post.html` inline CSS. |
| _Load time_ | Show off your page load times at the foot of the homepage/blog posts. |
| _Blog post footer_ | Display social media links below blog posts. |
| _social-urls_, _resume_, _blogs_ | Toggle the display of each of these subsections on your homepage. |
| _CSS_ | Add some basic styling, based on [58 bytes of CSS to look great nearly everywhere](https://gist.github.com/JoeyBurzynski/617fb6201335779f8424ad9528b72c41). Also add some basic image styling to blog posts, working in combination with `anti-image-reflow` to fit images to the blog width without causing jank. |
| _favicon_, _icon_ | Both options require image urls. The favicon is the website icon, whilst the icon is used if the site is made into a webapp, or a shortcut on iOS devices, etc. `Favicon` accepts .ico, `icon` accepts .png of size 192x192. |

#### Dev
1. Clone this repository: `git clone https://github.com/Cutwell/featherweight.git`
2. Download the project dependencies: `bundle install`
3. Run a local Jekyll server: `bundle exec jekyll serve`