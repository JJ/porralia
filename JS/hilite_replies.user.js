// ==UserScript==
// @name                Hilite replies
// @namespace           http://geneura.org/projects/porralia
// @description         Hilights my own posts and replies in twitter
// @include             http://www.twitter.com/*
// @include             http://twitter.com/*
// ==/UserScript==

var whoami_url = document.evaluate('//a[@class="url"]/@href', document, null, XPathResult.STRING_TYPE, null);
var whoami = /com\/(\w+)/.exec(whoami_url.stringValue);
var user = whoami[1];
var posts = document.getElementsByTagName('td');
var at = "@"+whoami[1];
alert(at);
var whoami_re = new RegExp(at, "i");
  
var content ='';
for ( var p = 0; p < posts.length; p++ ) {
  if (posts[p].getAttribute('class') == 'content') {
    var this_url =  document.evaluate('strong/a/@href', posts[p], null, XPathResult.STRING_TYPE, null);
    if (this_url.stringValue == whoami_url.stringValue) {
      posts[p].style.backgroundColor = '#FFF5B4';
    }
    var this_content = document.evaluate('span', posts[p], null, XPathResult.STRING_TYPE, null);
    if (this_content.stringValue.match(whoami_re)){
      posts[p].style.backgroundColor = '#C9FFC4';
    }
  }
 }




