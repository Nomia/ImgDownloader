var cordova = require('cordova');

ImgDownloader = function(){}

ImgDownloader.prototype.download = function(src,onsuccess,onerror){
	cordova.exec(onsuccess, onerror, "ImgDownloader", "download", [src]);
};

ImgDownloader.prototype.downloadWithUrl = function(url,onsuccess,onerror){
	cordova.exec(onsuccess, onerror, "ImgDownloader", "downloadWithUrl", [url]);
};

// Register the plugin
var imgDownloader = new ImgDownloader();
module.exports = imgDownloader;