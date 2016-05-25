//
//  Baybayin101ViewController.h
//  BaybayinBuhayin
//
//  Created by Paul Michael Laborte on 10/7/10.
//  Copyright AralMuna.Me. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Baybayin101ViewController : UIViewController<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UIImageView *bgImgView;
    IBOutlet UIImageView *baybayin101ImgView;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UITableView *tableView;
    IBOutlet UIButton *b101Btn;
    IBOutlet UIButton *sitesBtn;
    NSArray *links;
    NSArray *images;
    NSArray *titles;
}

@property(retain,nonatomic) UIImageView *bgImgView;
@property(retain,nonatomic) UIImageView *baybayin101ImgView;
@property(retain,nonatomic) UIScrollView *scrollView;
@property(retain,nonatomic) UITableView *tableView;
@property(retain,nonatomic) NSArray *links;
@property(retain,nonatomic) NSArray *images;
@property(retain,nonatomic) NSArray *titles;
@property(retain,nonatomic) UIButton *b101Btn;
@property(retain,nonatomic) UIButton *sitesBtn;

- (IBAction)close;
- (IBAction)display101;
- (IBAction)displayLinks;

@end
