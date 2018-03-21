//
//  ItemsButton.m
//  liangzi
//
//  Created by xjh on 2018/3/5.
//  Copyright © 2018年 云夸克. All rights reserved.
//

#import "ItemsButton.h"

@implementation ItemsButton

-(instancetype)initWithFrame:(CGRect)frame withFirstTitle:(NSString *)firstTitle withSecTitle:(NSString *)secTitle
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = HOMEGREEN_COLOR;
        
        CGSize firstSize = [NSString sizeWithFont:[UIFont systemFontOfSize:20] maxSize:CGSizeMake(MAXFLOAT, frame.size.height) string:firstTitle];
        UILabel *firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 0, firstSize.width, frame.size.height)];
        firstLabel.font = [UIFont systemFontOfSize:20];
        firstLabel.text = firstTitle;
        firstLabel.textColor = [UIColor whiteColor];
        [self addSubview:firstLabel];
        self.layer.cornerRadius=27;
        self.layer.masksToBounds=YES;
        
        CGSize secSize = [NSString sizeWithFont:[UIFont systemFontOfSize:20] maxSize:CGSizeMake(MAXFLOAT, frame.size.height) string:secTitle];
        UILabel *secLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width-17-secSize.width, 0, secSize.width, frame.size.height)];
        secLabel.font = [UIFont systemFontOfSize:20];
        secLabel.text = secTitle;
        secLabel.textColor = [UIColor whiteColor];
        [self addSubview:secLabel];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
