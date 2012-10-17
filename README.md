# ALBPinbookActivity
ALBPinbookActivity is a UIActivity subclass which allows developers to send bookmark information to Pinbook so that it can be presented as an option in a UIActivityViewController whenever a URL is shared, and added to the users Pinboard account.

## Adding to a Project
Add the following four files to your project:

* ALBPinbookActivity.h
* ALBPinbookActivity.m
* ALBPinbookActivityMask.png
* ALBPinbookActivityMask@2x.png

## Use
Just create a new ALBPinbookActivity object and use it with a UIActivityViewController. Pinbook will appear as an option only if the user has it installed on their device.

Optionally, set the `bookmarkParameters` property using an NSDictionary to pre-fill Pinbook’s fields with any information you like, as shown in the following example:

	ALBPinbookActivity *activity = [[ALBPinbookActivity alloc] init];
    activity.bookmarkParameters = @{ALBPinbookTitleParameterKey : @"Apple", ALBPinbookTagsParameterKey : @"companies mac iphone", ALBPinbookDescriptionParameterKey : @"They make nice things.", ALBPinbookPrivateParameterKey : @(YES), ALBPinbookReadLaterParameterKey : @(NO)};
    
    UIActivityViewController *viewController = [[UIActivityViewController alloc] initWithActivityItems:@[[NSURL URLWithString:@"http://apple.com"]] applicationActivities:@[activity]];
    [self presentViewController:viewController animated:YES completion:nil];

## Parameter Keys

* `ALBPinbookTitleParameterKey`: Any string.
* `ALBPinbookTagsParameterKey`: A string of tags separated by spaces.
* `ALBPinbookDescriptionParameterKey`: Any string.
* `ALBPinbookPrivateParameterKey`: BOOL (YES/NO).
* `ALBPinbookReadLaterParameterKey`: BOOL (YES/NO).
