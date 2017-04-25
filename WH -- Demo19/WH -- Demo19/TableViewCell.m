
//
//  TableViewCell.m
//  WH -- Demo19
//
//  Created by QIUGUI on 2017/4/24.
//  Copyright © 2017年 QIUGUI. All rights reserved.
//

#import "TableViewCell.h"
#import "WineModel.h"
@interface TableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *seleocted;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *modey;
@property (weak, nonatomic) IBOutlet UIButton *add;
@property (weak, nonatomic) IBOutlet UILabel *count;
@property (weak, nonatomic) IBOutlet UIButton *deleoc;

@end
@implementation TableViewCell


- (void)setMod:(WineModel *)mod{
    
    _mod = mod;
    
    self.seleocted.selected = mod.seleoctedShop;
    self.icon.image = [UIImage imageNamed:mod.image];
    self.name.text = mod.name;
    self.modey.text = mod.money;
    self.count.text = [NSString stringWithFormat:@"%d",mod.shopCount];
    
    
    
}
// add
- (IBAction)clikeAdd:(UIButton *)sender {
    
    NSLog(@"加--");
    
    if(self.seleocted.selected){
        
        self.deleoc.enabled = YES;
        int  count = self.count.text.intValue;
        count ++;
        self.count.text = [NSString stringWithFormat:@"%d",count];
        self.mod.shopCount = count;
        
        if([self.delegate respondsToSelector:@selector(TableViewCellWithClikeAddCell:)]){
            
            [self.delegate TableViewCellWithClikeAddCell:self];
        }

    }else{
        
        NSLog(@"请先选中在进行下一步....");
    }
       
    
}
//dleoc
- (IBAction)clikeDeleoc:(UIButton *)sender {
    
    if(self.seleocted.selected){
        
        int  count = self.count.text.intValue;
        count --;
        self.count.text = [NSString stringWithFormat:@"%d",count];
        self.mod.shopCount = count;

        if(count == 0){
            
            sender.enabled = NO;
        }
        NSLog(@"减--");
        if([self.delegate respondsToSelector:@selector(TableViewCellWithClikeDeleocCell:)]){
            
            [self.delegate TableViewCellWithClikeDeleocCell:self];
        }

    }else{
        
           NSLog(@"请先选中在进行下一步....");
    }
}
//seleoc
- (IBAction)clikeSeleoc:(UIButton *)sender {
    
    NSLog(@"选中--");
    self.mod.seleoctedShop = !sender.selected;
    sender.selected = ! sender.selected;
    if([self.delegate respondsToSelector:@selector(TableViewCellWithClikeSeleocCell:)]){
        
        [self.delegate TableViewCellWithClikeSeleocCell:self];
    }
    
    
    
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
