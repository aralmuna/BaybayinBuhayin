//
//  BaybayinSlideViewController.m
//  BaybayinSlide
//
//  Created by Paul Michael Laborte on 11/6/10.
//  Copyright AralMuna.Me. All rights reserved.
//

#import "BaybayinSlideViewController.h"

static NSString* kTracingInfoPopupDisplayed = @"tracing_info_popup_displayed";
const int X1 = 562; // 480(460) -> 592(568)
const int X2 = 1629; // 1320(460) -> 1629(568)

@implementation BaybayinSlideViewController

@synthesize charArray;
@synthesize traceImageView;
@synthesize traceImageViewB;
@synthesize leftBtn;
@synthesize rightBtn;
@synthesize soundBtn;
@synthesize leftBtnB;
@synthesize rightBtnB;
@synthesize soundBtnB;
@synthesize paintingView;
@synthesize position;
@synthesize origImgViewIsActive;
@synthesize soundID;
@synthesize tracePopup;
@synthesize seeAllBtn;
@synthesize allCharsView;

// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        NSArray *tempChars = [NSArray arrayWithObjects:@"TraceA", @"TraceEI", @"TraceOU", @"TraceBa", @"TraceKa", @"TraceDaRa", 
                              @"TraceGa", @"TraceHa", @"TraceLa", @"TraceMa", @"TraceNa", @"TraceNga", 
                              @"TracePa", @"TraceSa", @"TraceTa", @"TraceWa", @"TraceYa", nil];
        self.charArray = tempChars;        
    }
    return self;
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (void)viewDidLoad {    
    [super viewDidLoad];
    [paintingView setBrushColorWithRed:255.0f/255.0f green:109.0f/255.0f blue:0.0f/255.0f];    
    [self displayChar:YES animated:NO];
}

