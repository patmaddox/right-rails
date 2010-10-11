/**
 * Sizzle engine support for RightJS
 *
 * Copyright (C) 2010 Nikolay Nemshilov
 */
(function(){function o(a,b,d,c,e,f){e=0;for(var g=c.length;e<g;e++){var h=c[e];if(h){h=h[a];for(var k=false;h;){if(h.sizcache===d){k=c[h.sizset];break}if(h.nodeType===1&&!f){h.sizcache=d;h.sizset=e}if(h.nodeName.toLowerCase()===b){k=h;break}h=h[a]}c[e]=k}}}function z(a,b,d,c,e,f){e=0;for(var g=c.length;e<g;e++){var h=c[e];if(h){h=h[a];for(var k=false;h;){if(h.sizcache===d){k=c[h.sizset];break}if(h.nodeType===1){if(!f){h.sizcache=d;h.sizset=e}if(typeof b!=="string"){if(h===b){k=true;break}}else if(j.filter(b,
[h]).length>0){k=h;break}}h=h[a]}c[e]=k}}}var x=/((?:\((?:\([^()]+\)|[^()]+)+\)|\[(?:\[[^\[\]]*\]|['"][^'"]*['"]|[^\[\]'"]+)+\]|\\.|[^ >+~,(\[\\]+)+|[>+~])(\s*,\s*)?((?:.|\r|\n)*)/g,y=0,A=Object.prototype.toString,t=false,B=true;[0,0].sort(function(){B=false;return 0});var j=function(a,b,d,c){d=d||[];var e=b=b||document;if(b.nodeType!==1&&b.nodeType!==9)return[];if(!a||typeof a!=="string")return d;var f=[],g,h,k,q,m=true,p=j.isXML(b),n=a,l;do{x.exec("");if(g=x.exec(n)){n=g[3];f.push(g[1]);if(g[2]){q=
g[3];break}}}while(g);if(f.length>1&&E.exec(a))if(f.length===2&&i.relative[f[0]])h=C(f[0]+f[1],b);else for(h=i.relative[f[0]]?[b]:j(f.shift(),b);f.length;){a=f.shift();if(i.relative[a])a+=f.shift();h=C(a,h)}else{if(!c&&f.length>1&&b.nodeType===9&&!p&&i.match.ID.test(f[0])&&!i.match.ID.test(f[f.length-1])){g=j.find(f.shift(),b,p);b=g.expr?j.filter(g.expr,g.set)[0]:g.set[0]}if(b){g=c?{expr:f.pop(),set:r(c)}:j.find(f.pop(),f.length===1&&(f[0]==="~"||f[0]==="+")&&b.parentNode?b.parentNode:b,p);h=g.expr?
j.filter(g.expr,g.set):g.set;if(f.length>0)k=r(h);else m=false;for(;f.length;){g=l=f.pop();if(i.relative[l])g=f.pop();else l="";if(g==null)g=b;i.relative[l](k,g,p)}}else k=[]}k||(k=h);k||j.error(l||a);if(A.call(k)==="[object Array]")if(m)if(b&&b.nodeType===1)for(a=0;k[a]!=null;a++){if(k[a]&&(k[a]===true||k[a].nodeType===1&&j.contains(b,k[a])))d.push(h[a])}else for(a=0;k[a]!=null;a++)k[a]&&k[a].nodeType===1&&d.push(h[a]);else d.push.apply(d,k);else r(k,d);if(q){j(q,e,d,c);j.uniqueSort(d)}return d};
j.uniqueSort=function(a){if(u){t=B;a.sort(u);if(t)for(var b=1;b<a.length;b++)a[b]===a[b-1]&&a.splice(b--,1)}return a};j.matches=function(a,b){return j(a,null,null,b)};j.find=function(a,b,d){var c;if(!a)return[];for(var e=0,f=i.order.length;e<f;e++){var g=i.order[e],h;if(h=i.leftMatch[g].exec(a)){var k=h[1];h.splice(1,1);if(k.substr(k.length-1)!=="\\"){h[1]=(h[1]||"").replace(/\\/g,"");c=i.find[g](h,b,d);if(c!=null){a=a.replace(i.match[g],"");break}}}}c||(c=b.getElementsByTagName("*"));return{set:c,
expr:a}};j.filter=function(a,b,d,c){for(var e=a,f=[],g=b,h,k,q=b&&b[0]&&j.isXML(b[0]);a&&b.length;){for(var m in i.filter)if((h=i.leftMatch[m].exec(a))!=null&&h[2]){var p=i.filter[m],n,l;l=h[1];k=false;h.splice(1,1);if(l.substr(l.length-1)!=="\\"){if(g===f)f=[];if(i.preFilter[m])if(h=i.preFilter[m](h,g,d,f,c,q)){if(h===true)continue}else k=n=true;if(h)for(var v=0;(l=g[v])!=null;v++)if(l){n=p(l,h,v,g);var D=c^!!n;if(d&&n!=null)if(D)k=true;else g[v]=false;else if(D){f.push(l);k=true}}if(n!==undefined){d||
(g=f);a=a.replace(i.match[m],"");if(!k)return[];break}}}if(a===e)if(k==null)j.error(a);else break;e=a}return g};j.error=function(a){throw"Syntax error, unrecognized expression: "+a;};var i=j.selectors={order:["ID","NAME","TAG"],match:{ID:/#((?:[\w\u00c0-\uFFFF\-]|\\.)+)/,CLASS:/\.((?:[\w\u00c0-\uFFFF\-]|\\.)+)/,NAME:/\[name=['"]*((?:[\w\u00c0-\uFFFF\-]|\\.)+)['"]*\]/,ATTR:/\[\s*((?:[\w\u00c0-\uFFFF\-]|\\.)+)\s*(?:(\S?=)\s*(['"]*)(.*?)\3|)\s*\]/,TAG:/^((?:[\w\u00c0-\uFFFF\*\-]|\\.)+)/,CHILD:/:(only|nth|last|first)-child(?:\((even|odd|[\dn+\-]*)\))?/,
POS:/:(nth|eq|gt|lt|first|last|even|odd)(?:\((\d*)\))?(?=[^\-]|$)/,PSEUDO:/:((?:[\w\u00c0-\uFFFF\-]|\\.)+)(?:\((['"]?)((?:\([^\)]+\)|[^\(\)]*)+)\2\))?/},leftMatch:{},attrMap:{"class":"className","for":"htmlFor"},attrHandle:{href:function(a){return a.getAttribute("href")}},relative:{"+":function(a,b){var d=typeof b==="string",c=d&&!/\W/.test(b);d=d&&!c;if(c)b=b.toLowerCase();c=0;for(var e=a.length,f;c<e;c++)if(f=a[c]){for(;(f=f.previousSibling)&&f.nodeType!==1;);a[c]=d||f&&f.nodeName.toLowerCase()===
b?f||false:f===b}d&&j.filter(b,a,true)},">":function(a,b){var d=typeof b==="string",c,e=0,f=a.length;if(d&&!/\W/.test(b))for(b=b.toLowerCase();e<f;e++){if(c=a[e]){d=c.parentNode;a[e]=d.nodeName.toLowerCase()===b?d:false}}else{for(;e<f;e++)if(c=a[e])a[e]=d?c.parentNode:c.parentNode===b;d&&j.filter(b,a,true)}},"":function(a,b,d){var c=y++,e=z,f;if(typeof b==="string"&&!/\W/.test(b)){f=b=b.toLowerCase();e=o}e("parentNode",b,c,a,f,d)},"~":function(a,b,d){var c=y++,e=z,f;if(typeof b==="string"&&!/\W/.test(b)){f=
b=b.toLowerCase();e=o}e("previousSibling",b,c,a,f,d)}},find:{ID:function(a,b,d){if(typeof b.getElementById!=="undefined"&&!d)return(a=b.getElementById(a[1]))&&a.parentNode?[a]:[]},NAME:function(a,b){if(typeof b.getElementsByName!=="undefined"){for(var d=[],c=b.getElementsByName(a[1]),e=0,f=c.length;e<f;e++)c[e].getAttribute("name")===a[1]&&d.push(c[e]);return d.length===0?null:d}},TAG:function(a,b){return b.getElementsByTagName(a[1])}},preFilter:{CLASS:function(a,b,d,c,e,f){a=" "+a[1].replace(/\\/g,
"")+" ";if(f)return a;f=0;for(var g;(g=b[f])!=null;f++)if(g)if(e^(g.className&&(" "+g.className+" ").replace(/[\t\n]/g," ").indexOf(a)>=0))d||c.push(g);else if(d)b[f]=false;return false},ID:function(a){return a[1].replace(/\\/g,"")},TAG:function(a){return a[1].toLowerCase()},CHILD:function(a){if(a[1]==="nth"){var b=/(-?)(\d*)n((?:\+|-)?\d*)/.exec(a[2]==="even"&&"2n"||a[2]==="odd"&&"2n+1"||!/\D/.test(a[2])&&"0n+"+a[2]||a[2]);a[2]=b[1]+(b[2]||1)-0;a[3]=b[3]-0}a[0]=y++;return a},ATTR:function(a,b,d,
c,e,f){b=a[1].replace(/\\/g,"");if(!f&&i.attrMap[b])a[1]=i.attrMap[b];if(a[2]==="~=")a[4]=" "+a[4]+" ";return a},PSEUDO:function(a,b,d,c,e){if(a[1]==="not")if((x.exec(a[3])||"").length>1||/^\w/.test(a[3]))a[3]=j(a[3],null,null,b);else{a=j.filter(a[3],b,d,true^e);d||c.push.apply(c,a);return false}else if(i.match.POS.test(a[0])||i.match.CHILD.test(a[0]))return true;return a},POS:function(a){a.unshift(true);return a}},filters:{enabled:function(a){return a.disabled===false&&a.type!=="hidden"},disabled:function(a){return a.disabled===
true},checked:function(a){return a.checked===true},selected:function(a){return a.selected===true},parent:function(a){return!!a.firstChild},empty:function(a){return!a.firstChild},has:function(a,b,d){return!!j(d[3],a).length},header:function(a){return/h\d/i.test(a.nodeName)},text:function(a){return"text"===a.type},radio:function(a){return"radio"===a.type},checkbox:function(a){return"checkbox"===a.type},file:function(a){return"file"===a.type},password:function(a){return"password"===a.type},submit:function(a){return"submit"===
a.type},image:function(a){return"image"===a.type},reset:function(a){return"reset"===a.type},button:function(a){return"button"===a.type||a.nodeName.toLowerCase()==="button"},input:function(a){return/input|select|textarea|button/i.test(a.nodeName)}},setFilters:{first:function(a,b){return b===0},last:function(a,b,d,c){return b===c.length-1},even:function(a,b){return b%2===0},odd:function(a,b){return b%2===1},lt:function(a,b,d){return b<d[3]-0},gt:function(a,b,d){return b>d[3]-0},nth:function(a,b,d){return d[3]-
0===b},eq:function(a,b,d){return d[3]-0===b}},filter:{PSEUDO:function(a,b,d,c){var e=b[1],f=i.filters[e];if(f)return f(a,d,b,c);else if(e==="contains")return(a.textContent||a.innerText||j.getText([a])||"").indexOf(b[3])>=0;else if(e==="not"){b=b[3];d=0;for(c=b.length;d<c;d++)if(b[d]===a)return false;return true}else j.error("Syntax error, unrecognized expression: "+e)},CHILD:function(a,b){var d=b[1],c=a;switch(d){case "only":case "first":for(;c=c.previousSibling;)if(c.nodeType===1)return false;if(d===
"first")return true;c=a;case "last":for(;c=c.nextSibling;)if(c.nodeType===1)return false;return true;case "nth":d=b[2];var e=b[3];if(d===1&&e===0)return true;var f=b[0],g=a.parentNode;if(g&&(g.sizcache!==f||!a.nodeIndex)){var h=0;for(c=g.firstChild;c;c=c.nextSibling)if(c.nodeType===1)c.nodeIndex=++h;g.sizcache=f}c=a.nodeIndex-e;return d===0?c===0:c%d===0&&c/d>=0}},ID:function(a,b){return a.nodeType===1&&a.getAttribute("id")===b},TAG:function(a,b){return b==="*"&&a.nodeType===1||a.nodeName.toLowerCase()===
b},CLASS:function(a,b){return(" "+(a.className||a.getAttribute("class"))+" ").indexOf(b)>-1},ATTR:function(a,b){var d=b[1];d=i.attrHandle[d]?i.attrHandle[d](a):a[d]!=null?a[d]:a.getAttribute(d);var c=d+"",e=b[2],f=b[4];return d==null?e==="!=":e==="="?c===f:e==="*="?c.indexOf(f)>=0:e==="~="?(" "+c+" ").indexOf(f)>=0:!f?c&&d!==false:e==="!="?c!==f:e==="^="?c.indexOf(f)===0:e==="$="?c.substr(c.length-f.length)===f:e==="|="?c===f||c.substr(0,f.length+1)===f+"-":false},POS:function(a,b,d,c){var e=i.setFilters[b[2]];
if(e)return e(a,d,b,c)}}},E=i.match.POS,F=function(a,b){return"\\"+(b-0+1)};for(var w in i.match){i.match[w]=RegExp(i.match[w].source+/(?![^\[]*\])(?![^\(]*\))/.source);i.leftMatch[w]=RegExp(/(^(?:.|\r|\n)*?)/.source+i.match[w].source.replace(/\\(\d+)/g,F))}var r=function(a,b){a=Array.prototype.slice.call(a,0);if(b){b.push.apply(b,a);return b}return a};try{Array.prototype.slice.call(document.documentElement.childNodes,0)}catch(G){r=function(a,b){var d=b||[],c=0;if(A.call(a)==="[object Array]")Array.prototype.push.apply(d,
a);else if(typeof a.length==="number")for(var e=a.length;c<e;c++)d.push(a[c]);else for(;a[c];c++)d.push(a[c]);return d}}var u,s;if(document.documentElement.compareDocumentPosition)u=function(a,b){if(a===b){t=true;return 0}if(!a.compareDocumentPosition||!b.compareDocumentPosition)return a.compareDocumentPosition?-1:1;return a.compareDocumentPosition(b)&4?-1:1};else{u=function(a,b){var d=[],c=[],e=a.parentNode,f=b.parentNode,g=e;if(a===b){t=true;return 0}else if(e===f)return s(a,b);else if(e){if(!f)return 1}else return-1;
for(;g;){d.unshift(g);g=g.parentNode}for(g=f;g;){c.unshift(g);g=g.parentNode}e=d.length;f=c.length;for(g=0;g<e&&g<f;g++)if(d[g]!==c[g])return s(d[g],c[g]);return g===e?s(a,c[g],-1):s(d[g],b,1)};s=function(a,b,d){if(a===b)return d;for(a=a.nextSibling;a;){if(a===b)return-1;a=a.nextSibling}return 1}}j.getText=function(a){for(var b="",d,c=0;a[c];c++){d=a[c];if(d.nodeType===3||d.nodeType===4)b+=d.nodeValue;else if(d.nodeType!==8)b+=j.getText(d.childNodes)}return b};(function(){var a=document.createElement("div"),
b="script"+(new Date).getTime();a.innerHTML="<a name='"+b+"'/>";var d=document.documentElement;d.insertBefore(a,d.firstChild);if(document.getElementById(b)){i.find.ID=function(c,e,f){if(typeof e.getElementById!=="undefined"&&!f)return(e=e.getElementById(c[1]))?e.id===c[1]||typeof e.getAttributeNode!=="undefined"&&e.getAttributeNode("id").nodeValue===c[1]?[e]:undefined:[]};i.filter.ID=function(c,e){var f=typeof c.getAttributeNode!=="undefined"&&c.getAttributeNode("id");return c.nodeType===1&&f&&f.nodeValue===
e}}d.removeChild(a);d=a=null})();(function(){var a=document.createElement("div");a.appendChild(document.createComment(""));if(a.getElementsByTagName("*").length>0)i.find.TAG=function(b,d){var c=d.getElementsByTagName(b[1]);if(b[1]==="*"){for(var e=[],f=0;c[f];f++)c[f].nodeType===1&&e.push(c[f]);c=e}return c};a.innerHTML="<a href='#'></a>";if(a.firstChild&&typeof a.firstChild.getAttribute!=="undefined"&&a.firstChild.getAttribute("href")!=="#")i.attrHandle.href=function(b){return b.getAttribute("href",
2)};a=null})();document.querySelectorAll&&function(){var a=j,b=document.createElement("div");b.innerHTML="<p class='TEST'></p>";if(!(b.querySelectorAll&&b.querySelectorAll(".TEST").length===0)){j=function(c,e,f,g){e=e||document;if(!g&&e.nodeType===9&&!j.isXML(e))try{return r(e.querySelectorAll(c),f)}catch(h){}return a(c,e,f,g)};for(var d in a)j[d]=a[d];b=null}}();(function(){var a=document.createElement("div");a.innerHTML="<div class='test e'></div><div class='test'></div>";if(!(!a.getElementsByClassName||
a.getElementsByClassName("e").length===0)){a.lastChild.className="e";if(a.getElementsByClassName("e").length!==1){i.order.splice(1,0,"CLASS");i.find.CLASS=function(b,d,c){if(typeof d.getElementsByClassName!=="undefined"&&!c)return d.getElementsByClassName(b[1])};a=null}}})();j.contains=document.compareDocumentPosition?function(a,b){return!!(a.compareDocumentPosition(b)&16)}:function(a,b){return a!==b&&(a.contains?a.contains(b):true)};j.isXML=function(a){return(a=(a?a.ownerDocument||a:0).documentElement)?
a.nodeName!=="HTML":false};var C=function(a,b){for(var d=[],c="",e,f=b.nodeType?[b]:b;e=i.match.PSEUDO.exec(a);){c+=e[0];a=a.replace(i.match.PSEUDO,"")}a=i.relative[a]?a+"*":a;e=0;for(var g=f.length;e<g;e++)j(a,f[e],d);return j.filter(c,d)};window.Sizzle=j})();RightJS([RightJS.Document,RightJS.Element]).each("include",{first:function(o){return this.find(o)[0]},find:function(o){return RightJS(Sizzle(o,this._)).map(RightJS.$)}});
