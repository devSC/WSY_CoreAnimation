//
//  ViewController.m
//  WSY_CoreAnimation
//
//  Created by 袁仕崇 on 15/1/7.
//  Copyright (c) 2015年 wilson-yuan. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"
#import  "A3DViewController.h"
#import <CoreText/CoreText.h>

#define WIDTH 10
#define HEIGHT 10
#define DEPTH 10 
#define SIZE 100
#define SPACING 150 
#define CAMERA_DISTANCE 500
#define PERSPECTIVE(z) (float)CAMERA_DISTANCE/(z + CAMERA_DISTANCE)

@interface ViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *layerView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *rightView;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) CALayer *doorLayer;
@property (strong, nonatomic) CALayer *blueLayer;
@property (strong, nonatomic) NSArray *images;

@property (nonatomic, strong) UIImageView *ballView;
//@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) CADisplayLink *timer;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) NSTimeInterval timeOffset;
@property (nonatomic, strong) id fromValue;
@property (nonatomic, strong) id toValue;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableSet *recyclePool;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    CATransform3D transform = CATransform3DIdentity;
//    transform.m34 = -1/500.0f;
//    self.contentView.layer.sublayerTransform = transform;
//    self.contentView.layer.transform = CATransform3DMakeRotation(-M_PI_4, 0, 1, 0);
//
//    self.layerView.layer.transform = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    
//    UIBezierPath *path = [[UIBezierPath alloc] init];
//    [path moveToPoint:CGPointMake(175, 100)];
//    
//    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
//    [path moveToPoint:CGPointMake(150, 125)];
//    [path addLineToPoint:CGPointMake(150, 175)];
//    [path addLineToPoint:CGPointMake(125, 225)];
//    [path moveToPoint:CGPointMake(150, 175)];
//    [path addLineToPoint:CGPointMake(175, 225)];
//    [path moveToPoint:CGPointMake(100, 150)];
//    [path addLineToPoint:CGPointMake(200, 150)];
    
