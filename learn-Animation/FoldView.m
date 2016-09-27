//
//  FoldView.m
//  learn-Animation
//
//  Created by oahgnehzoul on 16/9/28.
//  Copyright © 2016年 llzzzhh. All rights reserved.
//

#import "FoldView.h"
#import "POP.h"

typedef NS_ENUM(NSInteger,NSImagePosition) {
    NSImagePositionTop,
    NSImagePositionBottom
};

@interface FoldView ()
@property (nonatomic, strong) UIImageView *topView;
@property (nonatomic, strong) UIImageView *bottomView;
@property (nonatomic, strong) CAGradientLayer *topShadowLayer;
@property (nonatomic, strong) CAGradientLayer *bottomShadowLayer;
@property (nonatomic, assign) CGFloat initialLocation;
@property (nonatomic, strong) UIImage *image;

@end

@implementation FoldView

- (void)awakeFromNib {
    [super awakeFromNib];

    [self addTopView];
    [self addBottomView];
    [self addGesture];
}

- (void)addTopView {
    self.topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) / 2.f)];
    self.topView.layer.anchorPoint = CGPointMake(0.5, 1.0);
    self.topView.layer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CATransform3D transform3D = CATransform3DIdentity;
    transform3D.m34 = -1 / 1000.f;
    self.topView.layer.transform = transform3D;
    self.topView.userInteractionEnabled = YES;
    self.topView.contentMode = UIViewContentModeScaleAspectFill;
    self.topView.image = [self getImageWithImage:[UIImage imageNamed:@"avatar.jpg"] Position:NSImagePositionTop];
    
    self.topShadowLayer = [CAGradientLayer layer];
    self.topShadowLayer.frame = self.topView.bounds;
    self.topShadowLayer.colors = @[(id)[UIColor clearColor].CGColor,(id)[UIColor blackColor].CGColor];
    self.topShadowLayer.opacity = 0.f;
    [self.topView.layer addSublayer:self.topShadowLayer];
    [self addSubview:self.topView];
}

- (void)addBottomView {
    self.bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMidY(self.bounds), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) / 2.f)];
    self.bottomView.layer.anchorPoint = CGPointMake(0.5, 0);
    self.bottomView.layer.position = CGPointMake(CGRectGetMaxX(self.bounds) / 2.f, CGRectGetMidY(self.bounds));
    CATransform3D transform3D = CATransform3DIdentity;
    transform3D.m34 = -1 / 1000.f;
    self.bottomView.layer.transform = transform3D;
    self.bottomView.userInteractionEnabled = YES;
    self.bottomView.contentMode = UIViewContentModeScaleAspectFill;
    self.bottomView.image = [self getImageWithImage:[UIImage imageNamed:@"avatar.jpg"] Position:NSImagePositionBottom];
    
    self.bottomShadowLayer = [CAGradientLayer layer];
    self.bottomShadowLayer.frame = self.bottomView.bounds;
    self.bottomShadowLayer.colors = @[(id)[UIColor blackColor].CGColor,(id)[UIColor clearColor].CGColor];
    self.bottomShadowLayer.opacity = 0.f;
    [self.bottomView.layer addSublayer:self.bottomShadowLayer];
    [self addSubview:self.bottomView];
}

// 图片切割
- (UIImage *)getImageWithImage:(UIImage *)image Position:(NSImagePosition)position {
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height / 2.f);
    if (position == NSImagePositionBottom) {
        rect.origin.y = image.size.height / 2.f;
    }
    CGImageRef ref = CGImageCreateWithImageInRect(image.CGImage, rect);
    UIImage *ret = [UIImage imageWithCGImage:ref];
    CGImageRelease(ref);
    return ret;
}

- (void)addGesture {
    UIPanGestureRecognizer *topPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panTop:)];
    //    UITapGestureRecognizer *topPoke = [UITapGestureRecognizer alloc] initWithTarget:self action:@selector(<#selector#>)
    [self.topView addGestureRecognizer:topPan];
    UIPanGestureRecognizer *bottomPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panBottom:)];
    [self.bottomView addGestureRecognizer:bottomPan];
}

