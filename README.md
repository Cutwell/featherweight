`Featherweight` is an ultra-lightweight Jekyll theme, aiming to minimise bandwidth usage and deliver a bare-bones experience (page sizes of ~1kb). 

[![Gem Version](https://img.shields.io/gem/v/featherweight?style=flat-square)][ruby-gems]

[ruby-gems]: https://rubygems.org/gems/featherweight


**Replacing X with Y**

|X|Y|
|:--:|:--:|
|Blog search|`ctrl+f`|
|Post styling|[Reader view](https://support.mozilla.org/en-US/kb/firefox-reader-view-clutter-free-web-pages)|
|Sharing links|_Copy/paste the URL_|

**Getting started**

1. Customise website ownership, update personal links, and detail CV experience using `_config.yml`.
2. Update `_pages/about.md` with an introduction.
3. Write some blogs, using `_posts/test.md` as a template.
4. You're ready to host your minimalist site!

**Building on GitHub**

If you're using this site on GitHub pages, the built-in build action won't run gems outside of the [supported plugins list](https://pages.github.com/versions/), e.g.: the `jekyll-loading-lazy` gem (which adds `loading="lazy"` tags to `iframes` and `img` tags, enabling faster initial page loads).

To enable these gems, use the `build_and_deploy.yml` action under `.github/workflows` to automatically build your site on pushes, which circumvents this restriction while still hosting to GitHub pages (as advised by [Jekyll](https://jekyllrb.com/docs/continuous-integration/github-actions/)).

**Notes**

|||
|:--:|:--:|
| _RSS_ | The RSS feed can be found at <https://yourgithubusername.github.io/feed>. |
| _Sitemap_ | The sitemap can be found at <https://yourgithubusername.github.io/sitemap>. |
| _Quickstart_ | Test your website locally by following the [Jekyll quickstart guide](https://jekyllrb.com/docs/). |
| _Naming convention_ | When naming blog post files, use the `YYYY-MM-DD-title.md` convention, or else your post won't appear in the blog post list. Read the [Jekyll docs](https://jekyllrb.com/docs/posts/). |