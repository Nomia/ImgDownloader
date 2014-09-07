#import <UIKit/UIKit.h>
#import <Cordova/CDV.h>
#import <Cordova/CDVPlugin.h>
#import <Cordova/CDVPluginResult.h>
#import "CDVImgDownloader.h"

@implementation CDVImgDownloader

- (void)download:(CDVInvokedUrlCommand*)command {
	[self.commandDelegate runInBackground:^{
		NSString     *imgRelativePath   	= [command.arguments objectAtIndex:0]; //relative to dataDirectory => "Library/NoCloud"
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
	    NSString *path = [paths objectAtIndex:0];

	    NSString *noCloud = @"NoCloud";
	    NSString *noCloudPath = [path stringByAppendingPathComponent:noCloud];
	    
	    NSString *imgPath = [noCloudPath stringByAppendingString:imgRelativePath];
	    
	    
	    UIImage *image = [UIImage imageWithContentsOfFile:imgPath];
	    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);

		CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:imgPath];
		[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
	}];
}

- (void)downloadWithUrl:(CDVInvokedUrlCommand*)command {
	CDVPluginResult *pluginResult = nil;
    NSURL *url = [NSURL URLWithString:[command.arguments objectAtIndex:0]];
	NSData *args = [NSData dataWithContentsOfURL:url];

	if (args != nil && [args length] > 0) {
		 @try
        {
            UIImage *image = [UIImage imageWithData:args];
            NSData *imgdata = UIImagePNGRepresentation(image);
            UIImage *image2 = [UIImage imageWithData:imgdata];
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);


            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"success"];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
        @catch (NSException *exception) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
	}

}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo
{
    // Was there an error?
    if (error != NULL)
    {
        // Show error message...
        NSLog(@"Something wrong happened");

    }
    else  // No errors
    {
        // Show message image successfully saved

    }
}

@end