- (void)panTop:(UIPanGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:self];
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.initialLocation = location.y;
        [self bringSubviewToFront:self.topView];
    }
    
    if ([[self.topView.layer valueForKeyPath:@"transform.rotation.x"] floatValue] < -M_PI_2) {
        [CATransaction begin];
        [CATransaction setValue:((id)kCFBooleanTrue) forKey:kCATransactionDisableActions];
        self.topShadowLayer.opacity = 0.f;
        self.bottomShadowLayer.opacity = (location.y - self.initialLocation) / (CGRectGetHeight(self.bounds) - self.initialLocation);
        [CATransaction commit];
    } else {
        [CATransaction begin];
        [CATransaction setValue:((id)kCFBooleanTrue) forKey:kCATransactionDisableActions];
        CGFloat opacity = (location.y - self.initialLocation) / (CGRectGetHeight(self.bounds) - self.initialLocation);
        self.topShadowLayer.opacity = opacity;
        self.bottomShadowLayer.opacity = opacity;
        [CATransaction commit];
    }
    
    
    //如果手指在PageView里面,开始使用POPAnimation
    if([self isLocation:location InView:self]){
        //把一个PI平均分成可以下滑的最大距离份
        CGFloat percent = -M_PI / (CGRectGetHeight(self.bounds) - self.initialLocation);
        
        //POPAnimation的使用
        //创建一个Animation,设置为绕着X轴旋转。还记得我们上面设置的锚点吗？设置为（0.5，0.5）。这时什么意思呢？当我们设置kPOPLayerRotationX（绕X轴旋转），那么x就起作用了，绕x所在轴；kPOPLayerRotationY，y就起作用了，绕y所在轴。
        POPBasicAnimation *rotationAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotationX];
        
        //给这个animation设值。这个值根据手的滑动而变化，所以值会不断改变。又因为这个方法会实时调用，所以变化的值会实时显示在屏幕上。
        rotationAnimation.duration = 0.01;//默认的duration是0.4
        rotationAnimation.toValue =@((location.y-self.initialLocation)*percent);
        
        //把这个animation加到topView的layer,key只是个识别符。
        [self.topView.layer pop_addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        
        //当松手的时候，自动复原
        if (recognizer.state == UIGestureRecognizerStateEnded ||
            recognizer.state == UIGestureRecognizerStateCancelled) {
            POPSpringAnimation *recoverAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotationX];
            recoverAnimation.springBounciness = 18.0f; //弹簧反弹力度
            recoverAnimation.dynamicsMass = 2.0f;
            recoverAnimation.dynamicsTension = 200;
            recoverAnimation.toValue = @(0);
            [self.topView.layer pop_addAnimation:recoverAnimation forKey:@"recoverAnimation"];
            self.topShadowLayer.opacity = 0.0;
            self.bottomShadowLayer.opacity = 0.0;
        }
        
    }
    
    //手指超出边界也自动复原
    if (location.y < 0 || (location.y - self.initialLocation)>(CGRectGetHeight(self.bounds))-(self.initialLocation)) {
        recognizer.enabled = NO;
        POPSpringAnimation *recoverAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotationX];
        recoverAnimation.springBounciness = 18.0f; //弹簧反弹力度
        recoverAnimation.dynamicsMass = 2.0f;
        recoverAnimation.dynamicsTension = 200;
        recoverAnimation.toValue = @(0);
        [self.topView.layer pop_addAnimation:recoverAnimation forKey:@"recoverAnimation"];
        self.topShadowLayer.opacity = 0.0;
        self.bottomShadowLayer.opacity = 0.0;
        
    }
    
    recognizer.enabled = YES;
    
}
- (void)panBottom:(UIPanGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:self];
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.initialLocation = location.y;
        [self bringSubviewToFront:self.topView];
    }
    
    if ([[self.topView.layer valueForKeyPath:@"transform.rotation.x"] floatValue] < M_PI_2) {
        [CATransaction begin];
        [CATransaction setValue:((id)kCFBooleanTrue) forKey:kCATransactionDisableActions];
        self.topShadowLayer.opacity = 0.f;
        CGFloat opacity = (self.initialLocation - location.y) / self.initialLocation;
        self.bottomShadowLayer.opacity = opacity;
        self.bottomShadowLayer.opacity = opacity;
        [CATransaction commit];
    } else {
        [CATransaction begin];
        [CATransaction setValue:((id)kCFBooleanTrue) forKey:kCATransactionDisableActions];
        CGFloat opacity = (location.y - self.initialLocation) / (CGRectGetHeight(self.bounds) - self.initialLocation);
        self.topShadowLayer.opacity = opacity;
        self.bottomShadowLayer.opacity = opacity;
        [CATransaction commit];
    }
    
    //如果手指在PageView里面,开始使用POPAnimation
    if([self isLocation:location InView:self]){
        //把一个PI平均分成可以上滑的最大距离份
        CGFloat percent = -M_PI / self.initialLocation;
        
        POPBasicAnimation *rotationAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotationX];
        rotationAnimation.duration = 0.01;//默认的duration是0.4
        rotationAnimation.toValue =@((location.y-self.initialLocation)*percent);
        [self.bottomView.layer pop_addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        if (recognizer.state == UIGestureRecognizerStateEnded ||
            recognizer.state == UIGestureRecognizerStateCancelled) {
            POPSpringAnimation *recoverAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotationX];
            recoverAnimation.springBounciness = 18.0f; //弹簧反弹力度
            recoverAnimation.dynamicsMass = 2.0f;
            recoverAnimation.dynamicsTension = 200;
            recoverAnimation.toValue = @(0);
            [self.bottomView.layer pop_addAnimation:recoverAnimation forKey:@"recoverAnimation"];
            self.topShadowLayer.opacity = 0.0;
            self.bottomShadowLayer.opacity = 0.0;
        }
        
    }
    if (location.y < 0 || (location.y - self.initialLocation)>(CGRectGetHeight(self.bounds))-(self.initialLocation)) {
        recognizer.enabled = NO;
        POPSpringAnimation *recoverAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotationX];
        recoverAnimation.springBounciness = 18.0f; //弹簧反弹力度
        recoverAnimation.dynamicsMass = 2.0f;
        recoverAnimation.dynamicsTension = 200;
        recoverAnimation.toValue = @(0);
        [self.bottomView.layer pop_addAnimation:recoverAnimation forKey:@"recoverAnimation"];
        self.topShadowLayer.opacity = 0.0;
        self.bottomShadowLayer.opacity = 0.0;
        
    }
    
    recognizer.enabled = YES;

}
-(BOOL)isLocation:(CGPoint)location InView:(UIView *)view{
    if ((location.x > 0 && location.x < view.bounds.size.width) &&
        (location.y > 0 && location.y < view.bounds.size.height)) {
        return YES;
    }else{
        return NO;
    }
}



@end
