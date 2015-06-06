//
//  OptionsGenerator.h
//  iKnow
//
//  Created by Trifon Dimov on 3/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OptionsGenerator : NSObject {
	NSString *options[ 8 ];
}

-(id)init; 
-(void)dealloc;
-(NSString*)doGuess;

@end
