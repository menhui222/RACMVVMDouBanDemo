# RACMVVMDouBanDemo
ReactiveCocoa + mvvm demo


#### 一.请求 &&解析
 * 请求是对AFNetworking的封装，WKNetwork这个类和WKNetwork+Request
 
 * 
          + (RACSignal *)POST:(NSString *)URLString
         parameters:(NSDictionary*)parameters;
          + (AFHTTPSessionManager *)POST:(NSString *)URLString
                        parameters:(NSDictionary*)parameters
                           success:(void (^)(id response))success
                           failure:(void (^)(NSError *error))failure;
                           
                           
                        
                        
                        
                        
                        
                        
                        
                        
  * RACSignal 的 RACDisposable里面销毁AFHTTPSessionManager 如果请求成功订阅者发送的JSON的字典 如果JSON错误即各种错误 发送ERROR 
  * 由于OC没有泛型的 所以我返回出去的是RACSignal ,Rxswift 应该是 返回Observable <AFHTTPSessionManager>   Observable 是协议的好处
  * 请求 RACSignal *requestSignal =  [WKNetwork GET:kAPIURLBookSearch parameters:params];
  
  * 接下来去是解析 我写了RACSignal+Parser这个类
     
        
        
		   解析一个对象
		 
		   @param modelClass 类名
		 
		   @return 信号
		
		- (RACSignal *)parsermodelClass:(Class)modelClass;
		
		   解析一个数组
		 
		   @param modelArray 类名
		 
		   @return 信号
		 
		- (RACSignal *)parsermodelArray:(Class)modelArray;
		
		
		由于这个解析我为了适应豆瓣的接口 里面方法就适应豆瓣的接口 不同接口JSON格式肯定有出路
		
		
		
		
* 解析的实现是map实现的  parsermodelClass 是对JOSN的解析成对象 返回出对象
parsermodelArray 返回出RACTuple的对象 2个元素 1.modelArray对象的数组  2. 分页的东西
*最后请求可以写成
    
        RACSignal *signal =  [[[[WKNetwork GET:kAPIURLBookSearch parameters:params] parsermodelArray:[Book class]] doNext:^(id x) {
                [MBProgressHUD showMessage:@"加载中..."];
            }] doCompleted:^{
                [MBProgressHUD hideHUD];
            }];
#### 二.对于MVVM 的demo 我看了很多 这个因为写的有点随意 没有提出 BaseVM BaseView  BaseVC 

但是在对于事件的处理 和逻辑 都在VM里面实现   我在纠结如果每个简单的VC也要去创建一个View  去处理界面有没有必要 
 这里我以 登陆举例 MVVM
  VC的代码
		
		
		// 监测输入框的变化
		   RAC(self.loginViewModel,userName) = _useNameTextField.rac_textSignal;
		   RAC(self.loginViewModel,password) =      _passwordTextField.rac_textSignal;
		   
    //处理输出框变化
    [self.loginViewModel.loginEnableSignal subscribeNext:^(NSNumber *x) {
        if ([x boolValue]) {
         
            _loginButton.backgroundColor = [UIColor colorFromHexCode:@"47c3ca"];
        }else{
           
           _loginButton.backgroundColor = [UIColor colorFromHexCode:@"e9e9e9"];
        }
    }];
    RAC(self.loginButton,enabled) = self.loginViewModel.loginEnableSignal;
    @weakify(self)
    // 按钮的事件处理
    [[_loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
       [self.loginViewModel.loginCommand execute:nil];
    }];
    
    
    // 登陆成功
    [[self.loginViewModel.loginSuccessSignal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        if ([x isEqualToNumber:@(YES)]) {
            UIViewController *vc = [[UIViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
    
    
    
    
    
    
   VM的代码
		
		- (instancetype)init
		{
		    self = [super init];
		    if (self) {
		        
		        [self bindEvent];
		       
		    }
		    return self;
		}
		- (void)bindEvent
		{
		    // 事件返回
		    
		    [self.loginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
		        
		        if ([x isKindOfClass:[UserDetail class]]) {
		            [WKUserManager shareManger].userDetail =  x;
		            NSLog(@"%@",x);
		            [self.loginSuccessSignal sendNext:@(YES)];
		        }else{
		            [self.loginSuccessSignal sendNext:@(NO)];
		            NSError *error = (NSError *)x;
		            //MBProgressHUD 内部有个BUG MBProgressHUD show  之前先将之前SHOW的先DISSMISS
		            //[MBProgressHUD showError:error.domain];
		        }
		        
		        
		        
		
		    }];
		    
		    // 监测事件的整个过程
		    [[[self.loginCommand executing] skip:1] subscribeNext:^(id x) {
		        if ([x isEqualToNumber:@(YES)]) {
		        
		            [MBProgressHUD showMessage:@"正在登录..."];
		            
		            
		        }else
		        {
		            [MBProgressHUD hideHUD];
		        }
		    }];
		
		}
		
		- (RACSignal *)loginEnableSignal{
		
		    if (!_loginEnableSignal)
		    {
		        _loginEnableSignal = [RACSignal combineLatest:@[RACObserve(self, userName),RACObserve(self, password)] reduce:^id(NSString * userName,NSString * password){
		            
		            return @(userName.length && password.length) ;
		            
		        }];
		    }
		    return _loginEnableSignal;
		}
		
		
		
		- (RACCommand *)loginCommand
		{
		    if (!_loginCommand) {
		       
		        _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
		        
		        NSMutableDictionary *params = [NSMutableDictionary dictionary];
		        
		            // 请求  解析
		        return [[WKNetwork POST:kAPIURLUserLogin parameters:params] parsermodelClass:[UserDetail class]];
		            /*
		          RACSignal *signal = [WKNetwork POST:kAPIURLUserLogin parameters:params];//请求
		          RACSignal *parserSignal =  [signal parsermodelClass:[UserDetail class]];//解析
		             */
		    
		    }];
		    }
		    return _loginCommand;
		}
		
		- (RACSubject *)loginSuccessSignal
		{
		    if (!_loginSuccessSignal)
		    {
		        _loginSuccessSignal = [RACSubject subject];
		        
		    }
		    return _loginSuccessSignal;
		}
		   


我最近看到[http://www.jianshu.com/p/3beb21d5def2](http://www.jianshu.com/p/3beb21d5def2)写的还不错




