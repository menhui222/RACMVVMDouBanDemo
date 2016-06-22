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
     
        
        /**
		 *  解析一个对象
		 *
		 *  @param modelClass 类名
		 *
		 *  @return 信号
		 */
		- (RACSignal *)parsermodelClass:(Class)modelClass;
		/**
		 *  解析一个数组
		 *
		 *  @param modelArray 类名
		 *
		 *  @return 信号
		 */
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
#### 二.对于MVVM 的demo 我看了很多 这个因为写的有点随意 BaseVM BaseView  BaseVC    我最近看到[http://www.jianshu.com/p/3beb21d5def2](http://www.jianshu.com/p/3beb21d5def2)写的还不错
