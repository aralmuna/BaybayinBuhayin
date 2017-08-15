//
//  Baybayin101ViewController.m
//  BaybayinBuhayin
//
//  Created by Paul Michael Laborte on 10/7/10.
//  Copyright 2010 AralMuna.Me. All rights reserved.
//

#import "Baybayin101ViewController.h"


@implementation Baybayin101ViewController

@synthesize bgImgView;
@synthesize baybayin101ImgView;
@synthesize scrollView;
@synthesize tableView;
@synthesize links;
@synthesize images;
@synthesize titles;
@synthesize b101Btn;
@synthesize sitesBtn;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
        NSArray *tempTitles = [NSArray arrayWithObjects:@"Baybayin", @"Ating Baybayin", @"Baybayin Buhayin", nil];
        self.titles = tempTitles;

        NSArray *tempLinks = [NSArray arrayWithObjects:@"http://www.baybayin.com", 
                              @"http://www.eaglescorner.com/baybayin/", @"https://www.facebook.com/baybayinbuhayin/", nil];
        self.links = tempLinks;

        NSArray *tempImages = [NSArray arrayWithObjects:@"Site2Thumb.png", @"Site3Thumb.png", @"Site5Thumb.png", nil];
        self.images = tempImages;      
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
//    self.b101Btn.titleLabel.text = @"";
//    self.sitesBtn.titleLabel.text = @"";
    [self display101];
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
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)close {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    [bgImgView release];
    [baybayin101ImgView release];
    [scrollView release];
    [tableView release];
    [links release];
    [images release];
    [titles release];
    [b101Btn release];
    [sitesBtn release];
    [super dealloc];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return baybayin101ImgView;
}

- (void)display101 {
    // clear previous
    [self.tableView removeFromSuperview];
    self.sitesBtn.selected = NO;
    self.b101Btn.selected = YES;
    
    if (!self.scrollView) {

        // setup new view
        UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Baybayin101Content.png"]];
        self.baybayin101ImgView = tempImageView;
        
        UIScrollView *tempScrollView = nil;
        tempScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(97, 0, 460, 318)];
        self.scrollView = tempScrollView;

        self.scrollView.minimumZoomScale = 0.6;
        self.scrollView.maximumZoomScale = 1.0;        
        scrollView.delegate = self;
        [scrollView addSubview:baybayin101ImgView];
        scrollView.zoomScale = 0.60;
        
        [tempImageView release];
        [tempScrollView release];
    }

    [self.view addSubview:self.scrollView];
}

- (void)displayLinks {
    // clear previous view
    [self.scrollView removeFromSuperview];
    self.b101Btn.selected = NO;
    self.sitesBtn.selected = YES;

    if (!self.tableView) {
        // setup new view
        UITableView *tempTableView = [[UITableView alloc] initWithFrame:CGRectMake(97, 0, 460, 318) style:UITableViewStylePlain];
        tempTableView.backgroundColor = [UIColor clearColor];
        tempTableView.dataSource = self;
        tempTableView.delegate = self;
        tempTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView = tempTableView;
        [tempTableView release];
    }

    [self.view addSubview:self.tableView];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableViewArg cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableViewArg dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.backgroundView = [[[UIImageView alloc] init] autorelease];
		cell.selectedBackgroundView = [[[UIImageView alloc] init] autorelease];
    }
    
    UIImage *rowBackground = [UIImage imageNamed:@"SitesCellBG.png"];
    UIImage *selectionBackground = [UIImage imageNamed:@"SitesCellBG.png"];
    ((UIImageView *)cell.backgroundView).image = rowBackground;
    ((UIImageView *)cell.selectedBackgroundView).image = selectionBackground;
    
    // Configure the cell...
    NSString *title = [titles objectAtIndex:indexPath.row];
    NSString *imageName = [images objectAtIndex:indexPath.row];
    NSString *url = [links objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:imageName];
//    cell.textLabel.textColor = [UIColor colorWithRed:186.0f/255.0f green:137.0f/255.0f blue:67.0f/255.0f alpha:1.0f];
    cell.textLabel.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    cell.textLabel.font = [UIFont fontWithName:@"ArialMT" size:16];
//    cell.textLabel.shadowColor = [UIColor blackColor];
    cell.textLabel.text = title;
    cell.detailTextLabel.text = url;
    UIImageView *arrowImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SiteArrow.png"]];
    cell.accessoryView = arrowImgView;
    [arrowImgView release];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 113;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *url = [links objectAtIndex:indexPath.row];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: url]];
}


@end
