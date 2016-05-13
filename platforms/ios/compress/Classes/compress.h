//
//  compress.h
//  compress
//
//  Created by Wisemen on 13/05/2016.
//
//

#import <Cordova/CDVPlugin.h>


@interface compress : CDVPlugin
{
    NSString* callbackId;
}

@property (nonatomic,copy) NSString* callbackId;

- (void)compress:(CDVInvokedUrlCommand*)command;

@end
