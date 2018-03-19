//
//  MyCell.m
//  Virtual Private Network
//
//  Created by mac on 2018/3/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MyCell.h"
#define leftmargin 12
#define cellheight 60
#define rightmargin 30
@implementation MyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.greenLineView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.rightImagView];
        [self addSubview:self.lineView];
    }
    return self;
}
- (UIView *)greenLineView{
    if (!_greenLineView) {
        _greenLineView=[[UIView alloc]initWithFrame:CGRectMake(25, (cellheight-4)/2,7,4)];
        _greenLineView.backgroundColor=[UIColor colorWithHexString:@"31cd40"];
        _greenLineView.layer.cornerRadius=2;
        _greenLineView.layer.masksToBounds=YES;
        
    }
    return _greenLineView;
}
- (CustomLabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(_greenLineView.frame.origin.x+_greenLineView.frame.size.width+7, (cellheight-15)/2, 150, 15) andTextColor:HOMETITLE_COLOR andSize:14];
        _titleLabel.textAlignment=NSTextAlignmentLeft;
    }
    return _titleLabel;
}
- (CustomLabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-rightmargin-100, (cellheight-15)/2, 100, 15) andTextColor:[UIColor colorWithHexString:@"999999"] andSize:14];
        _contentLabel.textAlignment=NSTextAlignmentRight;
    }
    return _contentLabel;
}

- (UIImageView *)rightImagView{
    if (!_rightImagView) {
        _rightImagView=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-rightmargin, (cellheight-15)/2, 8, 15)];
        _rightImagView.image=[UIImage imageNamed:@"前进"];
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
