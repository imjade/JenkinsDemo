//
//  TableViewCell.m
//  CAAnimationDemo
//
//  Created by Jade on 16/3/23.
//  Copyright © 2016年 Jade. All rights reserved.
//

#import "TableViewCell.h"
@interface TableViewCell()
@property (nonatomic,strong) UILabel *showLab;
@property (nonatomic,copy) NSString *showString;
@end

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUp];
    }
    return self;
}

/**
 *  setUp
 */
- (void)setUp
{
    
    [self.contentView addSubview:self.showLab];
    __weak UIView *superView = self.contentView;
    int padding = 10;
    [self.showLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.top.equalTo(superView).offset(padding);
        make.right.with.bottom.equalTo(superView).offset(-padding);
    }];
}



- (UILabel *)showLab
{
    
    if (!_showLab) {
        _showLab = [UILabel new];
        _showLab.font = [UIFont systemFontOfSize:20.f];
        _showLab.numberOfLines = 0;
    }
    return _showLab;
}

/**
 *  ReloadData
 */
- (void)reloadDataWithDataList:(NSString *)showString
{
    
    self.showString = showString;
    _showLab.text = self.showString;
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
