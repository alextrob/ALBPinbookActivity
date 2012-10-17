//
//  ALBPinbookActivity.h
//  PinbookActivity
//
//  Created by Collin Donnell on 9/27/12.
//  Copyright (c) 2012 Collin Donnell. All rights reserved.
//

#import <UIKit/UIKit.h>

// The activity type
extern NSString *const ALBActivityTypeSendToPinbook;

// Parameter keys for settings things besides the URL, like title, tags, etc.
// Strings:
extern NSString *const ALBPinbookTitleParameterKey;
extern NSString *const ALBPinbookTagsParameterKey; // Tags are a string separated by spaces.
extern NSString *const ALBPinbookDescriptionParameterKey;
// Booleans:
extern NSString *const ALBPinbookPrivateParameterKey;
extern NSString *const ALBPinbookReadLaterParameterKey;

@interface ALBPinbookActivity : UIActivity

@property (strong, nonatomic) NSDictionary *bookmarkParameters;

@end

/* Example
 
 ALBPinbookActivity *pinbookActivity = [[ALBPinbookActivity alloc] init];
 pinbookActivity.bookmarkParameters = @{ALBPinbookTitleParameterKey : @"Apple", ALBPinbookTagsParameterKey : @"companies mac iphone", ALBPinbookDescriptionParameterKey : @"They make nice things.", ALBPinbookPrivateParameterKey : @(YES), ALBPinbookReadLaterParameterKey : @(NO)};
 
 UIActivityViewController *viewController = [[UIActivityViewController alloc] initWithActivityItems:@[[NSURL URLWithString:@"http://apple.com"]] applicationActivities:@[pinbookActivity]];
 [self presentViewController:viewController animated:YES completion:nil];
 
*/
