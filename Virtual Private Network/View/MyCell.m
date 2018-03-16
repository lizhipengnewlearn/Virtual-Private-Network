//
//  MyCell.m
//  Virtual Private Network
//
//  Created by mac on 2018/3/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MyCell.h"
#define leftmargin 12
#define cellheight 44
#define rightmargin 12
@implementation MyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.rightImagView];
        [self addSubview:self.lineView];
    }
    return self;
}

- (CustomLabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(leftmargin, (cellheight-15), 120, 15) andTextColor:HOMETITLE_COLOR andSize:14];
        _titleLabel.textAlignment=NSTextAlignmentLeft;
    }
    return _titleLabel;
}
- (CustomLabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-rightmargin, (cellheight-15)/2, 100, 15) andTextColor:HOMETITLE_COLOR andSize:14];
        _contentLabel.textAlignment=NSTextAlignmentRight;
    }
    return _contentLabel;
}

- (UIImageView *)rightImagView{
    if (!_rightImagView) {
        _rightImagView=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-rightmargin, (cellheight-15), 15, 15)];
        _rightImagView.image=[UIImage imageNamed:@""];
    }
    return _rightImagView;
}
- (UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc]initWithFrame:CGRectMake(leftmargin, cellheight-0.5, SCREEN_WIDTH-leftmargin*2, 0.5)];
        _lineView.backgroundColor=LINE_COLOR;
    }
    return _lineView;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
