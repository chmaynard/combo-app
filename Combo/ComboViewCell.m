//
//  ComboViewCell.m
//  Combo
//
//  Created by Craig H Maynard on 12/8/13.
//  Copyright (c) 2016 Craig H Maynard. All rights reserved.
//

#import "ComboViewCell.h"

@implementation ComboViewCell

#pragma mark - Properties

- (void)setRank:(NSUInteger)rank
{
    _rank = rank;
    [self setNeedsDisplay];
}

- (void)setShape:(NSString *)shape
{
    _shape = shape;
    [self setNeedsDisplay];
}

- (void)setColor:(NSString *)color
{
    _color = color;
    [self setNeedsDisplay];
}

- (void)setShading:(NSString *)shading
{
    _shading = shading;
    [self setNeedsDisplay];
}

- (void)setFillColor:(UIColor *)fillColor
{
    _fillColor = fillColor;
    [self setNeedsDisplay];
}

#pragma mark - Drawing

#define STANDARD_HEIGHT 210.0
#define CORNER_RADIUS 12.0

- (CGFloat)scaleFactor { return self.bounds.size.height / STANDARD_HEIGHT; }
- (CGFloat)cornerRadius { return CORNER_RADIUS * [self scaleFactor]; }

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];

    [roundedRect addClip];

    [self.fillColor setFill];
    UIRectFill(self.bounds);

    [[UIColor blackColor] setStroke];
    [roundedRect stroke];

    [self drawCard];
}

- (void)drawCard
{
    UIBezierPath *path;

    if ([self.color isEqualToString:@"red"]) {
        [[UIColor redColor] set];
    }

    if ([self.color isEqualToString:@"green"]) {
        [[UIColor greenColor] set];
    }

    if ([self.color isEqualToString:@"blue"]) {
        [[UIColor blueColor] set];
    }

    [self pushContextAndTranslate];

    for (int i = 0; i < self.rank; i++) {

        CGSize size = CGSizeMake(self.bounds.size.width - (40 * [self scaleFactor]), self.bounds.size.height / 5);
        CGFloat xoffset = 20 * [self scaleFactor];
        CGFloat yoffset = (self.bounds.size.height / 2) - (size.height / 2) + (i * (size.height + (10 * [self scaleFactor])));

        CGPoint origin = CGPointMake(xoffset, yoffset);
        CGRect frame = { origin, size };

        // this line causes a vertical alignment problem when drawing 3 shapes at iPhone 4 scale factor
        //frame = CGRectIntegral(frame);

        if ([self.shape isEqualToString:@"rectangle"]) {
            path = [UIBezierPath bezierPathWithRect:frame];
        }

        if ([self.shape isEqualToString:@"oval"]) {
            path = [UIBezierPath bezierPathWithOvalInRect:frame];
        }

        if ([self.shape isEqualToString:@"diamond"]) {
            path = [self bezierPathWithDiamondInRect:frame];
        }

        [self drawWithPath:path];
    }

    [self popContext];
}

- (void)drawWithPath:(UIBezierPath *)path
{
    path.lineWidth = 4.0 * [self scaleFactor];
    [path stroke];

    if ([self.shading isEqualToString:@"dark"]) {
        [path fill];
    }

    if ([self.shading isEqualToString:@"light"]) {
        [path fillWithBlendMode:kCGBlendModeNormal alpha:0.25];
    }
}

- (UIBezierPath *)bezierPathWithDiamondInRect:(CGRect)rect
{
    UIBezierPath *path = [UIBezierPath bezierPath];

    [path moveToPoint:CGPointMake(rect.origin.x + rect.size.width / 2, rect.origin.y)];
    [path addLineToPoint:CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height / 2)];
    [path addLineToPoint:CGPointMake(rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height)];
    [path addLineToPoint:CGPointMake(rect.origin.x, rect.origin.y + rect.size.height / 2)];
    [path closePath];

    return path;
}

- (void)pushContextAndTranslate
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);

    if (self.rank == 2) {
        CGContextTranslateCTM(context, 0, -25.0 * [self scaleFactor]);
    }

    if (self.rank == 3) {
        CGContextTranslateCTM(context, 0, -50.0 * [self scaleFactor]);
    }
}

- (void)popContext
{
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

#pragma mark - Initialization

- (void)setup
{
    self.fillColor = [UIColor whiteColor];
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

#if 0
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.contentView.frame = self.bounds;
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |UIViewAutoresizingFlexibleTopMargin |UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    [self setup];
}
#endif

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

@end
