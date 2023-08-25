//
//  ZYTitleTableViewCell.m
//  ZYKTDemo
//
//  Created by objcat on 2023/8/25.
//

#import "ZYTitleTableViewCell.h"

@interface ZYTitleTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@end

@implementation ZYTitleTableViewCell

- (void)setModel:(EHFormModel *)model {
    [super setModel:model];
    self.titleLabel.text = model.name;
    self.subTitleLabel.text = model.value;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.arrowImageView.image = [[UIImage imageNamed:@"EHFormResources.bundle/arrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.arrowImageView.tintColor = [UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
