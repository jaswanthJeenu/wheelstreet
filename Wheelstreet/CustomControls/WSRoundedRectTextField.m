//
//  WSRoundedRectTextField.m
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 24/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import "WSRoundedRectTextField.h"

@implementation WSRoundedRectTextField

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
//        [self.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
//        [self.layer setBorderWidth:2.0];
        
        self.layer.cornerRadius = self.frame.size.height/2.0;
        self.clipsToBounds = YES;
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(16.0f, 11.0f, 16.0f, 16.0f)];
        [imgView setImage:[UIImage imageNamed:@"search.png"]];
        [self addSubview:imgView];
    }
    
    return self;
}


// placeholder position
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 40, 8);
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 40, 8);
}

@end