//    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    shapeLayer.strokeColor = [UIColor redColor].CGColor;
//    shapeLayer.fillColor = [UIColor clearColor].CGColor;
//    shapeLayer.lineWidth = 5;
//    shapeLayer.lineJoin = kCALineJoinRound;
//    shapeLayer.lineCap = kCALineCapRound;
//    shapeLayer.path = path.CGPath;
//    
//    [self.contentView.layer addSublayer:shapeLayer];
//    
//    CGRect rect = CGRectMake(0, 0, 100, 200);
//    CGSize radii = CGSizeMake(20, 20);
//    UIRectCorner corners = UIRectCornerAllCorners;
//    
////    UIBezierPath paths = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
//    
//    CATextLayer *textLayer = [CATextLayer layer];
//    textLayer.frame = self.contentView.bounds;
//    [self.contentView.layer addSublayer:textLayer];
//    
//    
//    textLayer.foregroundColor = [UIColor blackColor].CGColor;
//    textLayer.alignmentMode = kCAAlignmentJustified;
//    textLayer.wrapped = YES;
//    
//    UIFont *font = [UIFont systemFontOfSize:15];
//    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
//    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
//    
//    textLayer.font = fontRef;
//    textLayer.fontSize = font.pointSize;
//    CGFontRelease(fontRef);
//    
//    NSString *text = @"Lorem ipsum dolor sit amet, consectetur adipiscing \ elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar \ leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc elementum, libero ut porttitor dictum, diam odio congue lacus, vel \ fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet \ lobortis";
//    textLayer.string = text;
//    
//    textLayer.contentsScale = [UIScreen mainScreen].scale;
    
    /*
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = self.contentView.bounds;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.contentView.layer addSublayer:textLayer];
    //set text attributes
    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.wrapped = YES;
    //choose a font
    UIFont *font = [UIFont systemFontOfSize:15];
    //choose some text
    NSString *text = @"Lorem ipsum dolor sit amet, consectetur adipiscing \ elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar \ leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc \ elementum, libero ut porttitor dictum, diam odio congue lacus, vel \ fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet \ lobortis";
    //create attributed string
    NSMutableAttributedString *string = nil;
    string = [[NSMutableAttributedString alloc] initWithString:text];
    //convert UIFont to a CTFont
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFloat fontSize = font.pointSize;
    CTFontRef fontRef = CTFontCreateWithName(fontName, fontSize, NULL);
    //set text attributes
    NSDictionary *attribs = @{
                              (__bridge id)kCTForegroundColorAttributeName:(__bridge id)[UIColor blackColor].CGColor,
                              (__bridge id)kCTFontAttributeName: (__bridge id)fontRef
                              };
    [string setAttributes:attribs range:NSMakeRange(0, [text length])];
    attribs = @{
                (__bridge id)kCTForegroundColorAttributeName: (__bridge id)[UIColor redColor].CGColor,
                (__bridge id)kCTUnderlineStyleAttributeName: @(kCTUnderlineStyleSingle),
                (__bridge id)kCTFontAttributeName: (__bridge id)fontRef
                };
    [string setAttributes:attribs range:NSMakeRange(6, 5)];
    //release the CTFont we created earlier
    CFRelease(fontRef);
    //set layer text
    textLayer.string = string;
    
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.frame = self.contentView.bounds;
//    [self.contentView.layer addSublayer:gradientLayer];
//    
//    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,  (__bridge id )[UIColor yellowColor].CGColor, (__bridge id)[UIColor blueColor].CGColor];
//    gradientLayer.locations = @[@0.0, @0.5, @1];
//    gradientLayer.startPoint = CGPointMake(0, 0);
//    gradientLayer.endPoint = CGPointMake(1, 1);

    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = self.contentView.bounds;
    [self.contentView.layer addSublayer:replicatorLayer];
    
    replicatorLayer.instanceCount = 10;
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 200, 0);
    transform = CATransform3DRotate(transform, M_PI/5, 0, 0, 1);
    transform = CATransform3DTranslate(transform, 0, -200, 0);
    
    replicatorLayer.instanceTransform = transform;
    replicatorLayer.instanceBlueOffset = -0.1;
    replicatorLayer.instanceGreenOffset = -0.1;
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(100, 100, 100, 100);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    [replicatorLayer addSublayer:layer];

     //create particle emitter layer
//    CAEmitterLayer *emitter = [CAEmitterLayer layer];
//    emitter.frame = self.view.bounds;
//    [self.view.layer addSublayer:emitter];
//    //configure emitter
//    emitter.renderMode = kCAEmitterLayerAdditive;
//    emitter.emitterPosition = CGPointMake(emitter.frame.size.width / 2.0, emitter.frame.size.height / 2.0);
//    //create a particle template
//    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
//    cell.contents = (__bridge id)[UIImage imageNamed:@"tree-01"].CGImage;
//    cell.birthRate = 150;
//    cell.lifetime = 5.0;
//    cell.color = [UIColor colorWithRed:1 green:0.5 blue:0.1 alpha:1.0].CGColor;
//    cell.alphaSpeed = -0.4;
//    cell.velocity = 50;
//    cell.velocityRange = 50;
//    cell.emissionRange = M_PI * 2.0;
//    //add particle template to emitter
//    emitter.emitterCells = @[cell];
    
    
//    self.blueLayer = [CALayer layer];
//    self.blueLayer.frame = CGRectMake(0, 0, 100, 100);
//    self.blueLayer.backgroundColor = [UIColor greenColor].CGColor;
//    self.blueLayer.position = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);;
//    [self.view.layer addSublayer:self.blueLayer];
    
    
//    CATransition *transition = [CATransition animation];
//    transition.type = kCATransitionPush;
//    transition.subtype = kCATransitionFromLeft;
//    self.blueLayer.actions = @{@"backgroundColor":transition};
//    
//    [self.contentView.layer addSublayer:self.blueLayer];

    
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(0, 150)];
    [bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 2.0f;
    [self.view.layer addSublayer:pathLayer];
    
    CALayer *shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 64, 64);
    shipLayer.position = CGPointMake(0, 150);
//    shipLayer.contents = (__bridge id)[UIImage imageNamed:@"tree-01"].CGImage;
    shipLayer.backgroundColor = [UIColor greenColor].CGColor;
    [self.view.layer addSublayer:shipLayer];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    animation.duration = 2.0f;
    animation.path = bezierPath.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
//    [shipLayer addAnimation:animation forKey:nil];
    

    CABasicAnimation *baseAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    baseAnimation.toValue = (__bridge id)[UIColor redColor].CGColor;
//    baseAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI*3, 0, 0, 1)];
//    baseAnimation.byValue = @(M_PI * 6);
//    baseAnimation.duration = 6.0f;
//    [shipLayer addAnimation:baseAnimation forKey:nil];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[animation, baseAnimation];
    group.duration = 4.0f;
    
    [shipLayer addAnimation:group forKey:nil];
    
     */

