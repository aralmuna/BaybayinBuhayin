//
//  BaybayinBuhayinAppDelegate.h
//  BaybayinBuhayin
//
//  Created by Paul Michael Laborte on 10/7/10.
//  Copyright AralMuna.Me. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaybayinBuhayinAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

