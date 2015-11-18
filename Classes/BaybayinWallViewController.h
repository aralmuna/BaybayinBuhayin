//
//  BaybayinWallViewController.h
//  BaybayinBuhayin
//
//  Created by Paul Michael Laborte on 10/8/10.
//  Copyright 2010 Kudlit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "PaintingView.h"

@interface BaybayinWallViewController : UIViewController <FBRequestDelegate, FBDialogDelegate, FBSessionDelegate> {
    Facebook *facebook;
    IBOutlet UIImageView *bgImgView;
    IBOutlet UIImageView *firstBaybayinImgView;
    IBOutlet PaintingView *paintingView;
    IBOutlet UIActivityIndicatorView *activityView;
    NSString *userId;
    NSString *userName;
    NSString *photoId;
    int lastRequestType;
    IBOutlet UIButton *yellowBtn;
    IBOutlet UIButton *blueBtn;
    IBOutlet UIButton *redBtn;
    IBOutlet UIView *shareOptionsView;
    IBOutlet UILabel *fbStatusLbl;
    IBOutlet UILabel *fbActionLbl;
    IBOutlet UIButton *logoutBtn;
    IBOutlet UIButton *wallPopup;
}

@property(retain,nonatomic) Facebook *facebook;
@property(retain,nonatomic) UIImageView *bgImgView;
@property(retain,nonatomic) UIImageView *firstBaybayinImgView;
@property(retain,nonatomic) PaintingView *paintingView;
@property(retain,nonatomic) UIActivityIndicatorView *activityView;
@property(retain,nonatomic) UIButton *yellowBtn;
@property(retain,nonatomic) UIButton *blueBtn;
@property(retain,nonatomic) UIButton *redBtn;
@property(retain,nonatomic) NSString *userId;
@property(retain,nonatomic) NSString *userName;
@property(retain,nonatomic) NSString *photoId;
@property(assign,nonatomic) int lastRequestType;
@property(retain,nonatomic) UIView *shareOptionsView;
@property(retain,nonatomic) UILabel *fbStatusLbl;
@property(retain,nonatomic) UILabel *fbActionLbl;
@property(retain,nonatomic) UIButton *logoutBtn;
@property(retain,nonatomic) UIButton *wallPopup;


- (void)login;
- (IBAction)logout;
- (void)postImg;
- (void)displayOptionsView;
- (void)updateFBLabels:(BOOL)loggedIn;
- (UIImage *)addImage:(UIImage *)image1 withFrame:(CGRect)frame1 toImage:(UIImage *)image2 withFrame:(CGRect)frame2;
- (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2;
- (IBAction)setYellow;
- (IBAction)setBlue;
- (IBAction)setRed;
- (IBAction)showFBOptions;
- (IBAction)dismissFBOptions;
- (IBAction)close;
- (IBAction)post;
- (IBAction)saveToCameraRoll;
- (IBAction)closePopup;

@end