//    self.images = @[[UIImage imageNamed:@"tree-01"],
//                    [UIImage imageNamed:@"girl.jpg"],
//                    [UIImage imageNamed:@"pan"],
//                    [UIImage imageNamed:@"h"]];
    
    //apply perspective transform
//    CATransform3D perspective = CATransform3DIdentity;
//    perspective.m34 = -1.0 / 500.0;
//    self.view.layer.sublayerTransform = perspective;
//    //add pan gesture recognizer to handle swipes
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
//    [pan addTarget:self action:@selector(pan:)];
//    [self.view addGestureRecognizer:pan];
//
//    
//    
//    self.doorLayer = [CALayer layer];
//    self.doorLayer.frame = CGRectMake(0, 0, 100, 100);
//    self.doorLayer.position = CGPointMake(150 - 64, 150);
//    self.doorLayer.anchorPoint = CGPointMake(0, 0.5);
//    self.doorLayer.contents = (__bridge id)[UIImage imageNamed:@"tree-01"].CGImage;
//    [self.view.layer addSublayer:self.doorLayer];
//    //pause all layer animations
//    self.doorLayer.speed = 0.0;
//    //apply swinging animation (which won't play because layer is paused)
//    CABasicAnimation *animation = [CABasicAnimation animation];
//    animation.keyPath = @"transform.rotation.y";
//    animation.toValue = @(-M_PI_2);
//    animation.duration = 1.0;
//    [self.doorLayer addAnimation:animation forKey:nil];
//    
////    
//    self.blueLayer = [CALayer layer];
//    self.blueLayer.frame = CGRectMake(0, 200, 128, 128);
//    self.blueLayer.position = CGPointMake(150, 250);
//    self.blueLayer.contents = (__bridge id)[UIImage imageNamed: @"tree-01"].CGImage;
//    self.blueLayer.anchorPoint = CGPointMake(0, 0.5);
//    self.blueLayer.speed = 0;
//
//    [self.view.layer addSublayer:self.blueLayer];
//    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
//    animation2.toValue = @(-M_PI_2);
//    animation2.duration = 1.0;
//    animation.repeatCount = INFINITY;
//    animation.autoreverses = YES;
//    animation2.speed = 0;
//    animation2.timeOffset = 0.5f;
//    animation.fillMode = kCAFillModeBackwards;

//    [self.blueLayer addAnimation:animation2 forKey:nil];
//
//    
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
//    [pan addTarget:self action:@selector(pan:)];
//    [self.view addGestureRecognizer:pan];
    
    /*
    self.ballView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tree-01"]];
    [self.view addSubview:self.ballView];
    
    [self animation];
     */
    
    self.recyclePool = [NSMutableSet set];
    
    self.scrollView.contentSize = CGSizeMake((WIDTH - 1)*SPACING, (HEIGHT - 1)*SPACING);
    //set up perspective transform
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0 / CAMERA_DISTANCE;
    self.scrollView.layer.sublayerTransform = transform; //create layers
    for (int z = DEPTH - 1; z >= 0; z--) {
        for (int y = 0; y < HEIGHT; y++) {
            for (int x = 0; x < WIDTH; x++) { //create layer
                CALayer *layer = [CALayer layer];
                layer.frame = CGRectMake(0, 0, SIZE, SIZE);
                layer.position = CGPointMake(x*SPACING, y*SPACING);
                layer.zPosition = -z*SPACING; //set background color
                layer.backgroundColor = [UIColor colorWithWhite:1-z*(1.0/DEPTH) alpha:1].CGColor; //attach to scroll view
                [self.scrollView.layer addSublayer:layer]; }
        }
    } //logd
    
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    [self updateLayers];
//}
//- (void)viewDidLayoutSubviews
//{
//    [self updateLayers];
//}

