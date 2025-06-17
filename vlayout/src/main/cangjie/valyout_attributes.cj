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
    @Publish public var range: Array<Int64> = [] //可显示的条目，默认值为[0,数据源长度]
    @Publish public var layoutWidth: Float64 = 0.0 //容器宽度
    @Publish public var layoutHeight: Float64 = 0.0//容器高度
    @Publish public var aspectRatio: Int64 = 1 //容器纵横比
    @Publish public var bgColor: UInt32 = 0xffffff //Grid容器背景颜色，默认值为透明
    @Publish public var bgOpacity: Float64 = 0.0 //Grid容器背景颜色，默认值为透明
    @Publish public var layoutIndex: Int64 = 0 //设置当前在容器中显示的子组件的索引值，默认值为0
    @Publish public var layoutAutoPlay: Bool = false //子组件是否自动播放，自动播放状态下，导航点不可操作，默认值为false
    @Publish public var layoutInterval: Int64 = 1000 //使用自动播放时播放的时间间隔，单位为毫秒，默认值为1000
    @Publish public var layoutIndicator: Bool = false //是否启用导航点指示器，默认值为false
    @Publish public var layoutLoop: Bool = false //是否开启循环，默认值为false
    @Publish public var layoutDuration: Int64 = 400 //子组件切  换的动画时长，单位为毫秒，默认值为400
    @Publish public var layoutVertical: Bool = false //是否为纵向滑动，默认值为false
    @Publish public var layoutItemSpace: Int64 = 0 //设置子组件与子组件之间间隙，默认值为0
    @Publish public var layoutEffectMode: Int32 = 0 //滑动效果，默认值为None
    @Publish public var zIndex: Int64 = 0 //z序，默认值为0
    @Publish public var margin: Array<Float64> = [] //外边距，默认值为[]，优先级比单给外边距高
    @Publish public var topMargin: Float64 = 0.0 //上外边距，默认值为0
    @Publish public var rightMargin: Float64 = 0.0 //右外边距，默认值为0
    @Publish public var bottomMargin: Float64 = 0.0 //下外边距，默认值为0
    @Publish public var leftMargin: Float64 = 0.0 //左外边距，默认值为0
}

@Observed
public class layoutDataType {
    @Publish public var layoutText: String = ""
    @Publish public var colsSpan: Int64 = 0
    @Publish public var layoutColor: UInt32 = 0xFF0000
    @Publish public var layoutWeight: Int64 = 1
    @Publish public var textSize: Int64 = 25
    @Publish public var textColor: UInt32 = 0x999999
    @Publish public var bgColor: UInt32 = 0xCFCFCF
    @Publish public var top: Float64 = 0.0
    @Publish public var left: Float64 = 0.0
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
    @Publish public var range: Array<Int64> = [0, 0] //可显示的条目，默认值为[0,数据源长度]
    @Publish public var rowWeights: Array<Float64> = [] //行权重，默认值为[]，仅OnePlusNLayoutHelper、OnePlusNLayoutHelperEx支持
    @Publish public var colWeights: Array<Float64> = [] //列权重，默认值为[]
    @Publish public var hasHeader: Bool = false //第一个子项变成一行一列，默认值为false，仅OnePlusNLayoutHelper支持
    @Publish public var hasFooter: Bool = false //最后一个子项变成一行一列，默认值为false，仅OnePlusNLayoutHelper支持
    @Publish public var layoutWidth: Float64 = 0.0 //容器宽度
    @Publish public var layoutHeight: Float64 = 0.0 //容器高度
    @Publish public var aspectRatio: Float64 = 0.0 //容器纵横比
    @Publish public var bgColor: UInt32 = 0xffffff //Grid容器背景颜色，默认值为透明
    @Publish public var bgOpacity: Float64 = 0.0 //Grid容器背景颜色，默认值为透明
    @Publish public var zIndex: Int32 = 0 //z序，默认值为0
    @Publish public var padding: Array<Float64> = [] //内边距，默认值为[]，优先级比单给内边距高
    @Publish public var topPadding: Float64 = 0.0 //上内边距，默认值为0
    @Publish public var rightPadding: Float64 = 0.0 //右内边距，默认值为0
    @Publish public var bottomPadding: Float64 = 0.0 //下内边距，默认值为0
    @Publish public var leftPadding: Float64 = 0.0 //左内边距，默认值为0
    @Publish public var margin: Array<Float64> = [] //外边距，默认值为[]，优先级比单给外边距高
    @Publish public var topMargin: Float64 = 0.0 //上外边距，默认值为0
    @Publish public var rightMargin: Float64 = 0.0 //右外边距，默认值为0
    @Publish public var bottomMargin: Float64 = 0.0 //下外边距，默认值为0
    @Publish public var leftMargin: Float64 = 0.0 //左外边距，默认值为0
}

