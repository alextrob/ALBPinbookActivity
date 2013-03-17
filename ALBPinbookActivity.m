//
//  ALBPinbookActivity.m
//  PinbookActivity
//
//  Created by Collin Donnell on 9/27/12.
//  Copyright (c) 2012 Collin Donnell. All rights reserved.
//

#import "ALBPinbookActivity.h"

NSString *const ALBActivityTypeSendToPinbook = @"ALBActivityTypeSendToPinbook";
NSString *const ALBPinbookTitleParameterKey = @"title";
NSString *const ALBPinbookTagsParameterKey = @"tags";
NSString *const ALBPinbookDescriptionParameterKey = @"description";
NSString *const ALBPinbookPrivateParameterKey = @"private";
NSString *const ALBPinbookReadLaterParameterKey = @"readlater";

@interface ALBPinbookActivity ()

@property (strong, nonatomic) NSURL *activityURL;

@end

@implementation ALBPinbookActivity

- (id)initWithCallbackURL:(NSURL *)callbackURL;
{
    self = [super init];
    if (self) {
        self.callbackURL = callbackURL;
        self.callbackSource = [[NSBundle mainBundle]objectForInfoDictionaryKey:@"CFBundleName"];
    }
    return self;
}

- (NSString *)activityType
{
    return ALBActivityTypeSendToPinbook;
}

- (NSString *)activityTitle
{
    return @"Send to Pinbook";
}

- (UIImage *)activityImage
{
    return [UIImage imageNamed:@"ALBPinbookActivityMask"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    return activityItems.count == 1 && [[activityItems lastObject] isKindOfClass:[NSURL class]] && [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"pinbook:///"]];
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    self.activityURL = [activityItems lastObject];    
}

- (void)performActivity
{
    BOOL didFinish = NO;
    
    NSMutableString *pinbookURLString = [NSMutableString stringWithFormat:
                                         @"pinbook://x-callback-url/add?url=%@&x-source=%@&x-success=%@&x-cancel=%@",
                                         [self.activityURL absoluteString],
                                         [self.callbackSource stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                                         [self.callbackURL.absoluteString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                                         [self.callbackURL.absoluteString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableArray *pathComponents = [NSMutableArray array];
    
    for (NSString *key in self.bookmarkParameters) {
        id parameterValue = self.bookmarkParameters[key];
        if ([parameterValue isKindOfClass:[NSNumber class]]) {
            parameterValue = [parameterValue boolValue] ? @"yes" : @"no";
        }
        
        if ([parameterValue isKindOfClass:[NSString class]] && [parameterValue length]) {
            [pathComponents addObject:[NSString stringWithFormat:@"%@=%@", key, parameterValue]];
        }
    }
    
    NSString *parameterString = [pathComponents componentsJoinedByString:@"&"];

    if ([parameterString length]) {
        [pinbookURLString appendFormat:@"&%@", parameterString];
    }
    
    NSURL *pinbookURL = [NSURL URLWithString:[pinbookURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    if ([[UIApplication sharedApplication] canOpenURL:pinbookURL]) {
        [[UIApplication sharedApplication] openURL:pinbookURL];
        didFinish = YES;
    }
    
    [self activityDidFinish:didFinish];
}

@end
