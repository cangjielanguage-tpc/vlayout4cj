# vlayout4cj 特性文档

## 介绍

vlayout4cj 能够处理列表、网格和其它布局在同一个视图的复杂情况，使用者可以使用已设定好的容器布局组件，也可以在此基础上自定义容器布局组件。

## 1 BANNER_LAYOUT 滑动容器布局组件

### 1.1 滑动容器布局组件 BannerLayout

```cangjie
@Component
public class BannerLayout {
    /*
     * 布局
     * 参数 layoutDataType - 数据
     * 参数 Int64 - 位置索引
     *
     * 返回值 Unit
     */
    @BuilderParam var vLayoutContent: (layoutDataType, Int64) -> Unit  
    //数据源
    var vLayoutData: Array<layoutDataType> 
    //属性
    @State var vLayoutAttribute: BannerAttributes 
}

//数据源类
@Observed
public class layoutDataType {
    //数据内容
    @Publish public var layoutText: String = ""  
    //列间距，取值大于等于0
    @Publish public var colsSpan: Int64 = 0      
    //颜色
    @Publish public var layoutColor: UInt32 = 0xFF0000 
    //权重，取值大于等于0
    @Publish public var layoutWeight: Int64 = 1 
    //字体大小
    @Publish public var textSize: Int64 = 25   
    //字体颜色
    @Publish public var textColor: UInt32 = 0x999999  
    //背景颜色
    @Publish public var bgColor: UInt32 = 0xCFCFCF  
    //距顶端偏移
    @Publish public var top: Float64 = 0.0    
    //距左边偏移
    @Publish public var left: Float64 = 0.0 
    //其他
    @Publish public var tag: String = ""  
}
```
### 1.2 滑动容器布局组件属性 BannerAttributes

```cangjie
@Observed
public class BannerAttributes {
    /*
     * 可显示的条目，默认 [0,0]显示全部条目。
     * 注意：数组长度为 2，并且数组元素内第一项大于等于 0 ，第二项大于第一项。
     */
    @Publish public var range: Array<Int64> = []
    //容器宽度。
    @Publish public var layoutWidth: Length = 0.0.vp 
    //容器高度。
    @Publish public var layoutHeight: Length = 0.0.vp 
    //容器背景颜色。
    @Publish public var bgColor: UInt32 = 0xffffff 
    //容器背景颜色。
    @Publish public var bgOpacity: Float64 = 1.0 
    //设置当前在容器中显示的子组件的索引值，默认值为 0。
    @Publish public var layoutIndex: UInt32 = 0 
    //子组件是否自动播放，自动播放状态下，导航点不可操作，默认值为 false。
    @Publish public var layoutAutoPlay: Bool = false 
    //使用自动播放时播放的时间间隔，单位为毫秒，默认值为 1000。
    @Publish public var layoutInterval: UInt32 = 1000 
    //是否启用导航点指示器，默认值为 false。
    @Publish public var layoutIndicator: Bool = false 
    //是否开启循环，默认值为 false。
    @Publish public var layoutLoop: Bool = false 
    //子组件切换的动画时长，单位为毫秒，默认值为 400。
    @Publish public var layoutDuration: UInt32 = 400 
    //是否为纵向滑动，默认值为 false。
    @Publish public var layoutVertical: Bool = false 
    //设置子组件与子组件之间间隙，默认值为 0。
    @Publish public var layoutItemSpace: Int64 = 0 
    //滑动效果，默认值为 None。
    @Publish public var layoutEffectMode: Int32 = 0 
    //组件的Z序，指明了该组件在堆叠组件中的位置，默认值为 0。
    @Publish public var zIndex: Int32 = 0 
    //外边距，默认值为[]，长度固定为 4，设置其他无效，优先级比单给边距高。
    @Publish public var margin: Array<Float64> = [] 
    //上外边距，默认值为 0.0。
    @Publish public var topMargin: Float64 = 0.0 
    //右外边距，默认值为 0.0。
    @Publish public var rightMargin: Float64 = 0.0 
    //下外边距，默认值为 0.0。
    @Publish public var bottomMargin: Float64 = 0.0 
    //左外边距，默认值为 0.0。
    @Publish public var leftMargin: Float64 = 0.0 
}
```

## 2 COLUMN_LAYOUT 栏格容器布局组件

### 2.1 栏格容器布局组件 ColumnLayout

```cangjie
@Component
public class ColumnLayout {
    /*
     * 布局
     * 参数 layoutDataType - 数据
     * 参数 Int64 - 位置索引
     * 参数 Float64 - 组件高度
     *
     * 返回值 Unit
     */
    @BuilderParam var vLayoutContent: (layoutDataType, Int64, Float64) -> Unit  //布局
    //数据源
    var vLayoutData: Array<layoutDataType> 
    //属性
    @State var vLayoutAttribute: AbstractFullFillAttributes 
}
```
### 2.2 栏格容器布局组件 AbstractFullFillAttributes

