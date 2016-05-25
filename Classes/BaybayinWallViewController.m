//
//  BaybayinWallViewController.m
//  BaybayinBuhayin
//
//  Created by Paul Michael Laborte on 10/8/10.
//  Copyright AralMuna.Me. All rights reserved.
//

#import "BaybayinWallViewController.h"
#import "FBConnect.h"
#import "PaintingView.h"

#define kUserInfo               1
#define kUploadPhoto			2
#define kPostToWall             3

static NSString* kAppId = @"112145978844639";
static NSString* kWallInfoPopupDisplayed = @"wall_info_popup_displayed";

@implementation BaybayinWallViewController

@synthesize bgImgView;
@synthesize firstBaybayinImgView;
@synthesize paintingView;
@synthesize activityView;
@synthesize yellowBtn;
@synthesize blueBtn;
@synthesize redBtn;
@synthesize facebook;
@synthesize userId;
@synthesize userName;
@synthesize photoId;
@synthesize lastRequestType;
@synthesize shareOptionsView;
@synthesize fbStatusLbl;
@synthesize fbActionLbl;
@synthesize logoutBtn;
@synthesize wallPopup;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    // Define a new brush color
    [self setBlue];
}

- (void)viewWillAppear:(BOOL)animated {
    CGRect updatedFrame = shareOptionsView.frame;
    updatedFrame.origin.y = 320;
    shareOptionsView.frame = updatedFrame;
    [paintingView becomeFirstResponder];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [paintingView resignFirstResponder];
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    BOOL wallPopupDisplayed = [settings boolForKey:kWallInfoPopupDisplayed];
    
    if (!wallPopupDisplayed) {
        // display popup saying home screen instructions
        [UIView beginAnimations:@"showPopup" context:nil];
        [UIView setAnimationDuration:0.3];
        wallPopup.alpha = 1;
        [UIView commitAnimations];
        
        // set tracing popup flag to "displayed"
        [settings setBool:YES forKey:kWallInfoPopupDisplayed];
        [settings synchronize];
    }
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [bgImgView release];
    [firstBaybayinImgView release];
    [activityView release];
    [paintingView release];
    [facebook release];
    [yellowBtn release]; 
    [blueBtn release];    
    [redBtn release];
    [userId release];
    [userName release];
    [photoId release];
    [shareOptionsView release];
    [fbStatusLbl release];
    [fbActionLbl release];
    [logoutBtn release];
    [wallPopup release];
    [super dealloc];
}

- (void)close {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setYellow {
    [paintingView setBrushColorWithRed:241.0f/255.0f green:211.0f/255.0f blue:7.0f/255.0f];
    [UIView beginAnimations:@"updateColors" context:nil];
    [UIView setAnimationDuration:0.3];
    yellowBtn.alpha = 1.0;
    blueBtn.alpha = 0.5;
    redBtn.alpha = 0.5;    
    [UIView commitAnimations];
}

- (void)setBlue {
    [paintingView setBrushColorWithRed:35.0f/255.0f green:183.0f/255.0f blue:238.0f/255.0f];
    [UIView beginAnimations:@"updateColors" context:nil];
    [UIView setAnimationDuration:0.3];
    yellowBtn.alpha = 0.5;
    blueBtn.alpha = 1.0;
    redBtn.alpha = 0.5;    
    [UIView commitAnimations];    
}

- (void)setRed {
    [paintingView setBrushColorWithRed:209.0f/255.0f green:19.0f/255.0f blue:64.0f/255.0f];
    [UIView beginAnimations:@"updateColors" context:nil];
    [UIView setAnimationDuration:0.3];
    yellowBtn.alpha = 0.5;
    blueBtn.alpha = 0.5;
    redBtn.alpha = 1.0;    
    [UIView commitAnimations];    
}

- (void)login {
    NSArray *_permissions =  [NSArray arrayWithObjects:@"read_stream", @"publish_stream",nil];
    Facebook *tempFB = [[Facebook alloc] init];
    self.facebook = tempFB;
    [facebook authorize:kAppId permissions:_permissions delegate:self];
    [tempFB release];    
}

- (void)post {
    [activityView startAnimating];    
    [self dismissFBOptions];
    if ([facebook isSessionValid]) {
        [self postImg];
    } else {
        [self login];
    }
}

- (UIImage *)getImageToPost {
    // get drawing image
    UIImage *drawing = [paintingView saveImageFromGLView];
    
    // change black background to transparent
    // Taken from: http://stackoverflow.com/questions/633722/how-to-make-one-color-transparent-on-a-uiimage/3175328#3175328
    const float colorMasking[6] = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0};
    CGImageRef maskRef = drawing.CGImage;
    CGImageRef mask = CGImageCreateWithMaskingColors(maskRef, colorMasking);
    UIImage *maskedDrawing = [UIImage imageWithCGImage:mask];
    
    // merge drawing and banig BG
    UIImage *merged = [self addImage:bgImgView.image toImage:maskedDrawing];
    // merge My First Baybayin text
    CGRect frame1 = CGRectMake(0, 0, merged.size.width, merged.size.height);
    CGRect frame2 = CGRectMake(20, 20, firstBaybayinImgView.image.size.width, firstBaybayinImgView.image.size.height);
    UIImage *merged2 = [self addImage:merged withFrame:frame1 toImage:firstBaybayinImgView.image withFrame:frame2];
    
    CGImageRelease(mask);
    CGImageRelease(maskRef);

    return merged2;
}

