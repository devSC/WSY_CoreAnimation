//
//  DrawingView.m
//  WSY_CoreAnimation
//
//  Created by 袁仕崇 on 15/1/11.
//  Copyright (c) 2015年 wilson-yuan. All rights reserved.
//

#import "DrawingView.h"
#define BRUSH_SIZE 32
@interface DrawingView ()

@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, strong) NSMutableArray *strokes;
@end
@implementation DrawingView

//+ (Class)layerClass
//{
//    return [CAShapeLayer class];
//}
- (void)awakeFromNib
{
    
//    self.path = [[UIBezierPath alloc] init];
//    self.path.lineJoinStyle = kCGLineJoinRound;
//    self.path.lineCapStyle = kCGLineJoinRound;
//    
//    self.path.lineWidth = 5;
//    
//    
//    CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
//    shapeLayer.strokeColor = [UIColor redColor].CGColor;
//    shapeLayer.fillColor = [UIColor clearColor].CGColor;
//    shapeLayer.lineJoin = kCALineJoinRound;
//    shapeLayer.lineCap = kCALineCapRound;
//    shapeLayer.lineWidth = 2;
    self.strokes = [NSMutableArray array];
    
}
- (void)addBrushStrokeAtPoint: (CGPoint)point
{
    [self.strokes addObject:[NSValue valueWithCGPoint:point]];
//    [self setNeedsDisplay];
    [self setNeedsDisplayInRect:[self brushRectForPoint:point]];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    CGPoint point = [[touches anyObject] locationInView:self];
    
//    self add
//    [self.path moveToPoint:point];
//    [self setNeedsDisplay];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    
//    [self.path addLineToPoint:point];
////    [self setNeedsDisplay];
//    ((CAShapeLayer *)self.layer).path = self.path.CGPath;
    [self addBrushStrokeAtPoint:point];
//    [self setNeedsDisplay];
}

- (CGRect)brushRectForPoint:(CGPoint)point {
    return CGRectMake(point.x - BRUSH_SIZE/2, point.y - BRUSH_SIZE/2, BRUSH_SIZE, BRUSH_SIZE);
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
//    [[UIColor clearColor] setFill];
//    [[UIColor redColor] setStroke];
//    [self.path stroke];
    
    for (NSValue *value in self.strokes) {
        CGPoint point = [value CGPointValue];
        
//        CGRect brushRect = CGRectMake(point.x - BRUSH_SIZE/2, point.y - BRUSH_SIZE/2, BRUSH_SIZE, BRUSH_SIZE);
        CGRect brushRect = [self brushRectForPoint:point];
        if (CGRectIntersectsRect(rect, brushRect)) {
            [[UIImage imageNamed:@"tree-01"] drawInRect:brushRect];
        }
    }
}


@end
