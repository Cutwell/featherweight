---
layout: default
---
# Hi, I'm {{ site.author }}!

An ultra-lightweight Jekyll theme, aiming to minimise bandwidth usage and deliver a bare-bones experience.

{% markdown _pages/contact.md %}

_Blog posts_
{% if site.compression.blogs and site.posts %}
<table>{% for post in site.posts %}<tr><td class="d">{{ post.date | date: "%B %e, %Y" }} >></td><td><a href="{{ site.url }}{{ post.url }}">{{ post.title }}</a></td></tr>{% endfor %}</table>
{% endif %}