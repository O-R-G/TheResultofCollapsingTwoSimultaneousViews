//
//  TheResultofCollapsingTwoSimultaneousViewsView.m
//  TheResultofCollapsingTwoSimultaneousViews
//
//  Created by Eric Li on 10/4/18.
//  Copyright © 2018 O-R-G. All rights reserved.
//

#import "TheResultofCollapsingTwoSimultaneousViewsView.h"

@implementation TheResultofCollapsingTwoSimultaneousViewsView

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1/60.0];
    }
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
    [self initValues];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
    
    NSRect screenRect;
    NSColor *color;
    
    // Clear screen
    screenRect.size = NSMakeSize( size.width, size.height );
    color = [NSColor colorWithCalibratedRed:0 green:0 blue:0.196 alpha:1];
    [color set];
    NSRectFill(screenRect);
    
    for( int i = 0; i < numPoints; i++ )
    {
        if ( ( Points[i].x <= 0 || Points[i].x >= size.width ) || ( Points[i].y >= size.height || Points[i].y <= 0 ) )
        {
            Slopes[i] *= -1; // could change the speed here also? (or slope)
            
            /*
             if ( Slopes[i] >= 0 )
             {
             Slopes[i] = SSRandomFloatBetween( -1, 0 );
             } else {
             Slopes[i] = SSRandomFloatBetween( 0, 1 );
             }
             */
            
        }
        
        Points[i].x += Slopes[i];
        Points[i].y += ( 1 / Slopes[i] );
    }
    
    color = [NSColor colorWithCalibratedRed:1 green:1 blue:1 alpha:.75];
    [color set];
    
    [self DrawStructuralConstellation: Points];
}

- (void)animateOneFrame
{
    theta += (int) SSRandomFloatBetween( -2, 2 );
    // Check number of loops and redraw shape periodically
    
    if ( counter > 3600 ) [self initShape];
    else counter++;
    
    [self setNeedsDisplay:YES];
    return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

- (void) DrawStructuralConstellation: ( NSPoint[] ) myPoints
{
    NSBezierPath* thePath = [NSBezierPath bezierPath];
    
    [thePath moveToPoint: myPoints[0]];
    
    // Network
    
    for( int j = 1; j < numPoints; j++ )
    {
        [thePath moveToPoint: myPoints[j]];
        
        for( int i = 1; i < numPoints; i++ )
        {
            [thePath lineToPoint: myPoints[i]];
        }
    }
    
    
    /*
     // Polygon
     
     for( int i = 1; i < numPoints; i++ )
     {
     [thePath lineToPoint: myPoints[i]];
     }
     */
    
    [thePath closePath];
    [thePath stroke];
    
    /*
     NSColor *color;
     color = [NSColor colorWithCalibratedRed:0 green:0 blue:50 alpha:.05];
     [color set];
     [thePath fill];
     */
}

- (void) initValues
{
    theta = 0.0;
    alpha = 1; // for the lines
    size = [self bounds].size;
    xPos = ( size.width / 2 ) - boxSize;
    yPos = ( size.height / 2 ) - boxSize;
    boxSize = 1;
    
    [NSBezierPath setDefaultLineJoinStyle:NSMiterLineJoinStyle];
    [NSBezierPath setDefaultLineWidth: 2.0];
    
    [self initShape];
}

- (void) initShape
{
    // Initialize Points and Slopes
    
    counter = 0;
    numPoints = (int) SSRandomFloatBetween( 5, 9 );
    
    for( int i = 0; i < numPoints; i++ )
    {
        Points[i].x = SSRandomFloatBetween( 0, size.width );
        Points[i].y = SSRandomFloatBetween( 0, size.height );
        Slopes[i] = SSRandomFloatBetween( -1, 1 );
    }
}

@end
