# YYProject 基础工程
简介：这是一个基础工程，你可以直接下载使用。

# 谁使用它
任何iOS开发人员（工程语言是Objective-C）都可以使用它。

# YYProject包含了哪些第三方类库
* AFNetworking：网络请求专用库
* MJRefresh：上下拉刷新
* MBProgressHUD：界面信息提示
* SVProgressHUD：界面信息加载
* MJExtension：模式和字典相互转换
* SDWebImage：图片加载
* FLAnimatedImageView：gif图片加载
* RNCryptor：文件加密
* iRate：应用评分
* Reachability：实时监测当前的网络状态
* Masonry：代码层面的界面布局

# 怎么使用 
### db：
* YYConstants：包含了一些工程的全局静态常量。
* YYDataHandle：数据处理类。

### net：
* YYAPI：网址字符串都存放在这里。
* YYNetManage：继承于AFHTTPSessionManager，以YYProjectBaseUrl为基础网址，并配置了securityPolicy和acceptableContentTypes。
* YYCommunication：网络与控制器的沟通类，你可以使用定义好的方法进行请求，请求包含get和post，还有图片上传，或者你也可以取消请求。YYCommunicationDelegate包含了网络请求返回数据的回调。

### tools：
* NSData+YYData：base64数据处理。
* NSString+YYString：可以检测字符串是否为空、可以生成当前时间的字符串以及错误码的详细说明。
* UIImage+YYImage：这个工具类别中，你可以重构图片尺寸，可以单纯地修改图片颜色。
* UIView+YYView：处理视图边框。

### model：
* MJExtensionConfig：使用过MJExtension文件的都知道，这个文件是用于转换属性名称。
* YYTestData：测试的一个model，里面加入了NSCoding。

### YYBaseViewController：
* 使用时，每个类继承于这个基础类。

### ViewController：
* 每次创建新的视图控制器时，可以直接拷贝该文件中的代码到新的视图控制器中。

# 想要修改工程名？
* 双击YYProject.xcodeproj，进入工程中。可以看到最顶层的工程project名字是YYProject，点击YYProject为可编辑状态，改为你想要的名字，比如DDTest。刚改完会弹出“Rename project content items？”点击rename。再点击OK。这时可以看到最顶层的工程project名字换成了DDTest。
* 工程名称虽然换了，但是文件夹的名称还没换。关掉工程，我们进入该工程的文件夹目录，直接修改工程最顶层文件夹名称“YYProject-master”，改为“DDTest”，点击“YYProject.xcodeproj”改为“DDTest.xcodeproj”,改完之后，点击“DDTest.xcodeproj”进入工程。编译，运行，perfect！


