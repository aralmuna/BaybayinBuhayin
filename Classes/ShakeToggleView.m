//
//  ShakeToggleView.m
//  BaybayinBuhayin
//
//  Created by Paul Michael Laborte on 11/21/10.
//  Copyright AralMuna.Me. All rights reserved.
//

#import "ShakeToggleView.h"


@implementation ShakeToggleView

@synthesize shakeDelegate;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
    [super dealloc];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if ( event.subtype == UIEventSubtypeMotionShake ) {
        // Put in code here to handle shake
        [shakeDelegate respondToShake];
    }
    
    if ( [super respondsToSelector:@selector(motionEnded:withEvent:)] )
        [super motionEnded:motion withEvent:event];
}

- (BOOL)canBecomeFirstResponder {
    return YES; 
}


@end
