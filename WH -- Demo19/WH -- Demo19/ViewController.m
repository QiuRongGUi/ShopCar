//
//  ViewController.m
//  WH -- Demo19
//
//  Created by QIUGUI on 2017/4/10.
//  Copyright © 2017年 QIUGUI. All rights reserved.
//
#import "WineModel.h"
#import "ViewController.h"
#import "MJExtension.h"
#import "TableViewCell.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,TableViewCellDelegate>{
    
    int allprice ;
}

/** <#class#>*/
@property(nonatomic,strong) NSMutableArray *data;
@property (weak, nonatomic) IBOutlet UITableView *table;

@property (weak, nonatomic) IBOutlet UIButton *JSBut;
@property (weak, nonatomic) IBOutlet UIButton *seleocMain;
@property (weak, nonatomic) IBOutlet UILabel *moneyMain;
/** <#class#>*/
@property(nonatomic,strong) NSMutableArray *shopCar;
/** <#class#>*/
//@property(nonatomic,strong) NSMutableArray *changeCount;

@end

@implementation ViewController

- (NSMutableArray *)data
{
    if(!_data)
    {
        _data = [NSMutableArray array];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"wine.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            WineModel *mod = [WineModel mj_objectWithKeyValues:obj];
            mod.shopCount = 1;
            mod.seleoctedShop = NO;
            [_data addObject:mod];
        }];
        
    }
    return _data;
}

- (NSMutableArray *)shopCar
{
    if(!_shopCar)
    {
        _shopCar = [NSMutableArray array];
        
    }
    return _shopCar;
}

//- (NSMutableArray *)changeCount
//{
//    if(!_changeCount)
//    {
//        _changeCount = [NSMutableArray array];
//        
//    }
//    return _changeCount;
//}
//

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(editing:)];

}
- (void)editing:(UIBarButtonItem *)sends{
    
    
    sends.title = self.table.editing? @"设置":@"完成";
    [self.table setEditing:!self.table.isEditing animated:YES];
    
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(editingStyle == UITableViewCellEditingStyleDelete){
        
       
//        [self.table deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.data removeObjectAtIndex:indexPath.section];
        NSIndexSet  *set = [[NSIndexSet alloc] initWithIndex:indexPath.section]; 
        [self.table deleteSections:set withRowAnimation:UITableViewRowAnimationFade];
    }
}
//结算
- (IBAction)clikeJS:(UIButton *)sender {
    
}

//全选
- (IBAction)clikeMainSleocted:(UIButton *)sender {
    
    allprice = 0;
     __weak typeof(self) weakSelf = self;
    
    [self.data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        WineModel *mod = obj;
        mod.seleoctedShop = !sender.selected;

        
        if(mod.seleoctedShop == NO){
            
            self.moneyMain.text = @"0";
        }else{
            
            int  total = mod.money.intValue * mod.shopCount;
            allprice = allprice + total;
            weakSelf.moneyMain.text = [NSString stringWithFormat:@"%d",allprice];
            
        }
        
         
    }];
    
    [self.table reloadData];

    sender.selected = ! sender.selected;

}
//加
- (void)TableViewCellWithClikeAddCell:(TableViewCell *)cell{
    
    int main = self.moneyMain.text.intValue + cell.mod.money.intValue;
    self.moneyMain.text = [NSString stringWithFormat:@"%d",main];
    if(![self.shopCar containsObject:cell.mod]){
        
        [self.shopCar addObject:cell.mod];
    }
    
}
//减
- (void)TableViewCellWithClikeDeleocCell:(TableViewCell *)cell{
    
    int main = self.moneyMain.text.intValue - cell.mod.money.intValue;
    self.moneyMain.text = [NSString stringWithFormat:@"%d",main];
    if(cell.mod.shopCount == 0){
        
        [self.shopCar removeObject:cell.mod];
    }
}
//选中
- (void)TableViewCellWithClikeSeleocCell:(TableViewCell *)cell{
    
    if(cell.mod.seleoctedShop){
        
        int total =  self.moneyMain.text.intValue + cell.mod.money.intValue * cell.mod.shopCount;
        self.moneyMain.text = [NSString stringWithFormat:@"%d",total];
        
    }else{
        
        int total =  self.moneyMain.text.intValue -   cell.mod.money.intValue * cell.mod.shopCount;
        self.moneyMain.text = [NSString stringWithFormat:@"%d",total];

    }
    
    
    if(self.shopCar.count == self.data.count){
        
        self.seleocMain.selected = YES;
    }else{
        self.seleocMain.selected = NO;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.data.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Cell = @"Cell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    
    if(!cell)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"TableViewCell" owner:self options:nil]firstObject];
    }
    
    cell.delegate = self;
    cell.mod = self.data[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
