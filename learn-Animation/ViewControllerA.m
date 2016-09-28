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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",self.foldView);
}




@end
