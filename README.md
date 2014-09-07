ImgDownloader(IOS only)
=============

A phongap plugin that provides the functionality to download image files(from internet or local dataDirectory) to iphone photos gallery.

Installation:
===
    phonegap plugin add https://github.com/Nomia/ImgDownloader.git
    
Interface:
===
    cordova.plugins.imgDownloader

Methods:
===
    download(relativeUrl[,onsuccess[,onerror]]) //'relativeUrl' relative to Library/NoCloud  e.g. "/myimage/logo.png"
    
    downloadWithUrl(url[,onsuccess[,onerror]])  //'url' can be any online resource url or dataURI

Examples:
===

1.download from a url when device is ready

    document.addEventListener("deviceready",onDeviceReady);
    
    //google logo url
    url = 'https://www.google.com/images/srpr/logo11w.png';
    
    onDeviceReady = function(){
        cordova.plugins.imgDownloader.downloadWithUrl(url,function(){
            alert("success");
        },function(){
            alert("error");
        });        
    }
    
    //also you can try dataUri like: 1px gif
    //url = 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7'
    
2.download a local image file:
  *Assume you have a file inside you app's dataDirectory(/Library/NoCloud/) and the path is /Library/NoCloud/myImages/logo.png, then you could move it to image gallery using the following code snippit
  
    document.addEventListener("deviceready",onDeviceReady);
    
    onDeviceReady = function(){
        cordova.plugins.imgDownloader.download("/myImages/logo.png",function(){
            alert("success");
        },function(){
            alert("error");
        });        
    }

You can use this plugin at your ease, at your own risk. Thanks..
    
    