- (void)updateLayers
{
//    //calculate clipping bounds
//    CGRect bounds = self.scrollView.bounds;
//    bounds.origin = self.scrollView.contentOffset;
//    bounds = CGRectInset(bounds, -SIZE/2, -SIZE/2);
//    //create layers
//    NSMutableArray *visibleLayers = [NSMutableArray array];
//    for (int z = DEPTH - 1; z >= 0; z--)
//    {
//        //increase bounds size to compensate for perspective
//        CGRect adjusted = bounds;
//        adjusted.size.width /= PERSPECTIVE(z*SPACING);
//        adjusted.size.height /= PERSPECTIVE(z*SPACING);
//        adjusted.origin.x -= (adjusted.size.width - bounds.size.width) / 2;
//        adjusted.origin.y -= (adjusted.size.height - bounds.size.height) / 2;
//        for (int y = 0; y < HEIGHT; y++) {
//            //check if vertically outside visible rect
//            if (y*SPACING < adjusted.origin.y || y*SPACING >= adjusted.origin.y + adjusted.size.height)
//            {
//                continue;
//            }
//            for (int x = 0; x < WIDTH; x++) {
//                //check if horizontally outside visible rect
//                if (x*SPACING < adjusted.origin.x ||x*SPACING >= adjusted.origin.x + adjusted.size.width)
//                {
//                    continue;
//                }
//                //create layer
//                CALayer *layer = [CALayer layer];
//                layer.frame = CGRectMake(0, 0, SIZE, SIZE);
//                layer.position = CGPointMake(x*SPACING, y*SPACING);
//                layer.zPosition = -z*SPACING;
//                //set background color
//                layer.backgroundColor = [UIColor colorWithWhite:1-z*(1.0/DEPTH) alpha:1].CGColor;
//                //attach to scroll view
//                [visibleLayers addObject:layer];
//            }
//        }
//    }
//    //update layers
//    self.scrollView.layer.sublayers = visibleLayers;
//    //log
//    NSLog(@"displayed: %i/%i", [visibleLayers count], DEPTH*HEIGHT*WIDTH);
    
    //calculate clipping bounds
    CGRect bounds = self.scrollView.bounds;
    bounds.origin = self.scrollView.contentOffset;
    bounds = CGRectInset(bounds, -SIZE/2, -SIZE/2);
    //add existing layers to pool
    [self.recyclePool addObjectsFromArray:self.scrollView.layer.sublayers];
    //disable animation
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    //create layers
    NSInteger recycled = 0;
    NSMutableArray *visibleLayers = [NSMutableArray array];
    for (int z = DEPTH - 1; z >= 0; z--)
    {
        //increase bounds size to compensate for perspective
        CGRect adjusted = bounds;
        adjusted.size.width /= PERSPECTIVE(z*SPACING);
        adjusted.size.height /= PERSPECTIVE(z*SPACING);
        adjusted.origin.x -= (adjusted.size.width - bounds.size.width) / 2; adjusted.origin.y -= (adjusted.size.height - bounds.size.height) / 2;
        for (int y = 0; y < HEIGHT; y++) {
            //check if vertically outside visible rect
            if (y*SPACING < adjusted.origin.y ||
                y*SPACING >= adjusted.origin.y + adjusted.size.height)
            {
                continue;
            }
            for (int x = 0; x < WIDTH; x++) {
                //check if horizontally outside visible rect
                if (x*SPACING < adjusted.origin.x ||
                    x*SPACING >= adjusted.origin.x + adjusted.size.width)
                {
                    continue;
                }
                //recycle layer if available
                CALayer *layer = [self.recyclePool anyObject]; if (layer)
                {
                    recycled ++;
                    [self.recyclePool removeObject:layer]; }
                else
                {
                    layer.frame = CGRectMake(0, 0, SIZE, SIZE); }
                //set position
                layer.position = CGPointMake(x*SPACING, y*SPACING); layer.zPosition = -z*SPACING;
                //set background color
                layer.backgroundColor =
                [UIColor colorWithWhite:1-z*(1.0/DEPTH) alpha:1].CGColor;
                //attach to scroll view
                if (layer == nil )
                    return;
                [visibleLayers addObject:layer];
            }
        } }
    [CATransaction commit]; //update layers
    self.scrollView.layer.sublayers = visibleLayers;
    //log
    NSLog(@"displayed: %d /%i recycled: %d",
          [visibleLayers count], DEPTH*HEIGHT*WIDTH, recycled);

}

