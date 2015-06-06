//
//  iKnowViewController.h
//  iKnow
//
//  Created by Trifon Dimov on 3/10/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OptionsGenerator.h"

@interface iKnowViewController : UIViewController <UIAccelerometerDelegate>{
	IBOutlet UIButton *button;
	OptionsGenerator *generator;
	int moveCounter;
	int guessCounter;
	int dmState;
}

- (IBAction) buttonPressed:(id)sender;

@property(nonatomic, retain)IBOutlet UIButton *button;
@property(nonatomic, retain)IBOutlet UILabel *label;
@property(nonatomic, retain)IBOutlet UIImageView *sector01;
@property(nonatomic, retain)IBOutlet UIImageView *sector02;
@property(nonatomic, retain)IBOutlet UIImageView *sector03;
@property(nonatomic, retain)IBOutlet UIImageView *sector04;
@property(nonatomic, retain)IBOutlet UIImageView *sector05;
@property(nonatomic, retain)IBOutlet UIImageView *sector06;
@property(nonatomic, retain)IBOutlet UIImageView *sector07;
@property(nonatomic, retain)IBOutlet UIImageView *sector08;


@end

