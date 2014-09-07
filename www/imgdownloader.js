var cordova = require('cordova');

ImgDownloader = function(){}

ImgDownloader.prototype.download = function(src,onsuccess,onerror){
	cordova.exec(onsuccess, onerror, "ImgDownloader", "download", [src]);
};

ImgDownloader.prototype.downloadWithData = function(data,onsuccess,onerror){
	cordova.exec(onsuccess, onerror, "ImgDownloader", "downloadWithData", [data]);
};

// Register the plugin
var imgDownloader = new ImgDownloader();
module.exports = imgDownloader;