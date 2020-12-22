<img src="https://github.com/Butters2334/SwiftUICode/blob/main/images/banner.png"/>

[![Build Status](https://img.shields.io/badge/platforms-iOS%20%7C%20tvOS%20%7C%20macOS%20%7C%20watchOS-green.svg)](https://github.com/butters2334/SwiftUICode)
[![Swift](https://img.shields.io/badge/Swift-5.1-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-11.0-blue.svg)](https://developer.apple.com/xcode)
[![Xcode](https://img.shields.io/badge/macOS-15.0-blue.svg)](https://developer.apple.com/macOS)
[![MIT](https://img.shields.io/badge/licenses-MIT-red.svg)](https://opensource.org/licenses/MIT)

- 尝试用SwiftUI来实现douyin.app
- 只使用SwiftUI1.0

## 💻 所需环境

- macOS 10.5.0
- Xcode 11.0
- iOS 13.0


## 📂 100小时计划：
    尝试使用100小时用SwiftUI看看能写出多少东西;  
    除去摸鱼时间,每天大概只剩下5小时左右是正常来写东西;
    100小时大概就是上班时间一个月左右有效产出时间;


#### 0-5小时  
    调查了github上关于douyin相关的仓库,发现现阶段已经不能爬取到数据了;  
    因为本项目是为了想知道SwiftUI在实际项目中会遇到问题,所以初期只实现UI部分,等到后期如果时间还充足再考虑网络部分;    
    编写一个简单的json文件来模拟网络调用;  
    因为找不到合适的方法,最后只能手动收集视频;
    利用了iOS的快捷指令获取无水印视频和python自动提取头图;
    视频文案和用户数据需要分享到网页后提取;
    
#### 5-8小时
    建立了和json文件对应的model文件,这和前端web项目不同,开发规范要求必须要有model文件;
    个人编写的Demo可以自由增加参数,实际项目中和后端人员可能会在某个参数上展开拉扯;
    抖音每个月甚至每周都在变动,参考模仿的是2020年年底的版本;
    关于标签,当前版本抖音上有多种标签,后续可能要变更字段;
    
#### 8-10小时
    用户视频列表开发中
    发现当用户视频过多的时候页面一定会卡顿,但是swiftUI1.0没有相关的代码;
    这里可以使用UIKit来转化,这里就暂时跳过了;
    视频列表完成,有两个基本问题:1,视频大图有上下黑边,所以固定了高度180来切掉;1,视频大图太亮太暗会影响观看人数的显示,所以加了阴影
    

## 📎 About

* 以上示例中所涉及代码，针对于SwiftUI1.0系统API,部分问题在SwiftUI2.0中已经被修复。
* 如果有遇到 SwiftUI 的其他痛点,请联系邮箱或提出[**Issue**](https://github.com/Butters2334/SwiftUICode/issues/new) !
* 如果本文示例内容有疏漏和错误之处，欢迎提 [**Issue**](https://github.com/Butters2334/SwiftUICode/issues/new) ！



## ✉️ Contacts

email : mahuajian@gmail.com


## 📄 License	

SwiftUI is released under the [MIT license](LICENSE). See LICENSE for details.