//- (void)updateLayers
//{
//    
//    CGRect bounds = self.scrollView.bounds;
//    bounds.origin = self.scrollView.contentOffset;
//    bounds = CGRectInset(bounds, -SIZE/2, -SIZE/2);
//    //creat layers
//    
//    NSMutableArray *visibleLayers = [NSMutableArray array];
//    
//    for (int z = DEPTH -1; z >= 0; z--) {
//        //increase bounds size to compensate
//        CGRect adjust = bounds;
//        adjust.size.width /= PERSPECTIVE(z * SPACING);
//        adjust.size.height /= PERSPECTIVE(z * SPACING);
//        adjust.origin.x -= (adjust.size.width - bounds.size.width)/2;
//        adjust.origin.y -= (adjust.size.height - bounds.size.height)/2;
//        
//        for (int y = 0; y < HEIGHT; y++) {
//            //check if vertically outside visible rect
//            if (y*SPACING < adjust.origin.y || y*SPACING >= adjust.origin.y + adjust.size.height) {
//                continue;
//            }
//            for (int x = 0; x < WIDTH; x++) {
//                //check if horizontally outside  visible rect
//                if (x * SPACING < adjust.origin.x || x*SPACING >= adjust.origin.x + adjust.size.width) {
//                    {
//                        continue;
//                    }
//                    CALayer *layer = [CALayer layer];
//                    layer.frame = CGRectMake(0, 0, SIZE, SIZE);
//                    layer.position = CGPointMake(x *SPACING, y * SPACING);
//                    layer.zPosition = -z*SPACING;
//                    
//                    layer.backgroundColor = [UIColor colorWithWhite:1-z*(1.0/DEPTH) alpha:1].CGColor;
//                    [visibleLayers addObject:layer];
//                }
//            }
//        }
//        //update layers
//        self.scrollView.layer.sublayers = visibleLayers;
//        //log
//        NSLog(@"displayed: %ld /%i", [visibleLayers count], DEPTH*HEIGHT*WIDTH);
//        
//    }
//    
//}

- (void)animation {
    self.ballView.center = CGPointMake(150, 32);
    self.duration = 1.0;
    self.timeOffset = 0.0;
    self.fromValue = [NSValue valueWithCGPoint:CGPointMake(150, 32)];
    self.toValue = [NSValue valueWithCGPoint:CGPointMake(150, 268)];
    
    //stop the timer if it's already running
    [self.timer invalidate];
    
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1/60.0 target:self selector:@selector(step:) userInfo:nil repeats:YES];
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(step:)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    
}
- (void)step: (CADisplayLink *)step
{
    self.timeOffset = MIN(self.timeOffset + 1/60.0, self.duration);
    
    float time = self.timeOffset/self.duration;
    
    time = bounceEaseOut(time);
    id position = [self interpolateFromValue:self.fromValue toValue:self.toValue time:time];
    
    self.ballView.center = [position CGPointValue];
    if (self.timeOffset >= self.duration) {
        [self.timer invalidate];
        self.timer = nil;
    }
}
float bounceEaseOut (float t)
{
    if (t < 4/11.0) {
        return (121 * t * t)/16.0;
    }else if (t < 8/11.0) {
        return (365/40.0 *t *t) - (99/10.0 *t) + 16061/1805.0;
    }else if (t < 9/10.0) {
        return (4356/361.0 *t *t) - (35442/1805.0 * t) +16061/1805.0;
    }
    return (54/5.0 * t * t) - (513/25.0 * t) + 268/25.0;
}