```cangjie
@Observed
public class AbstractFullFillAttributes {
    /*
     * 可显示的条目，默认 [0,0]显示全部条目。
     * 注意：数组长度为 2，并且数组元素内第一项大于等于 0 ，第二项大于第一项。
     */
    @Publish public var range: Array<Int64>
    //列权重，默认值为[]时表示条目所占比例相同，取值大于等于0.0。
    @Publish public var colWeights: Array<Float64> = [] 
    //容器宽度。
    @Publish public var layoutWidth: Length = 0.0.vp 
    //容器高度。
    @Publish public var layoutHeight: Length = 0.0.vp 
    //容器背景颜色。
    @Publish public var bgColor: UInt32 = 0xffffff 
    //容器背景颜色。
    @Publish public var bgOpacity: Float64 = 1.0 
    //组件的Z序，指明了该组件在堆叠组件中的位置，默认值为 0。
    @Publish public var zIndex: Int32 = 0
    //内边距，默认值为[]，长度设置为 4，优先级比单给内边距高，设置其他无效。
    @Publish public var padding: Array<Float64> = [] 
    //上内边距，默认值为 0.0。
    @Publish public var topPadding: Float64 = 0.0 
    //右内边距，默认值为 0.0。
    @Publish public var rightPadding: Float64 = 0.0 
    //下内边距，默认值为 0.0。
    @Publish public var bottomPadding: Float64 = 0.0 
    //左内边距，默认值为 0.0。
    @Publish public var leftPadding: Float64 = 0.0 
    //外边距，默认值为[]，长度固定为 4，设置其他无效，优先级比单给边距高。
    @Publish public var margin: Array<Float64> = [] 
    //上外边距，默认值为 0.0。
    @Publish public var topMargin: Float64 = 0.0 
    //右外边距，默认值为 0.0。
    @Publish public var rightMargin: Float64 = 0.0 
    //下外边距，默认值为 0.0。
    @Publish public var bottomMargin: Float64 = 0.0 
    //左外边距，默认值为 0.0。
    @Publish public var leftMargin: Float64 = 0.0 
}
```

## 3 DEFAULT_LAYOUT 默认容器布局组件

### 3.1 默认容器布局组件 DefaultLayout

```cangjie
@Component
public class DefaultLayout {
    /*
     * 布局
     * 参数 layoutDataType - 数据。
     * 参数 Int64 - 位置索引。
     * 参数 Float64 - 组件高度。
     *
     * 返回值 Unit
     */
    @BuilderParam var vLayoutContent: (layoutDataType, Int64, Float64) -> Unit
    //数据源
    var vLayoutData: Array<layoutDataType> 
    //属性
    @State var vLayoutAttribute: LinearAttributes 
}
```
### 3.2 默认容器布局组件 LinearAttributes

```cangjie
@Observed
public class LinearAttributes {
    /*
     * 可显示的条目，默认 [0,0]显示全部条目。
     * 注意：数组长度为 2，并且数组元素内第一项大于等于 0 ，第二项大于第一项。
     */
    @Publish public var range: Array<Int64> = [0, 0]
    //列表项垂直间距，默认值为0。
    @Publish public var dividerHeight: Int64 = 0 
    //容器高度。
    @Publish public var layoutHeight: Length = 0.0.vp 
    //容器宽度。
    @Publish public var layoutWidth: Length = 0.0.vp 
    //容器背景颜色。
    @Publish public var bgColor: UInt32 = 0xffffff 
    //容器背景颜色。
    @Publish public var bgOpacity: Float64 = 1.0 
    //组件的Z序，指明了该组件在堆叠组件中的位置，默认值为 0。
    @Publish public var zIndex: Int32 = 0
    //内边距，默认值为[]，长度设置为 4，优先级比单给内边距高，设置其他无效。
    @Publish public var padding: Array<Float64> = [] 
    //上内边距，默认值为 0.0。
    @Publish public var topPadding: Float64 = 0.0 
    //右内边距，默认值为 0.0。
    @Publish public var rightPadding: Float64 = 0.0 
    //下内边距，默认值为 0.0。
    @Publish public var bottomPadding: Float64 = 0.0 
    //左内边距，默认值为 0.0。
    @Publish public var leftPadding: Float64 = 0.0 
    //外边距，默认值为[]，长度固定为 4，设置其他无效，优先级比单给边距高。
    @Publish public var margin: Array<Float64> = [] 
    //上外边距，默认值为 0.0。
    @Publish public var topMargin: Float64 = 0.0 
    //右外边距，默认值为 0.0。
    @Publish public var rightMargin: Float64 = 0.0 
    //下外边距，默认值为 0.0。
    @Publish public var bottomMargin: Float64 = 0.0 
    //左外边距，默认值为 0.0。
    @Publish public var leftMargin: Float64 = 0.0
}
```

## 4 FIX_LAYOUT 固定容器布局组件

### 4.1 固定容器布局组件 FixLayout

```cangjie
@Component
public class FixLayout {
    /*
     * 布局
     * 参数 layoutDataType - 数据。
     * 参数 Int64 - 位置索引。
     *
     * 返回值 Unit
     */
    @BuilderParam var vLayoutContent: (layoutDataType, Int64) -> Unit
    //数据源。
    var vLayoutData: Array<layoutDataType> 
    //属性。
    @State var vLayoutAttribute: FixAreaAttributes 
}
```
### 4.2 固定容器布局组件 FixAreaAttributes

