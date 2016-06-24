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
#import "MJRefresh.h"
static NSString * const kBookCell = @"kWKBookTableViewCell";

@interface WKBookViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *tableView;
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
   
    [self.view addSubview:self.tableView];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    @weakify(self);
    self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self.bookViewModel startPage];
        [self.bookViewModel.requestCommad execute:nil];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self.bookViewModel pageDown];
        [self.bookViewModel.requestCommad execute:nil];
    }];
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
       
        _tableView = [[UITableView alloc] init];
        [_tableView registerNib:[UINib nibWithNibName:@"WKBookTableViewCell" bundle:nil] forCellReuseIdentifier:kBookCell];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;


}
- (void)mh_bindViewModel{
    @weakify(self);
    
   [self.bookViewModel.updateUISubject subscribeNext:^(NSNumber * x) {
       @strongify(self);
       
       [self.tableView reloadData];
      
       switch ([x integerValue]) {
           case WKHeaderRefresh_HasMoreData: {
               
               [self.tableView.mj_header endRefreshing];
               
               if (self.tableView.mj_footer == nil) {
                   
                   self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                       @strongify(self);
                       [self.bookViewModel pageDown];
                       [self.bookViewModel.requestCommad execute:nil];
                   }];
               }
           }
               break;
           case WKHeaderRefresh_HasNoMoreData: {
               
               [self.tableView.mj_header endRefreshing];
               self.tableView.mj_footer = nil;
           }
               break;
           case WKFooterRefresh_HasMoreData: {
               
               [self.tableView.mj_header endRefreshing];
               [self.tableView.mj_footer resetNoMoreData];
               [self.tableView.mj_footer endRefreshing];
           }
               break;
           case WKFooterRefresh_HasNoMoreData: {
               [self.tableView.mj_header endRefreshing];
               [self.tableView.mj_footer endRefreshingWithNoMoreData];
           }
               break;
           case WKRefreshError: {
               
               [self.tableView.mj_footer endRefreshing];
               [self.tableView.mj_header endRefreshing];
           }
               break;
               
           default:
               break;
       }

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
    RACDisposable *disposable = [[[cell.subscriberBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
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