- (id)interpolateFromValue: (id)fromValue toValue: (id)toValue time: (float)time
{
    if ([fromValue isKindOfClass:[NSValue class]]) { //get type const
        char *type = [(NSValue *)fromValue objCType];
        if (strcmp(type, @encode(CGPoint)) == 0) {
            CGPoint from = [fromValue CGPointValue];
            CGPoint to = [toValue CGPointValue];
            CGPoint result = CGPointMake(interpolate(from.x, to.x, time), interpolate(from.y, to.y, time));
            return [NSValue valueWithCGPoint:result];
        }
    } //provide safe default implementation
    return (time < 0.5)? fromValue: toValue;
}

float interpolate(float from, float to, float time)
{
    return (to - from) * time + from;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event { //replay animation on tap
    [self animation];
}
/*

- (void)pan:(UIPanGestureRecognizer *)pan
{
    //get horizontal component of pan gesture
    CGFloat x = [pan translationInView:self.view].x;
    //convert from points to animation duration //using a reasonable scale factor
    x /= 200.0f;
    //update timeOffset and clamp result
    CFTimeInterval timeOffset = self.doorLayer.timeOffset;
    timeOffset = MIN(0.999, MAX(0.0, timeOffset - x));
    self.doorLayer.timeOffset = timeOffset;
    self.blueLayer.timeOffset = timeOffset;
    NSLog(@"%f", timeOffset);
    //reset pan gesture
    [pan setTranslation:CGPointZero inView:self.view];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    
    if ([self.blueLayer.presentationLayer hitTest:point]) {
        
        CGFloat red = arc4random() / (CGFloat)INT_MAX;
        CGFloat green = arc4random() / (CGFloat)INT_MAX;
        CGFloat blue = arc4random() / (CGFloat)INT_MAX;
        self.blueLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    } else {
    
        [CATransaction begin];
        [CATransaction setAnimationDuration:1.0];
        self.blueLayer.position = point;
        [CATransaction commit];
    }
    
}

CGAffineTransform CGAffineTransformMakeShear(CGFloat x, CGFloat y)
{
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform.c = -x;
    transform.b = y;
    return transform;
}
 */
//- (IBAction)slider:(id)sender {
//    UISlider *slider = (UISlider *)sender;
//    self.view.layer.speed = (slider.value * 10) ;
//    
//}
//
- (IBAction)start
{
    //animate the ship rotation
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.duration = 8.0;
    animation.byValue = @(M_PI * 2);
    animation.delegate = self;
    animation.repeatCount = MAXFLOAT;
    [self.blueLayer addAnimation:animation forKey:@"rotateAnimation"];
}
- (IBAction)stop
{
    [self.blueLayer removeAnimationForKey:@"rotateAnimation"];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //log that the animation stopped
    NSLog(@"The animation stopped (finished: %@)", flag? @"YES": @"NO");
}

- (IBAction)goTo3D:(id)sender {
//    A3DViewController *a = [[A3DViewController alloc] initWithNibName:@"A3DViewController" bundle:nil];
//    [self.navigationController pushViewController:a animated:YES];
//    [CATransaction begin];
//    [CATransaction setAnimationDuration:2.0];
//    [CATransaction setCompletionBlock:^{
//        CGAffineTransform transform = CGAffineTransformIdentity;
//        transform = CGAffineTransformRotate(transform, M_PI_2);
//        self.blueLayer.affineTransform = transform;
//    }];
    
//    CGFloat red = arc4random()/(CGFloat)INT_MAX;
//    CGFloat green = arc4random()/(CGFloat)INT_MAX;
//    CGFloat blue = arc4random()/(CGFloat)INT_MAX;
//    
//    CGColorRef cgColor = [UIColor colorWithRed:red green:green blue:blue alpha:1].CGColor;
//    
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
////    animation.fromValue = (__bridge id)self.blueLayer.backgroundColor;
//    animation.duration = 2.0f;
//    animation.toValue = (__bridge id)cgColor;
//    
//    [self applyBaseAnimation:animation toLayer:self.blueLayer];
    
//    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
//    animation.keyPath = @"backgroundColor";
//    animation.duration = 4.0;
//    animation.values = @[
//                         (__bridge id)[UIColor blueColor].CGColor,
//                         (__bridge id)[UIColor redColor].CGColor,
//                         (__bridge id)[UIColor greenColor].CGColor,
//                         (__bridge id)[UIColor blueColor].CGColor ];
//    //apply animation to layer
//    [self.blueLayer addAnimation:animation forKey:nil];
    
//    CATransition *transition = [CATransition animation];
//    transition.type = kCATransitionMoveIn;
//    transition.subtype = kCATransitionFromLeft;
//    [self.imageView.layer addAnimation:transition forKey:nil];
//    UIImage *image = self.imageView.image;
//    NSInteger index = [self.images indexOfObject:image];
//    index = (index +1) % self.images.count;
//    self.imageView.image = self.images[index];

    
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, 0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *coverImage = UIGraphicsGetImageFromCurrentImageContext();
    UIView *coverView = [[UIImageView alloc] initWithImage:coverImage];
    [self.view addSubview:coverView];
    
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.view.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];

    [UIView animateWithDuration:1.0 animations:^{
        
        CGAffineTransform transfrom = CGAffineTransformMakeScale(0.01, 0.01);
        transfrom = CGAffineTransformRotate(transfrom, M_PI);
        coverView.transform = transfrom;
        coverView.alpha = 0;
    } completion:^(BOOL finished) {
        [coverView removeFromSuperview];
    }];
    
    
    
}

