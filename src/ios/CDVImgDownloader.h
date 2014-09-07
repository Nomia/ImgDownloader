#import <Cordova/CDVPlugin.h>

@interface CDVImgDownloader : CDVPlugin {}

- (void)download:(CDVInvokedUrlCommand*)command;
- (void)downloadWithUrl:(CDVInvokedUrlCommand*)command;

@end
