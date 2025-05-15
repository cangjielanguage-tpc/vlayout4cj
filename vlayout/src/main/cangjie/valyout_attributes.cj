/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package vlayout4cj

import ohos.state_macro_manage.Observed
import ohos.state_macro_manage.Publish

/*
 * BannerLayoutHelper
 */
@Observed
public class BannerAttributes {
    @Publish var range: Array<Int64> = [] //可显示的条目，默认值为[0,数据源长度]
    @Publish var layoutWidth: Float64 = 0.0 //容器宽度
    @Publish var layoutHeight: Float64 = 0.0//容器高度
    @Publish var aspectRatio: Int64 = 1 //容器纵横比
    @Publish var bgColor: UInt32 = 0xffffff //Grid容器背景颜色，默认值为透明
    @Publish var bgOpacity: Float64 = 0.0 //Grid容器背景颜色，默认值为透明
    @Publish var layoutIndex: Int64 = 0 //设置当前在容器中显示的子组件的索引值，默认值为0
    @Publish var layoutAutoPlay: Bool = false //子组件是否自动播放，自动播放状态下，导航点不可操作，默认值为false
    @Publish var layoutInterval: Int64 = 1000 //使用自动播放时播放的时间间隔，单位为毫秒，默认值为1000
    @Publish var layoutIndicator: Bool = false //是否启用导航点指示器，默认值为false
    @Publish var layoutLoop: Bool = false //是否开启循环，默认值为false
    @Publish var layoutDuration: Int64 = 400 //子组件切  换的动画时长，单位为毫秒，默认值为400
    @Publish var layoutVertical: Bool = false //是否为纵向滑动，默认值为false
    @Publish var layoutItemSpace: Int64 = 0 //设置子组件与子组件之间间隙，默认值为0
    @Publish var layoutEffectMode: Int32 = 0 //滑动效果，默认值为None
    @Publish var zIndex: Int64 = 0 //z序，默认值为0
    @Publish var margin: Array<Float64> = [] //外边距，默认值为[]，优先级比单给外边距高
    @Publish var topMargin: Float64 = 0.0 //上外边距，默认值为0
    @Publish var rightMargin: Float64 = 0.0 //右外边距，默认值为0
    @Publish var bottomMargin: Float64 = 0.0 //下外边距，默认值为0
    @Publish var leftMargin: Float64 = 0.0 //左外边距，默认值为0
}

@Observed
public class layoutDataType {
    @Publish public  var layoutText: String = ""
    @Publish public var colsSpan: Int64 = 0
    @Publish public var layoutColor: UInt32 = 0xFF0000
    @Publish public var layoutWeight: Int64 = 1
    @Publish public var textSize: Int64 = 25
    @Publish public var textColor: UInt32 = 0x999999
    @Publish public var bgColor: UInt32 = 0xCFCFCF
    @Publish public var top: Int64 = 0
    @Publish public var lef: Int64 = 0
    @Publish public var tag: String = ""
}

/*
 * SingleLayoutHelper
 * ColumnLayoutHelper
 * OnePlusNLayoutHelper
 * OnePlusNLayoutHelperEx
 */
@Observed
public class AbstractFullFillAttributes {
    @Publish var range: Array<Int64> = [0, 0] //可显示的条目，默认值为[0,数据源长度]
    @Publish var rowWeights: Array<Float64> = [] //行权重，默认值为[]，仅OnePlusNLayoutHelper、OnePlusNLayoutHelperEx支持
    @Publish var colWeights: Array<Float64> = [] //列权重，默认值为[]
    @Publish var hasHeader: Bool = false //第一个子项变成一行一列，默认值为false，仅OnePlusNLayoutHelper支持
    @Publish var hasFooter: Bool = false //最后一个子项变成一行一列，默认值为false，仅OnePlusNLayoutHelper支持
    @Publish var layoutWidth: Float64 = 0.0 //容器宽度
    @Publish var layoutHeight: Float64 = 0.0 //容器高度
    @Publish var aspectRatio: Float64 = 1.0 //容器纵横比
    @Publish var bgColor: UInt32 = 0xffffff //Grid容器背景颜色，默认值为透明
    @Publish var bgOpacity: Float64 = 0.0 //Grid容器背景颜色，默认值为透明
    @Publish var zIndex: Int32 = 0 //z序，默认值为0
    @Publish var padding: Array<Float64> = [] //内边距，默认值为[]，优先级比单给内边距高
    @Publish var topPadding: Float64 = 0.0 //上内边距，默认值为0
    @Publish var rightPadding: Float64 = 0.0 //右内边距，默认值为0
    @Publish var bottomPadding: Float64 = 0.0 //下内边距，默认值为0
    @Publish var leftPadding: Float64 = 0.0 //左内边距，默认值为0
    @Publish var margin: Array<Float64> = [] //外边距，默认值为[]，优先级比单给外边距高
    @Publish var topMargin: Float64 = 0.0 //上外边距，默认值为0
    @Publish var rightMargin: Float64 = 0.0 //右外边距，默认值为0
    @Publish var bottomMargin: Float64 = 0.0 //下外边距，默认值为0
    @Publish var leftMargin: Float64 = 0.0 //左外边距，默认值为0
}

/*
 * LinearLayoutHelper
 * DefaultLayoutHelper
 */
@Observed
public class LinearAttributes {
    @Publish var range: Array<Int64> = [0, 0] //可显示的条目，默认值为[0,数据源长度]
    @Publish var dividerHeight: Int64 = 0 //列表项垂直间距，默认值为0
    @Publish var layoutHeight: Float64 = 0.0 //容器高度
    @Publish var aspectRatio: Float64 = 0.0 //ListItem的单行纵横比，默认值为0
    @Publish var bgColor: UInt32 = 0xffffff //Grid容器背景颜色，默认值为透明
    @Publish var bgOpacity: Float64 = 0.0 //Grid容器背景颜色，默认值为透明
    @Publish var zIndex: Int32 = 0 //z序，默认值为0
    @Publish var padding: Array<Float64> = [] //内边距，默认值为[]，优先级比单给内边距高
    @Publish var topPadding: Float64 = 0.0 //上内边距，默认值为0
    @Publish var rightPadding: Float64 = 0.0 //右内边距，默认值为0
    @Publish var bottomPadding: Float64 = 0.0 //下内边距，默认值为0
    @Publish var leftPadding: Float64 = 0.0 //左内边距，默认值为0
    @Publish var margin: Array<Float64> = [] //外边距，默认值为[]，优先级比单给外边距高
    @Publish var topMargin: Float64 = 0.0 //上外边距，默认值为0
    @Publish var rightMargin: Float64 = 0.0 //右外边距，默认值为0
    @Publish var bottomMargin: Float64 = 0.0 //下外边距，默认值为0
    @Publish var leftMargin: Float64 = 0.0 //左外边距，默认值为0
}