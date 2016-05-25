//
//  ShakeToggleView.h
//  BaybayinBuhayin
//
//  Created by Paul Michael Laborte on 11/21/10.
//  Copyright AralMuna.Me. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShakeToggleDelegate 
@required
- (void)respondToShake;
@end  // ShakeToggleDelegate

@interface ShakeToggleView : UIView {
    id<ShakeToggleDelegate> shakeDelegate;
}

@property(assign,nonatomic) id<ShakeToggleDelegate> shakeDelegate;

@end
