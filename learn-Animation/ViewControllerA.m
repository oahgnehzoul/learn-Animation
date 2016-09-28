//
//  ViewControllerA.m
//  learn-Animation
//
//  Created by oahgnehzoul on 16/9/27.
//  Copyright © 2016年 llzzzhh. All rights reserved.
//

#import "ViewControllerA.h"
#import "POP.h"

//typedef NS_ENUM(NSInteger,NSImagePosition) {
//    NSImagePositionTop,
//    NSImagePositionBottom
//};
//
//@interface PageView : UIView
//
//@property (nonatomic, strong) UIImageView *topView;
//@property (nonatomic, strong) UIImageView *bottomView;
//@property (nonatomic, strong) CAGradientLayer *topShadowLayer;
//@property (nonatomic, strong) CAGradientLayer *bottomShadowLayer;
//@property (nonatomic, assign) NSUInteger initialLocation;
//
//@end
//
//@implementation PageView
//
//- (void)awakeFromNib {
//    [super awakeFromNib];
//    [self addTopView];
//    [self addBottomView];
//    [self addGesture];
//}
//
//- (void)addTopView {
//    self.topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
//    self.topView.layer.anchorPoint = CGPointMake(0.5, 1.0);
//    self.topView.layer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
//    CATransform3D transform3D = CATransform3DIdentity;
//    transform3D.m34 = -1 / 1000.f;
//    self.topView.layer.transform = transform3D;
//    self.topView.contentMode = UIViewContentModeScaleAspectFill;
//    self.topView.image = [self getImageWithImage:[UIImage imageNamed:@"avatar"] Position:NSImagePositionTop];
//    
//    self.topShadowLayer = [CAGradientLayer layer];
//    self.topShadowLayer.frame = self.topView.bounds;
//    self.topShadowLayer.colors = @[(id)[UIColor clearColor].CGColor,(id)[UIColor blackColor].CGColor];
//    self.topShadowLayer.opacity = 0.f;
//    [self.topView.layer addSublayer:self.topShadowLayer];
//    [self addSubview:self.topView];
//}
//
//- (void)addBottomView {
//    self.bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMidY(self.bounds), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) / 2.f)];
//    self.bottomView.layer.anchorPoint = CGPointMake(0.5, 0);
//    self.bottomView.layer.position = CGPointMake(CGRectGetMaxX(self.bounds), CGRectGetMidY(self.bounds));
//    CATransform3D transform3D = CATransform3DIdentity;
//    transform3D.m34 = -1 / 1000.f;
//    self.bottomView.layer.transform = transform3D;
//    self.bottomView.contentMode = UIViewContentModeScaleAspectFill;
//    self.bottomView.image = [self getImageWithImage:[UIImage imageNamed:@"avatar"] Position:NSImagePositionBottom];
//    
//    self.bottomShadowLayer = [CAGradientLayer layer];
//    self.bottomShadowLayer.frame = self.bottomView.bounds;
//    self.bottomShadowLayer.colors = @[(id)[UIColor blackColor].CGColor,(id)[UIColor clearColor].CGColor];
//    self.bottomShadowLayer.opacity = 0.f;
//    [self.bottomView.layer addSublayer:self.bottomShadowLayer];
//    [self addSubview:self.bottomView];
//}
//
//// 图片切割
//- (UIImage *)getImageWithImage:(UIImage *)image Position:(NSImagePosition)position {
//    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height / 2.f);
//    if (position == NSImagePositionBottom) {
//        rect.origin.y = image.size.height / 2.f;
//    } else {
//        rect.origin.y = 0;
//    }
//    CGImageRef ref = CGImageCreateWithImageInRect(image.CGImage, rect);
//    UIImage *ret = [UIImage imageWithCGImage:ref];
//    CGImageRelease(ref);
//    return ret;
//}
//
//- (void)addGesture {
//    UIPanGestureRecognizer *topPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panTop:)];
////    UITapGestureRecognizer *topPoke = [UITapGestureRecognizer alloc] initWithTarget:self action:@selector(<#selector#>)
//    [self.topView addGestureRecognizer:topPan];
//    UIPanGestureRecognizer *bottomPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panBottom:)];
//    [self.bottomView addGestureRecognizer:bottomPan];
//}
//
//- (void)panTop:(UIPanGestureRecognizer *)recognizer {
//    CGPoint location = [recognizer locationInView:self];
//    if (recognizer.state == UIGestureRecognizerStateBegan) {
//        self.initialLocation = location.y;
//        [self bringSubviewToFront:self.topView];
//    }
//    
//    if ([[self.topView.layer valueForKeyPath:@"transform.rotation.x"] floatValue] < -M_PI_2) {
//        [CATransaction begin];
//        [CATransaction setValue:((id)kCFBooleanTrue) forKey:kCATransactionDisableActions];
//        self.topShadowLayer.opacity = 0.f;
//        self.bottomShadowLayer.opacity = (location.y - self.initialLocation) / (CGRectGetHeight(self.bounds) - self.initialLocation);
//        [CATransaction commit];
//    } else {
//        [CATransaction begin];
//        [CATransaction setValue:((id)kCFBooleanTrue) forKey:kCATransactionDisableActions];
//        CGFloat opacity = (location.y - self.initialLocation) / (CGRectGetHeight(self.bounds) - self.initialLocation);
//        self.topShadowLayer.opacity = opacity;
//        self.bottomShadowLayer.opacity = opacity;
//        [CATransaction commit];
//    }
//}
//- (void)panBottom:(UIPanGestureRecognizer *)recognizer {
//    CGPoint location = [recognizer locationInView:self];
//    if (recognizer.state == UIGestureRecognizerStateBegan) {
//        self.initialLocation = location.y;
//        [self bringSubviewToFront:self.topView];
//    }
//    
//    if ([[self.topView.layer valueForKeyPath:@"transform.rotation.x"] floatValue] < M_PI_2) {
//        [CATransaction begin];
//        [CATransaction setValue:((id)kCFBooleanTrue) forKey:kCATransactionDisableActions];
//        self.topShadowLayer.opacity = 0.f;
//        CGFloat opacity = (self.initialLocation - location.y) / self.initialLocation;
//        self.bottomShadowLayer.opacity = opacity;
//        self.bottomShadowLayer.opacity = opacity;
//        [CATransaction commit];
//    } else {
//        [CATransaction begin];
//        [CATransaction setValue:((id)kCFBooleanTrue) forKey:kCATransactionDisableActions];
//        CGFloat opacity = (location.y - self.initialLocation) / (CGRectGetHeight(self.bounds) - self.initialLocation);
//        self.topShadowLayer.opacity = opacity;
//        self.bottomShadowLayer.opacity = opacity;
//        [CATransaction commit];
//    }
//}
//
//
//
//@end


@interface ViewControllerA ()
@property (weak, nonatomic) IBOutlet UIView *foldView;

@end

@implementation ViewControllerA

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",self.foldView);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
