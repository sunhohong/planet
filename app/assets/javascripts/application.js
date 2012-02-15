// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require bootstrap.min
//= require_tree .

/*
 *  Usage ==
 *    hashToParam({ location : 34, title : "This is a utility function." });
 *      => "location=34&title=This is a utility function."
 */
function hashToParam(hash) {
  if (!isJson(hash)) return;

  // It's weird, but jQuery documentation says function param order in $.map is (val, key).
  return $.map(hash, function(val, key) {
    return key + '=' + val;
  }).join('&');
}

/*
 *  Usage ==
 *    mergeUrl("http://bluechiz.com/items?format=json&id=1", { id : 9999, title : "merge" });
 *      => "http://bluechiz.com/items?format=json&id=9999&title=merge"
 */
function mergeUrl(url, hash) {
  if (!isJson(hash)) return url;

  if (url.indexOf('?')) {
    $.each(url.split('?')[1].split('&'), function(index, p) {
      param = p.split('=');
      if (!eval('hash.' + param[0]) && param[1]) {
        eval('hash.' + param[0] + '="' + param[1] + '"');
      }
    });
    url = url.split('?')[0];
  }

  return url + '?' + hashToParam(hash);
}

function isJson(obj) {
  try{
    JSON.stringify(obj);
    return true;
  } catch(e) {
    return false;
  }
}

function getCookie(name)
{
  name += '=';
  var parts = document.cookie.split(/;\s*/);
  for (var i = 0; i < parts.length; i++)
  {
    var part = parts[i];
    if (part.indexOf(name) == 0)
      return decodeURI(part.substring(name.length)).replace(/\+/g, ' ');
  }
  return null;
}