```cangjie
@Observed
public class FixAreaAttributes {
    /*
     * 可显示的条目，默认 [0,0]显示全部条目。
     * 注意：数组长度为 2，并且数组元素内第一项大于等于 0 ，第二项大于第一项。
     */
    @Publish public var range: Array<Int64> = [0, 0]
    /*
     * layoutWidth <= 0.0 && layoutHeight <= 0.0 && aspectRatio <= 0.0  =====> 默认 layoutHeights = 100.0 aspectRatios = 1.0
     * layoutWidth > 0.0 && layoutHeight <= 0.0 && aspectRatio <= 0.0   =====> 默认 layoutHeights = 100.0 aspectRatios = layoutWidth / layoutHeight
     * layoutWidth <= 0.0 && layoutHeight > 0.0 && aspectRatio <= 0.0   =====> 默认 aspectRatios = 1.0 layoutWidth = layoutHeight * aspectRatios
     * layoutWidth <= 0.0 && layoutHeight <= 0.0 && aspectRatio > 0.0   =====> 默认 layoutHeights = 100.0 layoutWidth = layoutHeight * aspectRatios
     * 其余 aspectRatios = layoutWidths / layoutHeights
     */
    @Publish public var layoutWidth: Float64 = 0.0 
    //容器高度，取值大于等于0，当容器纵横比为0时有效。
    @Publish public var layoutHeight: Float64 = 0.0 
    //容器纵横比，取值大于等于0，。
    @Publish public var aspectRatio: Float64 = 0.0 
    //容器背景颜色。
    @Publish public var bgColor: UInt32 = 0xffffff 
    //容器背景颜色。
    @Publish public var bgOpacity: Float64 = 1.0 
    //水平偏移量，默认值为0.0。
    @Publish public var xOffset: Float64 = 0.0 
    //竖直偏移量，默认值为0.0。
    @Publish public var yOffset: Float64 = 0.0 
    //固定的位置，优先级比单给xy高。
    @Publish public var alignType: Int32 = -1 
    //宽度占满屏幕。
    @Publish public var sketchMeasure: Bool = false 
    //容器背景颜色。
    @Publish public var bgColor: UInt32 = 0xffffff 
    //容器背景颜色。
    @Publish public var bgOpacity: Float64 = 1.0 
    //组件的Z序，指明了该组件在堆叠组件中的位置，默认值为 0。
    @Publish public var zIndex: Int32 = 0
    //内边距，默认值为[]，长度设置为 4，优先级比单给内边距高，设置其他无效。
    @Publish public var padding: Array<Float64> = [] 
    //上内边距，默认值为 0.0。
    @Publish public var topPadding: Float64 = 0.0 
    //右内边距，默认值为 0.0。
    @Publish public var rightPadding: Float64 = 0.0 
    //下内边距，默认值为 0.0。
    @Publish public var bottomPadding: Float64 = 0.0 
    //左内边距，默认值为 0.0。
    @Publish public var leftPadding: Float64 = 0.0 
    //外边距，默认值为[]，长度固定为 4，设置其他无效，优先级比单给边距高。
    @Publish public var margin: Array<Float64> = [] 
    //上外边距，默认值为 0.0。
    @Publish public var topMargin: Float64 = 0.0 
    //右外边距，默认值为 0.0。
    @Publish public var rightMargin: Float64 = 0.0 
    //下外边距，默认值为 0.0。
    @Publish public var bottomMargin: Float64 = 0.0 
    //左外边距，默认值为 0.0。
    @Publish public var leftMargin: Float64 = 0.0
}
```

## 5 FLOAT_LAYOUT 浮动容器布局组件

### 5.1 浮动容器布局组件 FloatLayout

```cangjie
@Component
public class FloatLayout {
    /*
     * 布局
     * 参数 layoutDataType - 数据。
     * 参数 Int64 - 位置索引。
     *
     * 返回值 Unit
     */
    @BuilderParam var vLayoutContent: (layoutDataType, Int64) -> Unit
    //数据源。
    var vLayoutData: Array<layoutDataType> 
    //属性。
    @State var vLayoutAttribute: FixAreaAttributes 
}
```
### 5.2 浮动容器布局组件 FixAreaAttributes

```cangjie
@Observed
public class FixAreaAttributes {
    /*
     * 可显示的条目，默认 [0,0]显示全部条目。
     * 注意：数组长度为 2，并且数组元素内第一项大于等于 0 ，第二项大于第一项。
     */
    @Publish public var range: Array<Int64> = [0, 0]
    /*
     * layoutWidth <= 0.0 && layoutHeight <= 0.0 && aspectRatio <= 0.0  =====> 默认 layoutHeights = 100.0 aspectRatios = 1.0
     * layoutWidth > 0.0 && layoutHeight <= 0.0 && aspectRatio <= 0.0   =====> 默认 layoutHeights = 100.0 aspectRatios = layoutWidth / layoutHeight
     * layoutWidth <= 0.0 && layoutHeight > 0.0 && aspectRatio <= 0.0   =====> 默认 aspectRatios = 1.0 layoutWidth = layoutHeight * aspectRatios
     * layoutWidth <= 0.0 && layoutHeight <= 0.0 && aspectRatio > 0.0   =====> 默认 layoutHeights = 100.0 layoutWidth = layoutHeight * aspectRatios
     * 其余 aspectRatios = layoutWidths / layoutHeights
     */
    @Publish public var layoutWidth: Float64 = 0.0
    //容器高度。
    @Publish public var layoutHeight: Float64 = 0.0 
    //容器纵横比。
    @Publish public var aspectRatio: Float64 = 0.0
    //水平偏移量。
    @Publish public var xOffset: Float64 = 0.0 
    //竖直偏移量。
    @Publish public var yOffset: Float64 = 0.0 
    //固定的位置。
    @Publish public var alignType: Int32 = -1 
    //默认位置，优先级比单给xy高，与 alignType 进行累加。
    @Publish public var defaultLocation: Array<Float64> = [] 
    //容器背景颜色。
    @Publish public var bgColor: UInt32 = 0xffffff 
    //容器背景颜色。
    @Publish public var bgOpacity: Float64 = 1.0 
    //组件的Z序，指明了该组件在堆叠组件中的位置，默认值为 0。
    @Publish public var zIndex: Int32 = 0
    //内边距，默认值为[]，长度设置为 4，优先级比单给内边距高，设置其他无效。
    @Publish public var padding: Array<Float64> = [] 
    //上内边距，默认值为 0.0。
    @Publish public var topPadding: Float64 = 0.0 
    //右内边距，默认值为 0.0。
    @Publish public var rightPadding: Float64 = 0.0 
    //下内边距，默认值为 0.0。
    @Publish public var bottomPadding: Float64 = 0.0 
    //左内边距，默认值为 0.0。
    @Publish public var leftPadding: Float64 = 0.0 
    //外边距，默认值为[]，长度固定为 4，设置其他无效，优先级比单给边距高。
    @Publish public var margin: Array<Float64> = [] 
    //上外边距，默认值为 0.0。
    @Publish public var topMargin: Float64 = 0.0 
    //右外边距，默认值为 0.0。
    @Publish public var rightMargin: Float64 = 0.0 
    //下外边距，默认值为 0.0。
    @Publish public var bottomMargin: Float64 = 0.0 
    //左外边距，默认值为 0.0。
    @Publish public var leftMargin: Float64 = 0.0
}
```