/*
 * LinearLayoutHelper
 * DefaultLayoutHelper
 */
@Observed
public class LinearAttributes {
    @Publish public var range: Array<Int64> = [0, 0] //可显示的条目，默认值为[0,数据源长度]
    @Publish public var dividerHeight: Int64 = 0 //列表项垂直间距，默认值为0
    @Publish public var layoutHeight: Float64 = 0.0 //容器高度
    @Publish public var aspectRatio: Float64 = 0.0 //ListItem的单行纵横比，默认值为0
    @Publish public var bgColor: UInt32 = 0xffffff //Grid容器背景颜色，默认值为透明
    @Publish public var bgOpacity: Float64 = 0.0 //Grid容器背景颜色，默认值为透明
    @Publish public var zIndex: Int32 = 0 //z序，默认值为0
    @Publish public var padding: Array<Float64> = [] //内边距，默认值为[]，优先级比单给内边距高
    @Publish public var topPadding: Float64 = 0.0 //上内边距，默认值为0
    @Publish public var rightPadding: Float64 = 0.0 //右内边距，默认值为0
    @Publish public var bottomPadding: Float64 = 0.0 //下内边距，默认值为0
    @Publish public var leftPadding: Float64 = 0.0 //左内边距，默认值为0
    @Publish public var margin: Array<Float64> = [] //外边距，默认值为[]，优先级比单给外边距高
    @Publish public var topMargin: Float64 = 0.0 //上外边距，默认值为0
    @Publish public var rightMargin: Float64 = 0.0 //右外边距，默认值为0
    @Publish public var bottomMargin: Float64 = 0.0 //下外边距，默认值为0
    @Publish public var leftMargin: Float64 = 0.0 //左外边距，默认值为0
}

/*
 * FixLayoutHelper
 * ScrollFixLayoutHelper
 * StickyLayoutHelper
 * FloatLayoutHelper
 */
@Observed
public class FixAreaAttributes {
    @Publish public var range: Array<Int64> = [0, 0] //可显示的条目，默认值为[0,数据源长度]
    @Publish public var layoutWidth: Float64 = 0.0 //容器宽度
    @Publish public var layoutHeight: Float64 = 0.0 //容器高度，当容器纵横比为0时有效
    @Publish public var aspectRatio: Float64 = 0.0 //容器纵横比
    @Publish public var bgColor: UInt32 = 0xffffff //Grid容器背景颜色，默认值为透明
    @Publish public var bgOpacity: Float64 = 0.0 //Grid容器背景颜色，默认值为透明
    @Publish public var xOffset: Float64 = 0.0 //水平偏移量，默认值为0，只有StickyLayoutHelper不支持
    @Publish public var yOffset: Float64 = 0.0 //竖直偏移量，默认值为0，只有StickyLayoutHelper不支持
    @Publish public var alignType: Int32 = -1 //固定的位置，只有StickyLayoutHelper不支持，优先级比单给xy高，FloatLayoutHelper中与defaultLocation进行累加
    @Publish public var sketchMeasure: Bool = false //宽度占满屏幕，只有FixLayoutHelper, ScrollFixLayoutHelper支持
    @Publish public var stickyStart: Bool = false //true：吸顶，false：吸底，只有StickyLayoutHelper支持
    @Publish public var defaultLocation: Array<Float64> = [] //默认位置，只有FloatLayoutHelper支持，优先级比单给xy高，与alignType进行累加
    @Publish public var zIndex: Int32 = 0 //z序，默认值为0
    @Publish public var padding: Array<Float64> = []  //内边距，默认值为[]，优先级比单给内边距高
    @Publish public var topPadding: Float64 = 0.0 //上内边距，默认值为0
    @Publish public var rightPadding: Float64 = 0.0 //右内边距，默认值为0
    @Publish public var bottomPadding: Float64 = 0.0 //下内边距，默认值为0
    @Publish public var leftPadding: Float64 = 0.0 //左内边距，默认值为0
    @Publish public var margin: Array<Float64> = [] //外边距，默认值为[]，优先级比单给外边距高
    @Publish public var topMargin: Float64 = 0.0 //上外边距，默认值为0
    @Publish public var rightMargin: Float64 = 0.0 //右外边距，默认值为0
    @Publish public var bottomMargin: Float64 = 0.0 //下外边距，默认值为0
    @Publish public var leftMargin: Float64 = 0.0 //左外边距，默认值为0
}

