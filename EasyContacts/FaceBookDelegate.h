//
//  FaceBookDelegate.h
//  EasyContacts
//
//  Created by Sathish  Kumar on 20/05/12.
//  Copyright (c) 2012 8600@thoughtworks.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

@interface FaceBookDelegate : NSObject 
<UIApplicationDelegate, FBSessionDelegate>

@property (nonatomic, retain) Facebook *facebook;
-(void)syncFromFacebook;

@end