## 6 GRID_LAYOUT 复杂网格容器布局组件

### 6.1 复杂网格容器布局组件 GridLayout

```cangjie
@Component
public class GridLayout {
    /*
     * 布局
     * 参数 layoutDataType - 数据。
     * 参数 Int64 - 位置索引。
     * 参数 Float64 - 组件高度。
     *
     * 返回值 Unit
     */
    @BuilderParam var vLayoutContent: (layoutDataType, Int64, Float64) -> Unit
    //数据源。
    var vLayoutData: Array<layoutDataType> 
    //属性。
    @State var vLayoutAttribute: GridAttributes
}
```
### 6.2 复杂网格容器布局组件 GridAttributes 

```cangjie
@Observed
public class GridAttributes {
    /*
     * 可显示的条目，默认 [0,0]显示全部条目。
     * 注意：数组长度为 2，并且数组元素内第一项大于等于 0 ，第二项大于第一项。
     */
    @Publish public var range: Array<Int64> = [0, 0]
    //列数，取值大于等于0，weights 缺省时，默认显示4列。
    @Publish public var spanCount: Int64 = 0 
    /*
     * 列占比集合：数组元素数值约分为占比。
     * spanCount 为 0，weights 长度为 0 时，默认 [25.0, 25.0, 25.0, 25.0]。
     * spanCount > weights.size 且 weights 中值等于100%，则 列数为 weights 的长度，反之为 列数为 spanCount。
    */
    @Publish public var weights: Array<Float64> = []
    //aspectRatio 纵横比。缺省时高度默认屏幕高度，取值大于等于0.0。
    @Publish public var aspectRatio: Float64 = 0.0
    // layoutHeight 缺省，高度默认屏幕高度，取值大于等于0.0。
    @Publish public var layoutHeight: Float64 = 0.0 
    //行列间距，默认值为0。
    @Publish public var gap: Int64 = 0 
    //行与行的间距，默认值为0。
    @Publish public var vGap: Int64 = 0 
    //列与列的间距，默认值为0。
    @Publish public var hGap: Int64 = 0 
    //容器背景颜色。
    @Publish public var bgColor: UInt32 = 0xffffff 
    //容器背景颜色。
    @Publish public var bgOpacity: Float64 = 1.0 
    //组件的Z序，指明了该组件在堆叠组件中的位置，默认值为 0。
    @Publish public var zIndex: Int32 = 0
    //内边距，默认值为[]，长度设置为 4，优先级比单给内边距高，设置其他无效。
    @Publish public var padding: Array<Float64> = [] 
    //上内边距，默认值为 0.0。
    @Publish public var topPadding: Float64 = 0.0 
    //右内边距，默认值为 0.0。
    @Publish public var rightPadding: Float64 = 0.0 
    //下内边距，默认值为 0.0。
    @Publish public var bottomPadding: Float64 = 0.0 
    //左内边距，默认值为 0.0。
    @Publish public var leftPadding: Float64 = 0.0 
    //外边距，默认值为[]，长度固定为 4，设置其他无效，优先级比单给边距高。
    @Publish public var margin: Array<Float64> = [] 
    //上外边距，默认值为 0.0。
    @Publish public var topMargin: Float64 = 0.0 
    //右外边距，默认值为 0.0。
    @Publish public var rightMargin: Float64 = 0.0 
    //下外边距，默认值为 0.0。
    @Publish public var bottomMargin: Float64 = 0.0 
    //左外边距，默认值为 0.0。
    @Publish public var leftMargin: Float64 = 0.0
}
```

## 7 LINEAR_LAYOUT 列表容器布局组件

### 7.1 列表容器布局组件 LinearLayout

```cangjie
@Component
public class LinearLayout {
    /*
     * 布局
     * 参数 layoutDataType - 数据。
     * 参数 Int64 - 位置索引。
     * 参数 Float64 - 组件高度。
     *
     * 返回值 Unit
     */
    @BuilderParam var vLayoutContent: (layoutDataType, Int64, Float64) -> Unit 
    //数据源。
    var vLayoutData: Array<layoutDataType> 
    //属性。
    @State var vLayoutAttribute: LinearAttributes 
}
```
### 7.2 列表容器布局组件 LinearAttributes

```cangjie
@Observed
public class LinearAttributes {
    /*
     * 可显示的条目，默认 [0,0]显示全部条目。
     * 注意：数组长度为 2，并且数组元素内第一项大于等于 0 ，第二项大于第一项。
     */
    @Publish public var range: Array<Int64> = [0, 0]
    //列表项垂直间距，默认值为0
    @Publish public var dividerHeight: Int64 = 0 
    //容器高度。
    @Publish public var layoutHeight: Length = 0.0.vp 
    //容器宽度。
    @Publish public var layoutWidth: Length = 0.0.vp 
    //容器背景颜色。
    @Publish public var bgColor: UInt32 = 0xffffff 
    //容器背景颜色。
    @Publish public var bgOpacity: Float64 = 1.0 
    //组件的Z序，指明了该组件在堆叠组件中的位置，默认值为 0。
    @Publish public var zIndex: Int32 = 0
    //内边距，默认值为[]，长度设置为 4，优先级比单给内边距高，设置其他无效。
    @Publish public var padding: Array<Float64> = [] 
    //上内边距，默认值为 0.0。
    @Publish public var topPadding: Float64 = 0.0 
    //右内边距，默认值为 0.0。
    @Publish public var rightPadding: Float64 = 0.0 
    //下内边距，默认值为 0.0。
    @Publish public var bottomPadding: Float64 = 0.0 
    //左内边距，默认值为 0.0。
    @Publish public var leftPadding: Float64 = 0.0 
    //外边距，默认值为[]，长度固定为 4，设置其他无效，优先级比单给边距高。
    @Publish public var margin: Array<Float64> = [] 
    //上外边距，默认值为 0.0。
    @Publish public var topMargin: Float64 = 0.0 
    //右外边距，默认值为 0.0。
    @Publish public var rightMargin: Float64 = 0.0 
    //下外边距，默认值为 0.0。
    @Publish public var bottomMargin: Float64 = 0.0 
    //左外边距，默认值为 0.0。
    @Publish public var leftMargin: Float64 = 0.0
}
```

