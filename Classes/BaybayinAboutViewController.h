//
//  BaybayinAboutViewController.h
//  BaybayinBuhayin
//
//  Created by Paul Michael Laborte on 11/26/10.
//  Copyright AralMuna.Me. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BaybayinAboutViewController : UIViewController<UIScrollViewDelegate> {
    IBOutlet UIImageView *aboutImgView;
    IBOutlet UIScrollView *scrollView;
}

@property(nonatomic,retain) UIImageView *aboutImgView;
@property(nonatomic,retain) UIScrollView *scrollView;

- (IBAction)close;
- (void)displayAbout;

@end
