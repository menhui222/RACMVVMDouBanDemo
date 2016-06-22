//
//  WKBookViewViewController.m
//  RACDouBanMovie
//
//  Created by 孟辉 on 16/6/16.
//  Copyright © 2016年 孟辉. All rights reserved.
//

#import "WKBookViewController.h"
#import "WKBookViewModel.h"
#import "WKBookTableViewCell.h"
static NSString * const kBookCell = @"kWKBookTableViewCell";

@interface WKBookViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) WKBookViewModel *bookViewModel;

@end

@implementation WKBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self mh_addSubviews];
    [self mh_bindViewModel];
}
- (void)mh_addSubviews
{
    [self.tableView registerNib:[UINib nibWithNibName:@"WKBookTableViewCell" bundle:nil] forCellReuseIdentifier:kBookCell];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)mh_bindViewModel{

   [self.bookViewModel.updateUISubject subscribeNext:^(id x) {
       [self.tableView reloadData];
   }];
    [self.bookViewModel.requestCommad execute:nil];
    
}
- (WKBookViewModel *)bookViewModel
{

    if (!_bookViewModel)
    {
        _bookViewModel = [[WKBookViewModel alloc] init];
        
    }
    return _bookViewModel;
}

//
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.bookViewModel.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Book *book = self.bookViewModel.dataArray[indexPath.row];
    
  
    WKBookTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kBookCell forIndexPath:indexPath];
    [cell setModel:book];
    @weakify(self)
    RACDisposable *disposable= [[[cell.subscriberBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
         @strongify(self)
         
        [self.bookViewModel.subscriberComand execute:RACTuplePack(@(indexPath.row),@(cell.subscriberBtn.selected))];
     }];
    
    
   
   
    RAC(cell,subscriberBtn.selected) = [RACObserve(book, isLocal) takeUntil:cell.rac_prepareForReuseSignal] ;
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