## 8 ONEN_LAYOUT 一拖 N 容器布局组件

### 8.1 一拖 N 容器布局组件 OneLayout

```cangjie
@Component
public class OneLayout {
    /*
     * 布局
     * 参数 layoutDataType - 数据。
     *
     * 返回值 Unit
     */
    @BuilderParam var vLayoutContent: (layoutDataType) -> Unit
    //数据源。
    var vLayoutData: Array<layoutDataType> 
    //属性。
    @State var vLayoutAttribute: AbstractFullFillAttributes 
}
```
### 8.2 一拖 N 容器布局组件属性 AbstractFullFillAttributes

```cangjie
@Observed
public class AbstractFullFillAttributes {
    /*
     * 可显示的条目，默认 [0,0]显示全部条目。
     * 注意：数组长度为 2，并且数组元素内第一项大于等于 0 ，第二项大于第一项。
     */
    @Publish public var range: Array<Int64> = [0, 0]
    //行权重，默认值为[]，取值大于等于0.0。
    @Publish public var rowWeights: Array<Float64> = [] 
    //列权重，默认值为[]，取值大于等于0.0。
    @Publish public var colWeights: Array<Float64> = [] 
    //第一个子项变成一行一列，默认值为false。
    @Publish public var hasHeader: Bool = false 
    //最后一个子项变成一行一列，默认值为false。
    @Publish public var hasFooter: Bool = false 
    //容器宽度。
    @Publish public var layoutWidth: Length = 0.0.vp 
    //容器高度。
    @Publish public var layoutHeight: Length = 0.0.vp 
    //容器背景颜色。
    @Publish public var bgColor: UInt32 = 0xffffff 
    //容器背景颜色。
    @Publish public var bgOpacity: Float64 = 1.0 
    //组件的Z序，指明了该组件在堆叠组件中的位置，默认值为 0。
    @Publish public var zIndex: Int32 = 0
    //内边距，默认值为[]，长度设置为 4，优先级比单给内边距高，设置其他无效。
    @Publish public var padding: Array<Float64> = [] 
    //上内边距，默认值为 0.0。
    @Publish public var topPadding: Float64 = 0.0 
    //右内边距，默认值为 0.0。
    @Publish public var rightPadding: Float64 = 0.0 
    //下内边距，默认值为 0.0。
    @Publish public var bottomPadding: Float64 = 0.0 
    //左内边距，默认值为 0.0。
    @Publish public var leftPadding: Float64 = 0.0 
    //外边距，默认值为[]，长度固定为 4，设置其他无效，优先级比单给边距高。
    @Publish public var margin: Array<Float64> = [] 
    //上外边距，默认值为 0.0。
    @Publish public var topMargin: Float64 = 0.0 
    //右外边距，默认值为 0.0。
    @Publish public var rightMargin: Float64 = 0.0 
    //下外边距，默认值为 0.0。
    @Publish public var bottomMargin: Float64 = 0.0 
    //左外边距，默认值为 0.0。
    @Publish public var leftMargin: Float64 = 0.0
}
```

## 9 ONEN_EX_LAYOUT 一拖 N 拓展容器布局组件

### 9.1 一拖 N 拓展容器布局组件 OneExLayout

```cangjie
@Component
public class OneExLayout {
    /*
     * 布局
     * 参数 layoutDataType - 数据。
     *
     * 返回值 Unit
     */
    @BuilderParam var vLayoutContent: (layoutDataType) -> Unit 
    //数据源。
    var vLayoutData: Array<layoutDataType> 
    //属性。
    @State var vLayoutAttribute: AbstractFullFillAttributes 
}
```
### 9.2 一拖 N 拓展容器布局组件 AbstractFullFillAttributes

```cangjie
@Observed
public class AbstractFullFillAttributes {
    /*
     * 可显示的条目，默认 [0,0]显示全部条目。
     * 注意：数组长度为 2，并且数组元素内第一项大于等于 0 ，第二项大于第一项。
     */
    @Publish public var range: Array<Int64> = [0, 0]
    //行权重，默认值为[]，取值大于等于0.0。
    @Publish public var rowWeights: Array<Float64> = [] 
    //列权重，默认值为[]，取值大于等于0.0。
    @Publish public var colWeights: Array<Float64> = [] 
    //容器宽度。
    @Publish public var layoutWidth: Length = 0.0.vp 
    //容器高度。
    @Publish public var layoutHeight: Length = 0.0.vp 
    //容器背景颜色。
    @Publish public var bgColor: UInt32 = 0xffffff 
    //容器背景颜色。
    @Publish public var bgOpacity: Float64 = 1.0 
    //组件的Z序，指明了该组件在堆叠组件中的位置，默认值为 0。
    @Publish public var zIndex: Int32 = 0
    //内边距，默认值为[]，长度设置为 4，优先级比单给内边距高，设置其他无效。
    @Publish public var padding: Array<Float64> = [] 
    //上内边距，默认值为 0.0。
    @Publish public var topPadding: Float64 = 0.0 
    //右内边距，默认值为 0.0。
    @Publish public var rightPadding: Float64 = 0.0 
    //下内边距，默认值为 0.0。
    @Publish public var bottomPadding: Float64 = 0.0 
    //左内边距，默认值为 0.0。
    @Publish public var leftPadding: Float64 = 0.0 
    //外边距，默认值为[]，长度固定为 4，设置其他无效，优先级比单给边距高。
    @Publish public var margin: Array<Float64> = [] 
    //上外边距，默认值为 0.0。
    @Publish public var topMargin: Float64 = 0.0 
    //右外边距，默认值为 0.0。
    @Publish public var rightMargin: Float64 = 0.0 
    //下外边距，默认值为 0.0。
    @Publish public var bottomMargin: Float64 = 0.0 
    //左外边距，默认值为 0.0。
    @Publish public var leftMargin: Float64 = 0.0
}
```