- (void)saveToCameraRoll {
    [activityView startAnimating];    
    [self dismissFBOptions];
    UIImage *merged = [self getImageToPost];
    UIImageWriteToSavedPhotosAlbum(merged, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    // Was there an error?
    if (error != NULL)
    {
        // Show error message...
        
    }
    else  // No errors
    {
        // Show message image successfully saved
    }
    [activityView stopAnimating];
    [paintingView erase];    
}

- (void)showFBOptions {
    if ([activityView isAnimating]) return;
    [self displayOptionsView];
}

- (void)displayOptionsView {
    CGRect updatedFrame = shareOptionsView.frame;
    updatedFrame.origin.y = 84;
    
    if ([facebook isSessionValid]) {
        [self updateFBLabels:YES];
    } else {
        [self updateFBLabels:NO];
    }
    
    [UIView beginAnimations:@"displayOptionsView" context:nil];
    [UIView setAnimationDuration:0.3];    
    shareOptionsView.frame = updatedFrame;
    [UIView commitAnimations];
}

- (void)dismissFBOptions {
    CGRect updatedFrame = shareOptionsView.frame;
    updatedFrame.origin.y = 320;

    [UIView beginAnimations:@"hideOptionsView" context:nil];
    [UIView setAnimationDuration:0.3];    
    shareOptionsView.frame = updatedFrame;
    [UIView commitAnimations];    
}

- (void)logout {
    [self dismissFBOptions];
    [facebook logout:self];
}

- (void)postImg {
    self.lastRequestType = kUploadPhoto;
    [activityView startAnimating];

    UIImage *merged = [self getImageToPost];
    
    // setup FB post photo params
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    kAppId, @"api_key", merged, @"picture", nil];
    NSString *path = [NSString stringWithFormat:@"%@", @"photos"];
	[facebook requestWithGraphPath:path andParams:params andHttpMethod:@"POST" andDelegate:self];
}

- (UIImage *)addImage:(UIImage *)image1 withFrame:(CGRect)frame1 toImage:(UIImage *)image2 withFrame:(CGRect)frame2 {
	UIGraphicsBeginImageContext(image1.size);
	// Draw image1
	[image1 drawInRect:frame1];
	// Draw image2
	[image2 drawInRect:frame2];
	UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return resultingImage;
}

- (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 {
    CGRect frame1 = CGRectMake(0, 0, image1.size.width, image1.size.height);
    CGRect frame2 = CGRectMake(0, 0, image2.size.width, image2.size.height);
    return [self addImage:image1 withFrame:frame1 toImage:image2 withFrame:frame2];
}

/**
 * Callback for facebook login
 */ 
- (void)fbDidLogin {
    self.lastRequestType = kUserInfo;
    NSString *path = [NSString stringWithFormat:@"%@", @"me"];
    [facebook requestWithGraphPath:path andDelegate:self];
}

/**
 * Callback for facebook did not login
 */
- (void)fbDidNotLogin:(BOOL)cancelled {
    [activityView stopAnimating];
}

/**
 * Callback for facebook logout
 */ 
- (void)fbDidLogout {
    [self updateFBLabels:NO];
}

- (void)updateFBLabels:(BOOL)loggedIn {
    if (loggedIn) {
        fbStatusLbl.text = [NSString stringWithFormat:@"You are logged in as %@", self.userName];
        fbActionLbl.text = @"Post to Wall";
        logoutBtn.hidden = NO;
    } else {
        fbStatusLbl.text = @"You are not logged in";
        fbActionLbl.text = @"Login to FB and Post to Wall";
        logoutBtn.hidden = YES;
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
// FBRequestDelegate

/**
 * Callback when a request receives Response
 */ 
- (void)request:(FBRequest*)request didReceiveResponse:(NSURLResponse*)response{
    NSLog(@"received response");
};

/**
 * Called when an error prevents the request from completing successfully.
 */
- (void)request:(FBRequest*)request didFailWithError:(NSError*)error{
//    NSString *desc = [error localizedDescription];
//    NSString *failure = [error localizedFailureReason];
};

/**
 * Called when a request returns and its response has been parsed into an object.
 * The resulting object may be a dictionary, an array, a string, or a number, depending
 * on thee format of the API response.
 */
- (void)request:(FBRequest*)request didLoad:(id)result {
	NSDictionary *dictionaryResult;
	NSArray *arrayResult;
	NSString *stringResult;
	NSNumber *numResult;
    if ([result isKindOfClass:[NSArray class]]) {
        arrayResult = (NSArray *) result;
        result = [result objectAtIndex:0]; 
    } else if ([result isKindOfClass:[NSDictionary class]]) {
        dictionaryResult = (NSDictionary *) result;
    } else if ([result isKindOfClass:[NSString class]]) {
        stringResult = (NSString *) result;
    } else if ([result isKindOfClass:[NSNumber class]]) {
        numResult = (NSNumber *) result;
    }
    switch (lastRequestType) {
        case kUserInfo:
//            self.userId = [[dictionaryResult valueForKey:@"id"] integerValue];
            self.userId = [dictionaryResult valueForKey:@"id"];
            self.userName = [dictionaryResult valueForKey:@"name"];
            [self postImg];
            break;
        case kUploadPhoto:
            self.photoId = [dictionaryResult valueForKey:@"id"];
            [activityView stopAnimating];
            [paintingView erase];
            break;
        default:
            break;
    }
};

///////////////////////////////////////////////////////////////////////////////////////////////////
// FBDialogDelegate

/** 
 * Called when a UIServer Dialog successfully return
 */
- (void)dialogDidComplete:(FBDialog*)dialog{
}

- (void)closePopup {
    [UIView beginAnimations:@"hidePopup" context:nil];
    [UIView setAnimationDuration:0.3];
    wallPopup.alpha = 0;
    [UIView commitAnimations];
}


@end
