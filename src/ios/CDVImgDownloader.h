#import <Cordova/CDVPlugin.h>

@interface CDVImgDownloader : CDVPlugin {}

- (void)download:(CDVInvokedUrlCommand*)command;
- (void)downloadWithData:(CDVInvokedUrlCommand*)command;

@end
