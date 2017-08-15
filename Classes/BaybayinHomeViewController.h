//
//  BaybayinViewController.h
//  Baybayin
//
//  Created by Paul Michael Laborte on 9/30/10.
//  Copyright AralMuna.Me. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaybayinWallViewController.h"
#import "ShakeToggleView.h"

@interface BaybayinHomeViewController : UIViewController<ShakeToggleDelegate> {
    IBOutlet UIButton *bambooBtn;
    IBOutlet UIImageView *bambooTopImg;
    IBOutlet UIImageView *headerImg;
    IBOutlet UIImageView *footerImg;
    IBOutlet UIImageView *bgImgView;
    IBOutlet UIImageView *imgA;
    IBOutlet UIImageView *imgB;
    IBOutlet UIImageView *imgK;
    IBOutlet UIImageView *imgD;
    IBOutlet UIButton *btnA;
    IBOutlet UIButton *btnB;
    IBOutlet UIButton *btnK;
    IBOutlet UIButton *btnD;
    IBOutlet UIButton *menuA;
    IBOutlet UIButton *menuB;
    IBOutlet UIButton *menuK;
    IBOutlet UIButton *menuD;
    IBOutlet UIButton *homePopup;
    BOOL toggleComplete;
    BOOL menuDisplayed;
    CGRect origFrameImgA;
    CGRect origFrameImgB;
    CGRect origFrameImgK;
    CGRect origFrameImgD;
    CGRect origFrameBtnA;
    CGRect origFrameBtnB;
    CGRect origFrameBtnK;
    CGRect origFrameBtnD;
    CGRect imgZeroFrame;
    CGRect btnZeroFrame;
}
@property (nonatomic, retain) UIImageView *bgImgView;
@property (nonatomic, retain) IBOutlet UIButton *bambooBtn;
@property (nonatomic, retain) IBOutlet UIImageView *bambooTopImg;
@property (nonatomic, retain) IBOutlet UIImageView *headerImg;
@property (nonatomic, retain) IBOutlet UIImageView *footerImg;
@property (nonatomic, retain) IBOutlet UIButton *btnA;
@property (nonatomic, retain) IBOutlet UIButton *btnB;
@property (nonatomic, retain) IBOutlet UIButton *btnK;
@property (nonatomic, retain) IBOutlet UIButton *btnD;
@property (nonatomic, retain) IBOutlet UIButton *menuA;
@property (nonatomic, retain) IBOutlet UIButton *menuB;
@property (nonatomic, retain) IBOutlet UIButton *menuK;
@property (nonatomic, retain) IBOutlet UIButton *menuD;
@property (nonatomic, retain) IBOutlet UIButton *homePopup;
@property (nonatomic, retain) IBOutlet UIImageView *imgA;
@property (nonatomic, retain) IBOutlet UIImageView *imgB;
@property (nonatomic, retain) IBOutlet UIImageView *imgK;
@property (nonatomic, retain) IBOutlet UIImageView *imgD;
@property (nonatomic, assign) BOOL toggleComplete;
@property (nonatomic, assign) BOOL menuDisplayed;
@property (nonatomic, assign) CGRect imgZeroFrame;
@property (nonatomic, assign) CGRect btnZeroFrame;
@property (nonatomic, assign) CGRect origFrameImgA;
@property (nonatomic, assign) CGRect origFrameImgB;
@property (nonatomic, assign) CGRect origFrameImgK;
@property (nonatomic, assign) CGRect origFrameImgD;
@property (nonatomic, assign) CGRect origFrameBtnA;
@property (nonatomic, assign) CGRect origFrameBtnB;
@property (nonatomic, assign) CGRect origFrameBtnK;
@property (nonatomic, assign) CGRect origFrameBtnD;

- (void)saveInitFrames;
- (void)hideMenus;
- (void)showMenus;
- (void)displayMenuLabels:(BOOL)showLabelAsButton;
- (IBAction)toggleMenu;
- (IBAction)baybayinIntro;
- (IBAction)seeWebsites;
- (IBAction)tracing;
- (IBAction)myBaybayin;
- (IBAction)closePopup;

extern const int OFFSET;

@end

