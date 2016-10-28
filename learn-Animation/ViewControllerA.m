//
//  ViewControllerA.m
//  learn-Animation
//
//  Created by oahgnehzoul on 16/9/27.
//  Copyright © 2016年 llzzzhh. All rights reserved.
//

#import "ViewControllerA.h"
#import "POP.h"

@interface ViewControllerA ()
@property (weak, nonatomic) IBOutlet UIView *foldView;

@end

@implementation ViewControllerA

- (void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"awakeFromNib:%@",self.view);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"viewDidLoad:%@",self.foldView);
}

//- (void)viewDidLayoutSubviews {
//    NSLog(@"%@",self.view);
//
//    [super viewDidLayoutSubviews];
//    [self.foldView layoutIfNeeded];
//    NSLog(@"%@",self.view);
//    NSLog(@"%@",self.foldView);
//}


@end
