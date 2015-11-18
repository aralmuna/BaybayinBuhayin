//
//  BaybayinSlideViewController.h
//  BaybayinSlide
//
//  Created by Paul Michael Laborte on 11/6/10.
//  Copyright 2010 Kudlit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <audiotoolbox/AudioToolbox.h>
#import "PaintingView.h"

@interface BaybayinSlideViewController : UIViewController {
    IBOutlet UIImageView *traceImageView;
    IBOutlet UIImageView *traceImageViewB;
    IBOutlet UIButton *leftBtn;
    IBOutlet UIButton *leftBtnB;    
    IBOutlet UIButton *rightBtn;
    IBOutlet UIButton *rightBtnB;
    IBOutlet UIButton *soundBtn;
    IBOutlet UIButton *soundBtnB;    
    IBOutlet PaintingView *paintingView;
    IBOutlet UIButton *tracePopup;
    IBOutlet UIButton *seeAllBtn;
    IBOutlet UIView *allCharsView;
    NSArray *charArray;
    int position;
    BOOL origImgViewIsActive;
}

@property(retain,nonatomic) UIImageView *traceImageView;
@property(retain,nonatomic) UIImageView *traceImageViewB;
@property(retain,nonatomic) UIButton *leftBtn;
@property(retain,nonatomic) UIButton *rightBtn;
@property(retain,nonatomic) UIButton *soundBtn;
@property(retain,nonatomic) UIButton *leftBtnB;
@property(retain,nonatomic) UIButton *rightBtnB;
@property(retain,nonatomic) UIButton *soundBtnB;
@property(retain,nonatomic) PaintingView *paintingView;
@property(retain,nonatomic) UIButton *tracePopup;
@property(retain,nonatomic) UIButton *seeAllBtn;
@property(retain,nonatomic) UIView *allCharsView;
@property(retain,nonatomic) NSArray *charArray;
@property(assign,nonatomic) int position;
@property(assign,nonatomic) BOOL origImgViewIsActive;
@property(assign,nonatomic) SystemSoundID soundID;

- (IBAction)close;
- (void)displayChar:(BOOL)rightToLeft animated:(BOOL)willAnimate;
- (IBAction)playSound;
- (IBAction)prev;
- (IBAction)next;
- (IBAction)closePopup;
- (IBAction)seeAll;
- (IBAction)closeAllChars;
- (IBAction)jumpToChar:(id)sender;

@end

