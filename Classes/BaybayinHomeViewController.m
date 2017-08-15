//
//  BaybayinViewController.m
//  Baybayin
//
//  Created by Paul Michael Laborte on 9/30/10.
//  Copyright AralMuna.Me. All rights reserved.
//

#import "BaybayinHomeViewController.h"
#import "Baybayin101ViewController.h"
#import "BaybayinSlideViewController.h"
#import "BaybayinWallViewController.h"
#import "BaybayinAboutViewController.h"

static NSString* kResetInfoPopups = @"reset_info_popups";
static NSString* kHomeInfoPopupDisplayed = @"home_info_popup_displayed";
static NSString* kTracingInfoPopupDisplayed = @"tracing_info_popup_displayed";
static NSString* kWallInfoPopupDisplayed = @"wall_info_popup_displayed";

@implementation BaybayinHomeViewController

@synthesize bgImgView;
@synthesize toggleComplete;
@synthesize menuDisplayed;
@synthesize bambooBtn;
@synthesize bambooTopImg;
@synthesize headerImg;
@synthesize footerImg;
@synthesize btnA;
@synthesize btnB;
@synthesize btnK;
@synthesize btnD;
@synthesize menuA;
@synthesize menuB;
@synthesize menuK;
@synthesize menuD;
@synthesize btnZeroFrame;
@synthesize imgA;
@synthesize imgB;
@synthesize imgK;
@synthesize imgD;
@synthesize imgZeroFrame;
@synthesize origFrameBtnA;
@synthesize origFrameBtnB;
@synthesize origFrameBtnK;
@synthesize origFrameBtnD;
@synthesize origFrameImgA;
@synthesize origFrameImgB;
@synthesize origFrameImgK;
@synthesize origFrameImgD;
@synthesize homePopup;

// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
        self.imgZeroFrame = CGRectMake(80, 110, 0, 0);
        self.btnZeroFrame = CGRectMake(70, 150, 0, 0);
        self.menuDisplayed = NO;
//        UITapGestureRecognizer * r = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeBackground:)];
//        [r setNumberOfTouchesRequired:2];
//        [self.view addGestureRecognizer:r];
//        [r release];
    }
    return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    [self saveInitFrames];
    [self hideMenus];
    self.toggleComplete = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.view becomeFirstResponder];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.view resignFirstResponder];
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    // if user reset the popup settings, set all flags to displayed = false.
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    BOOL resetPopups = [settings boolForKey:kResetInfoPopups];
    if (resetPopups) {
        [settings setBool:NO forKey:kResetInfoPopups];
        [settings setBool:NO forKey:kHomeInfoPopupDisplayed];
        [settings setBool:NO forKey:kTracingInfoPopupDisplayed];
        [settings setBool:NO forKey:kWallInfoPopupDisplayed];
        [settings synchronize];
    }
    
    BOOL homePopupDisplayed = [settings boolForKey:kHomeInfoPopupDisplayed];
    if (!homePopupDisplayed) {
        // display popup saying home screen instructions
        [UIView beginAnimations:@"showPopup" context:nil];
        [UIView setAnimationDuration:0.3];
        homePopup.alpha = 1;
        [UIView commitAnimations];
        
        // set home popup flag to "displayed"
        [settings setBool:YES forKey:kHomeInfoPopupDisplayed];
        [settings synchronize];
    }
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

- (void)saveInitFrames {
    // save starting frames
    self.origFrameImgA = imgA.frame;
    self.origFrameImgB = imgB.frame;
    self.origFrameImgK = imgK.frame;
    self.origFrameImgD = imgD.frame;
    self.origFrameBtnA = btnA.frame;
    self.origFrameBtnB = btnB.frame;
    self.origFrameBtnK = btnK.frame;
    self.origFrameBtnD = btnD.frame;
}

- (void)hideMenus {
    // perform animations here
    btnA.alpha = 0;
    CGRect updatedFrame = btnA.frame;
    updatedFrame.origin.x = btnZeroFrame.origin.x;
    updatedFrame.origin.y = btnZeroFrame.origin.y;
    btnA.frame = updatedFrame;
    btnB.alpha = 0;
    updatedFrame = btnB.frame;
    updatedFrame.origin.x = btnZeroFrame.origin.x;
    updatedFrame.origin.y = btnZeroFrame.origin.y;
    btnB.frame = updatedFrame;
    btnK.alpha = 0;
    updatedFrame = btnK.frame;
    updatedFrame.origin.x = btnZeroFrame.origin.x;
    updatedFrame.origin.y = btnZeroFrame.origin.y;
    btnK.frame = updatedFrame;
    btnD.alpha = 0;
    updatedFrame = btnD.frame;
    updatedFrame.origin.x = btnZeroFrame.origin.x;
    updatedFrame.origin.y = btnZeroFrame.origin.y;
    btnD.frame = updatedFrame;
    imgA.frame = imgZeroFrame;
    imgB.frame = imgZeroFrame;
    imgK.frame = imgZeroFrame;
    imgD.frame = imgZeroFrame;
}