/*
 * GridLayoutHelper
 * RangeGridLayoutHelper
 */
@Observed
public class GridAttributes {
    @Publish public var range: Array<Int64> = [0, 0] //可显示的条目，默认值为[0,数据源长度]
    @Publish public var spanCount: Int64 = 0 //列数，默认值为0
    @Publish public var weights: Array<Float64> = [] //列占比集合：数组元素数值约分为占比，默认值为[100]
    @Publish public var autoExpand: Bool = true //余子项宽度自适应，当weights未定义时有效，且与colsSpan存在互斥关系，默认值为true
    @Publish public var aspectRatio: Float64 = 0.0 //GridItem的单行纵横比，默认值为0
    @Publish public var layoutHeight: Float64 = 0.0 //Grid容器高度
    @Publish public var bgColor: UInt32 = 0xffffff //Grid容器背景颜色，默认值为白色
    @Publish public var bgOpacity: Float64 = 0.0 //Grid容器背景颜色，默认值为透明
    @Publish public var zIndex: Int32 = 0 //z序，默认值为0
    @Publish public var gap: Int64 = 0 //行列间距，默认值为0
    @Publish public var vGap: Int64 = 0 //行与行的间距，默认值为0
    @Publish public var hGap: Int64 = 0 //列与列的间距，默认值为0
    @Publish public var padding: Array<Float64> = [] //内边距，默认值为[]，优先级比单给内边距高
    @Publish public var topPadding: Float64 = 0.0 //上内边距，默认值为0
    @Publish public var rightPadding: Float64 = 0.0 //右内边距，默认值为0
    @Publish public var bottomPadding: Float64 = 0.0 //下内边距，默认值为0
    @Publish public var leftPadding: Float64 = 0.0 //左内边距，默认值为0
    @Publish public var margin: Array<Float64> = [] //外边距，默认值为[]，优先级比单给外边距高
    @Publish public var topMargin: Float64 = 0.0 //上外边距，默认值为0
    @Publish public var rightMargin: Float64 = 0.0 //右外边距，默认值为0
    @Publish public var bottomMargin: Float64 = 0.0 //下外边距，默认值为0
    @Publish public var leftMargin: Float64 = 0.0 //左外边距，默认值为0
}

@Observed
public class StaggeredGridAttributes {
  /*
   * StaggeredGridLayoutHelper
   */
  @Publish public var range: Array<Int64> = [0, 0] //可显示的条目，默认值为[0,数据源长度]
  @Publish public var staggeredWidth: Float64 = 0.0
  @Publish public var lanes: Int64 = 1 //列数，默认值为1
  @Publish public var bgColor: UInt32 = 0xffffff //容器背景颜色，默认值为透明
  @Publish public var zIndex: Int32 = 0 //z序，默认值为0
  @Publish public var gap: Float64 = 0.0 //行列间距，默认值为0
  @Publish public var vGap: Float64 = 0.0 //行与行的间距，默认值为0
  @Publish public var hGap: Float64 = 0.0 //列与列的间距，默认值为0
  @Publish public var padding: Array<Float64> = [] //内边距，默认值为[]，优先级比单给内边距高
  @Publish public var topPadding: Float64 = 0.0 //上内边距，默认值为0
  @Publish public var rightPadding: Float64 = 0.0 //右内边距，默认值为0
  @Publish public var bottomPadding: Float64 = 0.0 //下内边距，默认值为0
  @Publish public var leftPadding: Float64 = 0.0 //左内边距，默认值为0
  @Publish public var margin: Array<Float64> = [] //外边距，默认值为[]，优先级比单给外边距高
  @Publish public var topMargin: Float64 = 0.0//上外边距，默认值为0
  @Publish public var rightMargin: Float64 = 0.0//右外边距，默认值为0
  @Publish public var bottomMargin: Float64 = 0.0 //下外边距，默认值为0
  @Publish public var leftMargin: Float64 = 0.0//左外边距，默认值为0
}