/*
- (void)applyBaseAnimation: (CABasicAnimation *)animaiton toLayer: (CALayer *)layer
{

    animaiton.fromValue = [layer.presentationLayer ?:layer valueForKeyPath:animaiton.keyPath];
    [CATransaction begin];
    
    [CATransaction setDisableActions:YES];
    [layer setValue:animaiton forKeyPath:animaiton.keyPath];
    [CATransaction commit];
    [layer addAnimation:animaiton forKey:nil];
}


//
//- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
//{
//    CGContextSetLineWidth(ctx, 10.0f);
//    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
//    
//    CGContextStrokeEllipseInRect(ctx, layer.bounds);
//}
//
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
//    touchPoint = [self.redView.layer convertPoint:touchPoint fromLayer:self.view.layer];
//    
//    if ([self.redView.layer containsPoint:touchPoint]) {
//        touchPoint = [self.blueLayer convertPoint:touchPoint fromLayer:self.redView.layer];
//        if ([self.blueLayer containsPoint:touchPoint]) {
//            [[[UIAlertView alloc] initWithTitle:@"inside Blue Layer" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
//        }
//        else {
//            [[[UIAlertView alloc] initWithTitle:@"outSide Blue Layer" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];        }
//    }
//}
//-(void)tick
//{
//    //convert time to hours, minutes and seconds
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSUInteger units = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
//    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
//    CGFloat hoursAngle = (components.hour / 12.0) * M_PI * 2.0;
//    //calculate hour hand angle //calculate minute hand angle
//    CGFloat minsAngle = (components.minute / 60.0) * M_PI * 2.0;
//    //calculate second hand angle
//    CGFloat secsAngle = (components.second / 60.0) * M_PI * 2.0;
//    //rotate hands
//    self.hourHand.transform = CGAffineTransformMakeRotation(hoursAngle);
//    self.minuteHand.transform = CGAffineTransformMakeRotation(minsAngle);
//    self.secondHand.transform = CGAffineTransformMakeRotation(secsAngle);
//}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
