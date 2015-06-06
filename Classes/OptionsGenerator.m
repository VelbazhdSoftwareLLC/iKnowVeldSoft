//
//  OptionsGenerator.m
//  iKnow
//
//  Created by Trifon Dimov on 3/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "OptionsGenerator.h"
#import "mt.h"
#import <stdlib.h>
#import <time.h>


@implementation OptionsGenerator

-(id)init{
	options[0] = @"YES"; 
	options[1] = @"NO"; 
	options[2] = @"MAY BE"; 
	options[3] = @"TODAY"; 
	options[4] = @"PASS THE BUG"; 
	options[5] = @"REORGANIZE"; 
	options[6] = @"TOMORROW"; 
	options[7] = @"SIT ON IT";

	//srand(time(0));
	init_genrand(time(0));
	return self;
} 

-(void)dealloc{
	[options release];
	[super dealloc];
}

-(NSString*)doGuess{
	//return options[ rand()%8 ];
	return options [genrand_int32() % 8];
	
}

@end
