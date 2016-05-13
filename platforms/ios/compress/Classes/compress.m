//
//  compress.m
//  compress
//
//  Created by Wisemen on 13/05/2016.
//
//

#import "compress.h"
#import <Cordova/CDV.h>

@implementation compress

@synthesize callbackId;


- (void)compress:(CDVInvokedUrlCommand*)command
{
    self.callbackId = command.callbackId;
    
    NSString * options = [command.arguments objectAtIndex:0];
    
    
    NSURL *url = [NSURL URLWithString:options];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [[[UIImage alloc] initWithData:data]autorelease];
     NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString* string = [self generateRandomString:5];
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString * s1 = @".jpg";
    string = [string stringByAppendingString:s1 ];
    NSString* filename = string;
     NSString* imagePath = [documentsDirectory stringByAppendingPathComponent:filename];
    
    UIImage *newImage=image;
    CGSize size=CGSizeMake(110,110);
    newImage=[self resizeImage:newImage newSize:size];
    
    NSData* compressed_imageData = UIImageJPEGRepresentation(newImage, 0.5);
    [compressed_imageData writeToFile:imagePath atomically:YES];
    
    
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:imagePath];
    [self.commandDelegate sendPluginResult:result callbackId:self.callbackId];

}


-(NSString*)generateRandomString:(int)num {
    NSMutableString* string = [NSMutableString stringWithCapacity:num];
    for (int i = 0; i < num; i++) {
        [string appendFormat:@"%C", (unichar)('a' + arc4random_uniform(25))];
    }
    return string;
}

- (UIImage *)resizeImage:(UIImage*)image newSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


- (void) dealloc
{
    [callbackId release];
    [super dealloc];
}
@end