## 10 RANGEGRID_LAYOUT 区域网格容器布局组件

### 10.1 区域网格容器布局组件 RangeGridLayout

```cangjie
@Component
public class RangeGridLayout {
    /*
     * 布局
     * 参数 layoutDataType - 数据。
     * 参数 Int64 - 位置索引。
     * 参数 Float64 - 组件高度。
     *
     * 返回值 Unit
     */
    @BuilderParam var vLayoutContent: (layoutDataType, Int64, Float64) -> Unit
    //数据源。
    var vLayoutData: Array<layoutDataType> 
    //属性。
    @State var vLayoutAttribute: GridAttributes 
}
```
### 10.2 区域网格容器布局组件 GridAttributes

```cangjie
@Observed
public class GridAttributes {
    /*
     * 可显示的条目，默认 [0,0]显示全部条目。
     * 注意：数组长度为 2，并且数组元素内第一项大于等于 0 ，第二项大于第一项。
     */
    @Publish public var range: Array<Int64> = [0, 0]
    //列数，取值大于等于0。weights 缺省时，默认显示4列。
    @Publish public var spanCount: Int64 = 0 
    /*
     * 列占比集合：数组元素数值约分为占比。
     * spanCount 为 0，weights 长度为 0 时，默认 [25.0, 25.0, 25.0, 25.0]。
     * spanCount > weights.size 且 weights 中值等于100%，则 列数为 weights 的长度，反之为 列数为 spanCount。
     */
    @Publish public var weights: Array<Float64> = []
    //aspectRatio 纵横比。缺省时高度默认屏幕高度，取值大于等于0。
    @Publish public var aspectRatio: Float64 = 0.0
    // layoutHeight 缺省，高度默认屏幕高度，取值大于等于0。
    @Publish public var layoutHeight: Float64 = 0.0 
    //行列间距，默认值为 0,优先级高于vGap、hGap。
    @Publish public var gap: Int64 = 0 
    //行与行的间距，默认值为 0。
    @Publish public var vGap: Int64 = 0 
    //列与列的间距，默认值为 0。
    @Publish public var hGap: Int64 = 0 
    //容器背景颜色。
    @Publish public var bgColor: UInt32 = 0xffffff 
    //容器背景颜色。
    @Publish public var bgOpacity: Float64 = 1.0 
    //组件的Z序，指明了该组件在堆叠组件中的位置，默认值为 0。
    @Publish public var zIndex: Int32 = 0
    //内边距，默认值为[]，长度设置为 4，优先级比单给内边距高，设置其他无效。
    @Publish public var padding: Array<Float64> = [] 
    //上内边距，默认值为 0.0。
    @Publish public var topPadding: Float64 = 0.0 
    //右内边距，默认值为 0.0。
    @Publish public var rightPadding: Float64 = 0.0 
    //下内边距，默认值为 0.0。
    @Publish public var bottomPadding: Float64 = 0.0 
    //左内边距，默认值为 0.0。
    @Publish public var leftPadding: Float64 = 0.0 
    //外边距，默认值为[]，长度固定为 4，设置其他无效，优先级比单给边距高。
    @Publish public var margin: Array<Float64> = [] 
    //上外边距，默认值为 0.0。
    @Publish public var topMargin: Float64 = 0.0 
    //右外边距，默认值为 0.0。
    @Publish public var rightMargin: Float64 = 0.0 
    //下外边距，默认值为 0.0。
    @Publish public var bottomMargin: Float64 = 0.0 
    //左外边距，默认值为 0.0。
    @Publish public var leftMargin: Float64 = 0.0
}
```

## 11 SCROLL_FIX_LAYOUT 滚动固定容器布局组件

### 11.1 滚动固定容器布局组件 ScrollFixLayout

```cangjie
@Component
public class ScrollFixLayout {
    /*
     * 布局
     * 参数 layoutDataType - 数据。
     * 参数 Int64 - 位置索引。
     *
     * 返回值 Unit
     */
    @BuilderParam var vLayoutContent: (layoutDataType, Int64) -> Unit 
    //数据源。
    var vLayoutData: Array<layoutDataType> 
    //属性。
    @State var vLayoutAttribute: FixAreaAttributes 
}
```
### 11.2 滚动固定容器布局组件 FixAreaAttributes

