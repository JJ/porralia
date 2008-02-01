// ==UserScript==
// @name                Hiliteme
// @namespace           http://geneura.org/projects/porralia
// @description         Hilights my own posts in twitter
// @include             http://www.twitter.com/home
// @include             http://twitter.com/home
// ==/UserScript==

var whoami_url = document.evaluate('//a[@class="url"]/@href', document, null, XPathResult.STRING_TYPE, null);
var whoami = /com\/(\w+)/.exec(whoami_url.stringValue);
var user = whoami[1];
var posts = document.getElementsByTagName('td');
  
for ( var p = 0; p < posts.length; p++ ) {
  if (posts[p].getAttribute('class') == 'content') {
    var this_url =  document.evaluate('strong/a/@href', posts[p], null, XPathResult.STRING_TYPE, null);
    if (this_url.stringValue == whoami_url.stringValue) {
      posts[p].style.backgroundColor = 'yellow';
    }
  }
 }



