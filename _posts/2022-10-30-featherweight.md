---
layout: post
title: Developing a lightweight theme for Jekyll.
description: A dev blog post, detailing how we developed Featherweight to deliver an optimised static blog experience.
---

![feather logo](/_posts/2022-10-30-featherweight/feather.png)

`Featherweight` was inspired by pages from the [1kb club](https://1kb.club/), a list of web pages weighing less than 1kb. In order to provide a feature-complete static blog experience, cosmetic features were added, but the minimalist experience can still achieve [< 1kb weight](https://github.com/Cutwell/1kb).

## Contents
* [Customising the site](#customising-the-site)
* [Writing a blog post](#writing-a-blog-post)
* [Content compression](#content-compression)
* [RSS feeds](#rss-feeds)

## Customising the site
You can add or update content on the homepage by editing the `index.md` markdown file. Your contact details can be updated by editing the `_includes_/contact.md` file, and the site name, site author, homepage description metadata, website language, etc., can be updated using `_config.yml`.

There are also a number of compression options to enable/disable cosmetic details. Enabling `css` adds CSS styling (inspired by [58 bytes of CSS to look great nearly everywhere](https://gist.github.com/JoeyBurzynski/617fb6201335779f8424ad9528b72c41) - customise the website CSS by editing `_includes/main.css`. Page footer and home-link adds social media links to post footer, and navigation from blog posts to the homepage. `load-time` prints the page load time to the homepage and blog posts, while `page-size` reports the total HTML page size; showing off the effectiveness of the theme!

## Writing a blog post
```
---
layout: post
title: Developing featherweight
description: A dev blog post, detailing how we developed Featherweight to deliver an optimised static blog experience.
---

Lorem ipsum..
```

Blog posts are compiled from `.md` files in the `/_posts` directory. The naming convention for posts is `YYYY-MM-DD-name-of-the-blog.md`. The metadata inside the `---` tags details that this is a blog post, with a certain title and description. Detailing the title here automatically adds it to the page, whilst the description is used as part of the page metadata.

## Content compression
Webpages are often split into numerous sub-files, such as HTML, CSS, JS and images, all of which need to be served and compiled into the complete page. Compressing this content (using lossless or lossy algorithms) reduces the bandwidth required to download the files.

Browser support for different compression techniques means we offer two compression options, as well as fallback uncompressed files for older browsers.

_gzip_ compression (using _[zopfli](https://github.com/philnash/jekyll-zopfli)_) produces `.gz` compressed files. GitHub Pages automatically applies this compression, however by pre-processing we can apply our own, more aggressive, compressions, as well as ensure non-GH users have access to this compression.

_[brotli](https://en.wikipedia.org/wiki/Brotli)_ compression is a newer and more efficient algorithm developed by Google. It has good support in modern browser releases, but can't be utilised by older browsers, requiring us to offer the more-supported `.gz` compression as an alternative.

## RSS feeds
Users can access an RSS feed of your blog from `https://yourgithubusername.github.io/feed`. This can be subscribed to using an RSS reader, or used to [display a list of your most recent blog posts in your GitHub profile README](https://github.com/Cutwell/Cutwell).

## Embed your homepage into your GitHub README
If you're hosting your site via GitHub, you can show your homepage within the README section of the repository. Your homepage is written using markdown, meaning you can copy/paste the content and have it render! 

1. If including social media links, copy the separate `_includes_/contact.md` content to replace the {% raw %}{% markdown _pages/contact.md %}{% endraw %} liquid tag.
2. If you want your latest blog posts to update without needing to copy-paste the website HTML, check out the [`gautamkrishnar/blog-post-workflow`](https://github.com/gautamkrishnar/blog-post-workflow) GitHub Action to read your own site's RSS feed and generate a blog list within your README.

## Remote themes
You can use `featherweight` as a remote theme - recieving the latest updates automatically!
Follow GitHub's [guide](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/adding-a-theme-to-your-github-pages-site-using-jekyll) for using and customising remote themes. In short, override theme files by creating replacements in your own repository mirroring the original file location.
