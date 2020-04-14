#import <UIKit/UIKit.h>
#import <Cordova/CDV.h>
#import <Cordova/CDVPlugin.h>
#import <Cordova/CDVPluginResult.h>
#import "CDVImgDownloader.h"
#import <Photos/Photos.h>

@implementation CDVImgDownloader

- (void)download:(CDVInvokedUrlCommand*)command {
	[self.commandDelegate runInBackground:^{
		NSString     *imgRelativePath   	= [command.arguments objectAtIndex:0]; //relative to dataDirectory => "Library/NoCloud"
	//	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
	  //  NSString *path = [paths objectAtIndex:0];

	 //   NSString *noCloud = @"NoCloud";
	  //  NSString *noCloudPath = [path stringByAppendingPathComponent:noCloud];
	    
	 //   NSString *imgPath = [noCloudPath stringByAppendingString:imgRelativePath];
	    
	    
	    UIImage *image = [UIImage imageWithContentsOfFile:imgRelativePath];
	    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);

		CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:imgPath];
		[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
	}];
}

- (void) downloadWithUrl: (CDVInvokedUrlCommand * ) command {
    CDVPluginResult * pluginResult = nil;
    NSURL * url = [NSURL URLWithString: [command.arguments objectAtIndex: 0]];
    NSData * args = [NSData dataWithContentsOfURL: url];

    if (args != nil && [args length] > 0) {
      @try {
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];

        if (status == PHAuthorizationStatusAuthorized) {
          // Access has been granted.
          [self saveImageToPhotos: pluginResult command: command data: args];
        } else if (status == PHAuthorizationStatusDenied) {
          // Access has been denied.
        } else if (status == PHAuthorizationStatusNotDetermined) {

          // Access has not been determined.
          [PHPhotoLibrary requestAuthorization: ^ (PHAuthorizationStatus status) {

            if (status == PHAuthorizationStatusAuthorized) {
              // Access has been granted.
              [self saveImageToPhotos: pluginResult command: command data: args];
            } else {
              // Access has been denied.
            }
          }];
        }

      }
      @catch(NSException * exception) {
        pluginResult = [CDVPluginResult resultWithStatus: CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult: pluginResult callbackId: command.callbackId];
      }
    }

  }

  - (void) saveImageToPhotos: (CDVPluginResult) pluginRes command: (CDVInvokedUrlCommand * ) command data: (NSData) data {

    UIImage * image = [UIImage imageWithData: data];
    // NSData *imgdata = UIImagePNGRepresentation(image);
    // UIImage *image2 = [UIImage imageWithData:imgdata];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image: didFinishSavingWithError: contextInfo: ), nil);

    pluginRes = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsString: @ "success"];
    [self.commandDelegate sendPluginResult: pluginRes callbackId: command.callbackId];

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
