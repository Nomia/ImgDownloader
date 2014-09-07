#import <Cordova/CDVPlugin.h>

@interface CDVClipboard : CDVPlugin {}

- (void)download:(CDVInvokedUrlCommand*)command;
- (void)downloadWithData:(CDVInvokedUrlCommand*)command;

@end