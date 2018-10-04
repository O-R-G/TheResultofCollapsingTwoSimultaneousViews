//
//  TheResultofCollapsingTwoSimultaneousViewsView.h
//  TheResultofCollapsingTwoSimultaneousViews
//
//  Created by Eric Li on 10/4/18.
//  Copyright © 2018 O-R-G. All rights reserved.
//

#import <ScreenSaver/ScreenSaver.h>
#define maxNumPoints 100 // constant

@interface TheResultofCollapsingTwoSimultaneousViewsView : ScreenSaverView
{
    
    // Instance variables
    
    float theta, alpha;
    int xPos, yPos, boxSize, numPoints;
    NSSize size;
    NSPoint Points[ maxNumPoints ];
    float Slopes[ maxNumPoints ];
    int counter;
}


// Additional (non-static) methods

- (void) initValues;
- (void) DrawStructuralConstellation: ( NSPoint[] ) myPoints;
- (void) initShape;
@end