```cangjie
@Observed
public class FixAreaAttributes {
    /*
     * 可显示的条目，默认 [0,0]显示全部条目。
     * 注意：数组长度为 2，并且数组元素内第一项大于等于 0 ，第二项大于第一项。
     */
    @Publish public var range: Array<Int64> = [0, 0]
    /*
     * 容器宽度
     * layoutWidth <= 0.0 && layoutHeight <= 0.0 && aspectRatio <= 0.0  =====> 默认 layoutHeights = 100.0 aspectRatios = 1.0
     * layoutWidth > 0.0 && layoutHeight <= 0.0 && aspectRatio <= 0.0   =====> 默认 layoutHeights = 100.0 aspectRatios = layoutWidth / layoutHeight
     * layoutWidth <= 0.0 && layoutHeight > 0.0 && aspectRatio <= 0.0   =====> 默认 aspectRatios = 1.0 layoutWidth = layoutHeight * aspectRatios
     * layoutWidth <= 0.0 && layoutHeight <= 0.0 && aspectRatio > 0.0   =====> 默认 layoutHeights = 100.0 layoutWidth = layoutHeight * aspectRatios
     * 其余 aspectRatios = layoutWidths / layoutHeights
     */
    @Publish public var layoutWidth: Float64 = 0.0
    //容器高度，取值大于等于0。
    @Publish public var layoutHeight: Float64 = 0.0 
    //容器纵横比，取值大于等于0。
    @Publish public var aspectRatio: Float64 = 0.0 
    //水平偏移量，默认值为0.0。
    @Publish public var xOffset: Float64 = 0.0 
    //竖直偏移量，默认值为0.0。
    @Publish public var yOffset: Float64 = 0.0 
    //固定的位置，优先级比单给xy高。
    @Publish public var alignType: Int32 = -1 
    //宽度占满屏幕。
    @Publish public var sketchMeasure: Bool = false 
    //容器背景颜色。
    @Publish public var bgColor: UInt32 = 0xffffff 
    //容器背景颜色。
    @Publish public var bgOpacity: Float64 = 1.0 
    //组件的Z序，指明了该组件在堆叠组件中的位置，默认值为 0。
    @Publish public var zIndex: Int32 = 0
    //内边距，默认值为[]，长度设置为 4，优先级比单给内边距高，设置其他无效。
    @Publish public var padding: Array<Float64> = [] 
    //上内边距，默认值为 0.0。
    @Publish public var topPadding: Float64 = 0.0 
    //右内边距，默认值为 0.0。
    @Publish public var rightPadding: Float64 = 0.0 
    //下内边距，默认值为 0.0。
    @Publish public var bottomPadding: Float64 = 0.0 
    //左内边距，默认值为 0.0。
    @Publish public var leftPadding: Float64 = 0.0 
    //外边距，默认值为[]，长度固定为 4，设置其他无效，优先级比单给边距高。
    @Publish public var margin: Array<Float64> = [] 
    //上外边距，默认值为 0.0。
    @Publish public var topMargin: Float64 = 0.0 
    //右外边距，默认值为 0.0。
    @Publish public var rightMargin: Float64 = 0.0 
    //下外边距，默认值为 0.0。
    @Publish public var bottomMargin: Float64 = 0.0 
    //左外边距，默认值为 0.0。
    @Publish public var leftMargin: Float64 = 0.0
}
```

## 12 SINGLE_LAYOUT 通栏容器布局组件

### 12.1 通栏容器布局组件 SingleLayout

通栏容器布局组件建议数据长度设置为 1 

```cangjie
@Component
public class SingleLayout {
    /*
     * 布局
     * 参数 layoutDataType - 数据。
     * 参数 Int64 - 位置索引。
     *
     * 返回值 Unit
     */
    @BuilderParam var vLayoutContent: (layoutDataType, Int64) -> Unit
    //数据源。
    var vLayoutData: Array<layoutDataType> 
    //属性。
    @State var singleAttribute: FixAreaAttributes 
}
```
### 12.2 通栏容器布局组件 AbstractFullFillAttributes 

```cangjie
@Observed
public class AbstractFullFillAttributes {
    /*
     * 可显示的条目，默认 [0,0]显示全部条目。
     * 注意：数组长度为 2，并且数组元素内第一项大于等于 0 ，第二项大于第一项。
     */
    @Publish public var range: Array<Int64>
    //容器宽度。
    @Publish public var layoutWidth: Length = 0.0.vp 
    //容器高度。
    @Publish public var layoutHeight: Length = 0.0.vp 
    //容器背景颜色。
    @Publish public var bgColor: UInt32 = 0xffffff 
    //容器背景颜色。
    @Publish public var bgOpacity: Float64 = 1.0 
    //组件的Z序，指明了该组件在堆叠组件中的位置，默认值为 0。
    @Publish public var zIndex: Int32 = 0
    //内边距，默认值为[]，长度设置为 4，优先级比单给内边距高，设置其他无效。
    @Publish public var padding: Array<Float64> = [] 
    //上内边距，默认值为 0.0。
    @Publish public var topPadding: Float64 = 0.0 
    //右内边距，默认值为 0.0。
    @Publish public var rightPadding: Float64 = 0.0 
    //下内边距，默认值为 0.0。
    @Publish public var bottomPadding: Float64 = 0.0 
    //左内边距，默认值为 0.0。
    @Publish public var leftPadding: Float64 = 0.0 
    //外边距，默认值为[]，长度固定为 4，设置其他无效，优先级比单给边距高。
    @Publish public var margin: Array<Float64> = [] 
    //上外边距，默认值为 0.0。
    @Publish public var topMargin: Float64 = 0.0 
    //右外边距，默认值为 0.0。
    @Publish public var rightMargin: Float64 = 0.0 
    //下外边距，默认值为 0.0。
    @Publish public var bottomMargin: Float64 = 0.0 
    //左外边距，默认值为 0.0。
    @Publish public var leftMargin: Float64 = 0.0
}
```

## 13 STAGGEREDGRID_LAYOUT 交错网格容器布局组件

### 13.1 交错网格容器布局组件 StaggeredGridLayout

```cangjie
@Component
public class StaggeredGridLayout {
    /*
     * 布局
     * 参数 layoutDataType - 数据
     * 参数 Int64 - 位置索引
     *
     * 返回值 Unit
     */
    @BuilderParam var vLayoutContent: (layoutDataType, Int64) -> Unit  //布局
    //数据源。
    var vLayoutData: Array<layoutDataType> 
    //属性。
    @State var staggeredGridAttribute: FixAreaAttributes 
    //组件标识，必传。
    @State var vLayoutId: String = '' 
}
```
### 13.2 交错网格容器布局组件 StaggeredGridAttributes