- (void) showMenus {
    // TODO cleanup
    imgA.hidden = NO;
    imgB.hidden = NO;
    imgK.hidden = NO;
    imgD.hidden = NO;
    btnA.hidden = NO;
    btnB.hidden = NO;
    btnK.hidden = NO;
    btnD.hidden = NO;
    
    // perform animations here
    imgA.frame = origFrameImgA;
    imgB.frame = origFrameImgB;
    imgK.frame = origFrameImgK;
    imgD.frame = origFrameImgD;
    btnA.alpha = 1.0;
    btnB.alpha = 1.0;
    btnK.alpha = 1.0;
    btnD.alpha = 1.0;
    btnA.frame = origFrameBtnA;
    btnB.frame = origFrameBtnB;
    btnK.frame = origFrameBtnK;
    btnD.frame = origFrameBtnD;
}

- (void)toggleMenu {
    if (!self.toggleComplete) return;
    self.toggleComplete = NO;
    
    if (!menuDisplayed) {
        
        [UIView beginAnimations:@"setupMenu" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(setupMenuComplete)];
        [UIView setAnimationDuration:0.5];
        
        // move header to right
        // move bamboo and footer to left
        CGRect updatedFrame = bambooBtn.frame;
        updatedFrame.origin.x = -90;
        bambooBtn.frame = updatedFrame;
        
        updatedFrame = footerImg.frame;
        updatedFrame.origin.x = -136;
        footerImg.frame = updatedFrame;
        
        updatedFrame = headerImg.frame;
        updatedFrame.origin.x = 645;
        headerImg.frame = updatedFrame;
        
        [UIView commitAnimations];

    } else {

        [self displayMenuLabels:NO];

        [UIView beginAnimations:@"hideOptions" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(optionsHidden)];
        [UIView setAnimationDuration:0.5];
        [self hideMenus];
        [UIView commitAnimations];

    }
}

- (void)setupMenuComplete {
    headerImg.hidden = YES;
    bambooTopImg.hidden = NO;
    [UIView beginAnimations:@"displayOptions" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(optionsDisplayed)];        
    [UIView setAnimationDuration:0.5];
    [self showMenus];
    [UIView commitAnimations];
}

- (void)optionsDisplayed {
    self.menuDisplayed = YES;
    self.toggleComplete = YES;
    [self displayMenuLabels:YES];
}

- (void)displayMenuLabels:(BOOL)showLabelAsButton {
    self.imgA.hidden = showLabelAsButton;
    self.imgB.hidden = showLabelAsButton;
    self.imgK.hidden = showLabelAsButton;
    self.imgD.hidden = showLabelAsButton;
    self.menuA.hidden = !showLabelAsButton;
    self.menuB.hidden = !showLabelAsButton;
    self.menuK.hidden = !showLabelAsButton;
    self.menuD.hidden = !showLabelAsButton;
}

- (void)optionsHidden {
    headerImg.hidden = NO;
    bambooTopImg.hidden = YES;    
    [UIView beginAnimations:@"revertMenu" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(revertMenuComplete)];
    [UIView setAnimationDuration:0.5];
    
    // move header to right
    // move bamboo and footer to left
    CGRect updatedFrame = bambooBtn.frame;
    updatedFrame.origin.x = 64;
    bambooBtn.frame = updatedFrame;
    
    updatedFrame = footerImg.frame;
    updatedFrame.origin.x = 18;
    footerImg.frame = updatedFrame;
    
    updatedFrame = headerImg.frame;
    updatedFrame.origin.x = 494;
    headerImg.frame = updatedFrame;
    
    [UIView commitAnimations];
}

- (void)revertMenuComplete {
    self.menuDisplayed = NO;
    self.toggleComplete = YES;
}

- (void)baybayinIntro {
    Baybayin101ViewController *temp = [[Baybayin101ViewController alloc] initWithNibName:@"Baybayin101ViewController" bundle:nil];
    [self.navigationController pushViewController:temp animated:YES];
    [temp release];
}

- (void)seeWebsites {
    BaybayinAboutViewController *temp = [[BaybayinAboutViewController alloc] initWithNibName:@"BaybayinAboutViewController" bundle:nil];
    [self.navigationController pushViewController:temp animated:YES];
    [temp release];
}
    
- (void)tracing {
    BaybayinSlideViewController *temp = [[BaybayinSlideViewController alloc] initWithNibName:@"BaybayinSlideViewController" bundle:nil];
    [self.navigationController pushViewController:temp animated:YES];
    [temp release];
}

- (void)myBaybayin {
    BaybayinWallViewController *temp = [[BaybayinWallViewController alloc] initWithNibName:@"BaybayinWallViewController" bundle:nil];
    [self.navigationController pushViewController:temp animated:YES];
    [temp release];
}

- (void)closePopup {
    [UIView beginAnimations:@"hidePopup" context:nil];
    [UIView setAnimationDuration:0.3];
    homePopup.alpha = 0;
    [UIView commitAnimations];
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
    [bambooBtn release];
    [bambooTopImg release];
    [footerImg release];
    [headerImg release];
    [bgImgView release];
    [btnA release];
    [btnB release];
    [btnK release];
    [btnD release];
    [menuA release];
    [menuB release];
    [menuK release];
    [menuD release];
    [imgA release];
    [imgB release];
    [imgK release];
    [imgD release];
    [homePopup release];
    [super dealloc];
}

- (void)respondToShake {
    [self toggleMenu];
}

@end
