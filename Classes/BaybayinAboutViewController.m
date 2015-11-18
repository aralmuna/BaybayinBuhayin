//
//  BaybayinAboutViewController.m
//  BaybayinBuhayin
//
//  Created by Paul Michael Laborte on 11/26/10.
//  Copyright 2010 Kudlit. All rights reserved.
//

#import "BaybayinAboutViewController.h"


@implementation BaybayinAboutViewController

@synthesize aboutImgView;
@synthesize scrollView;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [self displayAbout];
    [super viewDidLoad];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [aboutImgView release];
    [scrollView release];
    [super dealloc];
}

- (void)displayAbout {
    if (!self.scrollView) {
        
        // setup new view
        UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AboutTwoTone.png"]];
        self.aboutImgView = tempImageView;
        
        UIScrollView *tempScrollView = nil;
        tempScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(70, 0, 389, 318)];
        self.scrollView = tempScrollView;
        
        self.scrollView.minimumZoomScale = 0.99;
        self.scrollView.maximumZoomScale = 1.5;
        scrollView.delegate = self;
        [scrollView addSubview:aboutImgView];
        scrollView.zoomScale = 0.99;
        
        [tempImageView release];
        [tempScrollView release];
    }
    
    [self.view addSubview:self.scrollView];
}

- (void)close {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return aboutImgView;
}


@end
