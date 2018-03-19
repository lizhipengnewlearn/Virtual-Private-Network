//
//  RoutLineCell.m
//  Virtual Private Network
//
//  Created by mac on 2018/3/17.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RoutLineCell.h"

@implementation RoutLineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.headImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.descLabel];
        [self addSubview:self.lineView];
    }
    return self;
}

- (UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, (60-35)/2, 35, 35)];
    }
    return _headImageView;
}
-(CustomLabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(_headImageView.frame.size.width+_headImageView.frame.origin.x+10, 0, 70, 60) andTextColor:HOMETITLE_COLOR andSize:15];
    }
    return _titleLabel;
}
- (CustomLabel *)descLabel{
    if (!_descLabel) {
        _descLabel=[[CustomLabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-14-150, 0, 150, 60) andTextColor:COLOR(72, 200, 90) andSize:13];
        _descLabel.textAlignment=NSTextAlignmentRight;
    }
    return _descLabel;
}
- (UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 59.5, SCREEN_WIDTH, 0.5)];
        _lineView.backgroundColor=LINE_COLOR;
    }
    return _lineView;
}
- (void)setcontentWithModel:(RouteLine *)routLineModel{
    if(routLineModel.countryImageFile.url)
    {
        [_headImageView setImageWithURL:[NSURL URLWithString:routLineModel.countryImageFile.url] options:YYWebImageOptionSetImageWithFadeAnimation];

    }
    if(routLineModel.countryName)
    {
        _titleLabel.text=routLineModel.countryName;
    }
    if(routLineModel.desc)
    {
        _descLabel.text=routLineModel.desc;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
