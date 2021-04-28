//
//  ChartView.m
//  OCDemo
//
//  Created by Jimmy King on 2021/4/27.
//

#import "ChartView.h"

@implementation ChartView

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    //画一个圆,作为父layer
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:rect.size.width];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    [self.layer addSublayer:layer];
    
    
    NSArray *sections = @[@(.1),@(.2),@(.7)];
    NSArray *sectionColors = @[UIColor.redColor, UIColor.orangeColor, UIColor.yellowColor];
    float total = 1;

    float startAngle = 0.0f;
    float endAngle = 0.0f;
    CGPoint center = CGPointMake(rect.size.width/2, rect.size.height/2);

    for (int i = 0; i < sectionColors.count; i++) {
        CGFloat percent = [sections[i] floatValue]/ total;
        /** 重新设置起始位置 */
        startAngle = endAngle;
        endAngle = startAngle + percent * 2 * M_PI;

        //* 比例弧形layer */
        UIBezierPath *arcPath = [UIBezierPath bezierPathWithArcCenter:center radius:rect.size.width/2 startAngle:startAngle endAngle:endAngle clockwise:YES];
        [arcPath addLineToPoint:center];
        [arcPath closePath];
        CAShapeLayer *arcShapeLayer = [CAShapeLayer layer];
        arcShapeLayer.path = arcPath.CGPath;
        UIColor *color = sectionColors[i];
        arcShapeLayer.fillColor = color.CGColor;
        arcShapeLayer.strokeColor = [UIColor clearColor].CGColor;
        [layer addSublayer:arcShapeLayer];
        
        CABasicAnimation *baseAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        //绘制结束到绘制开始的的动画
        baseAnimation.fromValue = @1;
        baseAnimation.toValue = @0;
        baseAnimation.duration = 3.0f;
        
        baseAnimation.fillMode = kCAFillModeForwards;//保持当前状态
        // 动画缓慢的进入，中间加速，然后减速的到达目的地。
        baseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [arcShapeLayer addAnimation:baseAnimation forKey:nil];
    }

    /*
     先添加一个空白的layer,完全遮盖饼状图,然后将绘制的过程添加逆向动画
     */
    CABasicAnimation *baseAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    //绘制结束到绘制开始的的动画
    baseAnimation.fromValue = @1;
    baseAnimation.toValue = @0;
    baseAnimation.duration = 3.0f;
    /** 保持动画执行的状态 */
    baseAnimation.removedOnCompletion = NO;//执行完成后动画对象不要移除
    baseAnimation.fillMode = kCAFillModeForwards;//保持当前状态
    // 动画缓慢的进入，中间加速，然后减速的到达目的地。
    baseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //画中间白色的圆
    UIBezierPath *coverPath = [UIBezierPath bezierPathWithArcCenter:center radius:(rect.size.width-60)/2 startAngle:0 endAngle: 2*M_PI clockwise:NO];
    CAShapeLayer *coverLayer = [CAShapeLayer layer];
    coverLayer.path = coverPath.CGPath;
    coverLayer.lineWidth = 61;
//    coverLayer.fillColor = UIColor.greenColor.CGColor; //RGB_COLOR(238, 238, 238).CGColor;
    coverLayer.strokeColor = UIColor.cyanColor.CGColor;//RGB_COLOR(238, 238, 238).CGColor;

    //添加绘制的白色的遮罩圆到父layer
    [layer addSublayer:coverLayer];
    [coverLayer addAnimation:baseAnimation forKey:nil];
}


@end