- (void) viewWillAppear:(BOOL)animated {
    [paintingView becomeFirstResponder];
    [super viewWillAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated {
    [paintingView resignFirstResponder];
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    BOOL tracingPopupDisplayed = [settings boolForKey:kTracingInfoPopupDisplayed];

    if (!tracingPopupDisplayed) {
        // display popup saying home screen instructions
        [UIView beginAnimations:@"showPopup" context:nil];
        [UIView setAnimationDuration:0.3];
        tracePopup.alpha = 1;
        [UIView commitAnimations];  
        
        // set tracing popup flag to "displayed"
        [settings setBool:YES forKey:kTracingInfoPopupDisplayed];
        [settings synchronize];
    }
}

- (void)playSound {    
    AudioServicesPlaySystemSound(soundID);
}

- (void)close {
    if (!origImgViewIsActive) {
        self.traceImageViewB.alpha = 0;
    } else {
        self.traceImageView.alpha = 0;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)prev {
    position -= 1;
    if (position < 0) position = (int) [charArray count] - 1;
    [self displayChar:NO animated:YES];
}

- (void)next {
    position += 1;
    if (position >= [charArray count]) position = 0;
    [self displayChar:YES animated:YES];
}

- (void)displayChar:(BOOL)rightToLeft animated:(BOOL)willAnimate {
    
    [paintingView erase];
    
    if (soundID) AudioServicesDisposeSystemSoundID(soundID);
    
    UIImageView *currentView;
    UIImageView *nextView;
    UIButton *currentLeftBtn;
    UIButton *nextLeftBtn;
    UIButton *currentRightBtn;
    UIButton *nextRightBtn;
    UIButton *currentSoundBtn;    
    UIButton *nextSoundBtn;
    
    if (origImgViewIsActive) {
        currentView = traceImageViewB;
        nextView = traceImageView;
        currentLeftBtn = leftBtnB;
        nextLeftBtn = leftBtn;
        currentRightBtn = rightBtnB;
        nextRightBtn = rightBtn;
        currentSoundBtn = soundBtnB;
        nextSoundBtn = soundBtn;
        origImgViewIsActive = NO;
    } else {
        currentView = traceImageView;
        nextView = traceImageViewB;
        currentLeftBtn = leftBtn;
        nextLeftBtn = leftBtnB;
        currentRightBtn = rightBtn;
        nextRightBtn = rightBtnB;
        currentSoundBtn = soundBtn;
        nextSoundBtn = soundBtnB;      
        origImgViewIsActive = YES;
    }
    NSString *nextCharName = [charArray objectAtIndex:position];
    NSLog(@"trace %@", nextCharName);
    
    // trace image origin
    CGPoint center = CGPointMake(295, 160);
    NSString *nextImageName = [NSString stringWithFormat:@"%@.png", nextCharName];
    UIImage *nextImg = [UIImage imageNamed:nextImageName];
    nextView.image = nextImg;
    CGSize nextImgSize = nextImg.size;
    CGFloat nextImgYCtr = center.y - (nextImgSize.height / 2);
    CGFloat nextImgX = X1;
    if (!rightToLeft) {
        nextImgX *= -1;
    }    
    nextView.frame = CGRectMake(nextImgX, nextImgYCtr, nextImgSize.width, nextImgSize.height);
    
    CGRect leftBtnFrame;
    CGRect rightBtnFrame;
    CGRect soundBtnFrame;

    // left button origin
    NSString *nextLeftBtnImgName = [nextCharName stringByAppendingFormat:@"Left.png"];
    NSLog(@"left %@", nextLeftBtnImgName);

    UIImage *nextLeftBtnImg = [UIImage imageNamed:nextLeftBtnImgName];
    CGSize nextLeftBtnImgSize = nextLeftBtnImg.size;
    CGFloat nextLeftBtnX = (X1*2);
    if (!rightToLeft) {
        nextLeftBtnX = -(X2+100);
    }    
    nextLeftBtn.frame = CGRectMake(nextLeftBtnX, 20, nextLeftBtnImgSize.width, nextLeftBtnImgSize.height);
    [nextLeftBtn setImage:nextLeftBtnImg forState:UIControlStateNormal];
    nextLeftBtn.alpha = 1.0;
    
    // calculate next left button frame for use within animation
    leftBtnFrame = CGRectMake(20, 20, nextLeftBtnImgSize.width, nextLeftBtnImgSize.height);

    // right button origin
    NSString *nextRightBtnImgName = [nextCharName stringByAppendingFormat:@"Right.png"];
    NSLog(@"right %@", nextRightBtnImgName);

    UIImage *nextRightBtnImg = [UIImage imageNamed:nextRightBtnImgName];
    CGSize nextRightBtnImgSize = nextRightBtnImg.size;
    CGFloat nextRightBtnX = X2;
    if (!rightToLeft) {
        nextRightBtnX = -(X1*2);
    }
    nextRightBtn.frame = CGRectMake(nextRightBtnX, 10, nextRightBtnImgSize.width, nextRightBtnImgSize.height);
    [nextRightBtn setImage:nextRightBtnImg forState:UIControlStateNormal];
    nextRightBtn.alpha = 1.0;
    nextSoundBtn.frame = CGRectMake(nextRightBtnX-38, nextRightBtnImgSize.height-14, 43, 34);
    nextSoundBtn.alpha = 1.0;

    // calculate next right button frame for use within animation
    CGFloat rightBtnX = X1 - 15 - nextRightBtnImgSize.width;
    rightBtnFrame = CGRectMake(rightBtnX, 10, nextRightBtnImgSize.width, nextRightBtnImgSize.height);
    
    // move slightly to left of right button (23 is width of audio icon)
    soundBtnFrame = CGRectMake(rightBtnX-38, nextRightBtnImgSize.height-14, 43, 34);

    seeAllBtn.alpha = 0;

    // START animations
    if (willAnimate) {
        [UIView beginAnimations:@"show" context:nil];
        [UIView setAnimationDuration:0.5];
    }

    // move next trace image to screen
    CGFloat nextImgXCtr = center.x - (nextImgSize.width / 2);
    CGRect nvFrame = CGRectMake(nextImgXCtr, nextImgYCtr, nextImgSize.width, nextImgSize.height);
    nextView.frame = nvFrame;
    
    // move next left button to screen
    nextLeftBtn.frame = leftBtnFrame;
    
    // move next right button to screen
    nextRightBtn.frame = rightBtnFrame;        
    nextSoundBtn.frame = soundBtnFrame;
    
    CGSize currImgSize = currentView.image.size;
    CGSize currLBSize = currentLeftBtn.frame.size;
    CGSize currRBSize = currentRightBtn.frame.size;
    CGFloat currImgYCtr = center.y - (currImgSize.height / 2);
    CGFloat currX = -X1;
    CGFloat currLeftX = -(X1*2);
    CGFloat currRightX = -(X2);
    if (!rightToLeft) {
        currX = X1;
        currLeftX = X2+100;
        currRightX = (X1*2);
    }
    currentView.frame = CGRectMake(currX, currImgYCtr, currImgSize.width, currImgSize.height);
    currentLeftBtn.frame = CGRectMake(currLeftX, 20, currLBSize.width, currLBSize.height);
    currentRightBtn.frame = CGRectMake(currRightX, 10, currRBSize.width, currRBSize.height);
    currentSoundBtn.frame = CGRectMake(currRightX-38, currRBSize.height-14, 43, 34);
    seeAllBtn.alpha = 1;
    
    if (willAnimate) [UIView commitAnimations];
    
    // prepare sound
    NSString *path = [[NSBundle mainBundle] pathForResource:nextCharName ofType:@"wav"];
    NSURL *url = [NSURL fileURLWithPath:path];

    AudioServicesCreateSystemSoundID ((CFURLRef)url, &soundID);
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [charArray release];
    [traceImageView release];
    [traceImageViewB release];
    [leftBtn release];
    [rightBtn release];
    [soundBtn release];
    [leftBtnB release];
    [rightBtnB release];
    [soundBtnB release];
    [paintingView release];
    [tracePopup release];
    [seeAllBtn release];
    [allCharsView release];
    [super dealloc];
}

- (void)closePopup {
    [UIView beginAnimations:@"hidePopup" context:nil];
    [UIView setAnimationDuration:0.3];
    tracePopup.alpha = 0;
    [UIView commitAnimations];
}

- (void)seeAll {
    [UIView beginAnimations:@"showAllCharsPopup" context:nil];
    [UIView setAnimationDuration:0.5];
    allCharsView.alpha = 1;
    [UIView commitAnimations];
}

- (void)closeAllChars {
    [UIView beginAnimations:@"hideAllCharsPopup" context:nil];
    [UIView setAnimationDuration:0.5];
    allCharsView.alpha = 0;
    [UIView commitAnimations];
}

- (void)jumpToChar:(id)sender {
    UIButton *charBtn = (UIButton *)sender;
    self.position = (int) charBtn.tag;
    [self closeAllChars];
    [self displayChar:YES animated:NO];
}

@end