```cangjie
@Observed
public class StaggeredGridAttributes {
    /*
     * 可显示的条目，默认 [0,0]显示全部条目。
     * 注意：数组长度为 2，并且数组元素内第一项大于等于 0 ，第二项大于第一项。
     */
    @Publish public var range: Array<Int64> = [0, 0]
    //瀑布流宽度，取值大于等于0。
    @Publish public var staggeredWidth: Float64 = 0.0
    //列数，默认值为1，取值大于等于0。
    @Publish public var lanes: Int64 = 1 
    //行列间距，优先级高于 vGap、hGap。
    @Publish public var gap: Float64 = 0.0 
    //行与行的间距。
    @Publish public var vGap: Float64 = 0.0 
    //列与列的间距。
    @Publish public var hGap: Float64 = 0.0 
    //容器背景颜色。
    @Publish public var bgColor: UInt32 = 0xffffff 
    //容器背景颜色。
    @Publish public var bgOpacity: Float64 = 1.0 
    //组件的Z序，指明了该组件在堆叠组件中的位置，默认值为 0。
    @Publish public var zIndex: Int32 = 0
    //内边距，默认值为[]，长度设置为 4，优先级比单给内边距高，设置其他无效。
    @Publish public var padding: Array<Float64> = [] 
    //上内边距，默认值为 0.0。
    @Publish public var topPadding: Float64 = 0.0 
    //右内边距，默认值为 0.0。
    @Publish public var rightPadding: Float64 = 0.0 
    //下内边距，默认值为 0.0。
    @Publish public var bottomPadding: Float64 = 0.0 
    //左内边距，默认值为 0.0。
    @Publish public var leftPadding: Float64 = 0.0 
    //外边距，默认值为[]，长度固定为 4，设置其他无效，优先级比单给边距高。
    @Publish public var margin: Array<Float64> = [] 
    //上外边距，默认值为 0.0。
    @Publish public var topMargin: Float64 = 0.0 
    //右外边距，默认值为 0.0。
    @Publish public var rightMargin: Float64 = 0.0 
    //下外边距，默认值为 0.0。
    @Publish public var bottomMargin: Float64 = 0.0 
    //左外边距，默认值为 0.0。
    @Publish public var leftMargin: Float64 = 0.0
}
```

## 14 STICKY_LAYOUT 吸顶容器布局组件

### 14.1 吸顶容器布局组件 StickyLayout

```cangjie
@Component
public class StickyLayout {
    /*
     * 布局
     * 参数 layoutDataType - 数据。
     * 参数 Int64 - 位置索引。
     *
     * 返回值 Unit
     */
    @BuilderParam var vLayoutContent: (layoutDataType, Int64) -> Unit 
    //数据源。
    var vLayoutData: Array<layoutDataType> 
    //属性。
    @State var stickyAttribute: FixAreaAttributes 
}
```
### 14.2 吸顶容器布局组件 FixAreaAttributes

```cangjie
@Observed
public class FixAreaAttributes {
    /*
     * layoutWidth <= 0.0 && layoutHeight <= 0.0 && aspectRatio <= 0.0  =====> 默认 layoutHeights = 100.0 aspectRatios = 1.0
     * layoutWidth > 0.0 && layoutHeight <= 0.0 && aspectRatio <= 0.0   =====> 默认 layoutHeights = 100.0 aspectRatios = layoutWidth / layoutHeight
     * layoutWidth <= 0.0 && layoutHeight > 0.0 && aspectRatio <= 0.0   =====> 默认 aspectRatios = 1.0 layoutWidth = layoutHeight * aspectRatios
     * layoutWidth <= 0.0 && layoutHeight <= 0.0 && aspectRatio > 0.0   =====> 默认 layoutHeights = 100.0 layoutWidth = layoutHeight * aspectRatios
     * 其余 aspectRatios = layoutWidths / layoutHeights
     */
    @Publish public var layoutWidth: Float64 = 0.0 
    //容器高度。
    @Publish public var layoutHeight: Float64 = 0.0 
    //容器纵横比。
    @Publish public var aspectRatio: Float64 = 0.0 
    //容器背景颜色。
    @Publish public var bgColor: UInt32 = 0xffffff 
    //容器背景颜色。
    @Publish public var bgOpacity: Float64 = 1.0 
    //组件的Z序，指明了该组件在堆叠组件中的位置，默认值为 0。
    @Publish public var zIndex: Int32 = 0
    //内边距，默认值为[]，长度设置为 4，优先级比单给内边距高，设置其他无效。
    @Publish public var padding: Array<Float64> = [] 
    //上内边距，默认值为 0.0。
    @Publish public var topPadding: Float64 = 0.0 
    //右内边距，默认值为 0.0。
    @Publish public var rightPadding: Float64 = 0.0 
    //下内边距，默认值为 0.0。
    @Publish public var bottomPadding: Float64 = 0.0 
    //左内边距，默认值为 0.0。
    @Publish public var leftPadding: Float64 = 0.0 
    //外边距，默认值为[]，长度固定为 4，设置其他无效，优先级比单给边距高。
    @Publish public var margin: Array<Float64> = [] 
    //上外边距，默认值为 0.0。
    @Publish public var topMargin: Float64 = 0.0 
    //右外边距，默认值为 0.0。
    @Publish public var rightMargin: Float64 = 0.0 
    //下外边距，默认值为 0.0。
    @Publish public var bottomMargin: Float64 = 0.0 
    //左外边距，默认值为 0.0。
    @Publish public var leftMargin: Float64 = 0.0
}
```

## 15 跳转 item 项位置

### 15.1 跳转 item 项位置

```cangjie
@Component
public class JumpBar {
    //宽度。
    var jumpBarWidth: Length = 100.percent  
    //高度。
    var jumpBarHeight: Length = 100.percent 
    //背景色。
    var jumpBarColor: UInt32 = 0x33000000   
    //大小。
    var jumpBarAspectRatio: Float64 = 4.0  
    //字体大小。
    var fontSize: Float64 = 17.0          
    //按钮颜色。
    var btBgColor: UInt32 = 0xD6D7D7       
    //是否显示文本条目。
    var textShow: Bool = true               
    //滑动控制器数据。
    @Link var scroller: Array<Scroller>  
    //item 首次出现位置。
    @Link var textFirst: Int64         
    //item 偏移。
    @Link var textExisting: Int64          
    //滑动时 item 累加。
    @Link var textCreated: Int64     
    //item 数目。
    @Link var textCount: Int64    
    //输入跳转位置。
    @Link var textInput: Int32              
}
```
      