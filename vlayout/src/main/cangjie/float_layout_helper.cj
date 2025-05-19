/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package vlayout4cj

import ohos.state_macro_manage.Component
import ohos.state_macro_manage.BuilderParam
import ohos.state_macro_manage.State
import ohos.state_macro_manage.Watch

private const TAG = 'vlayout FLOAT_LAYOUT '

@Component
public class FloatLayout {
    @BuilderParam var vLayoutContent: (layoutDataType, Int64) -> Unit //布局
    var vLayoutData: Array<layoutDataType> = [] //数据源

    @State @Watch[defaultValueInit] var vLayoutAttribute: FixAreaAttributes = FixAreaAttributes() //属性
    @State var floatInfo: FixAreaAttributes = FixAreaAttributes() //属性

    private var layoutWidth: Float64 = 0.0 //获取的容器高度
    private var layoutHeight: Float64 = 0.0 //获取的容器高度
    private var aspectRatio: Float64 = 0.0 //宽高比
    @State var xOffset: Float64 = 0.0 // x偏移
    @State var yOffset: Float64 = 0.0 //y偏移
    private  var yyOffset: Float64 = 0.0 //y偏移
    @State var imitatorShow: Bool = false //模拟块是否显示
    @State var imitatorWidth: Float64 = 0.0 //模拟块宽度
    @State var imitatorHeight: Float64 = 0.0 //模拟块高度

    let displayClass: Display = getDefaultDisplaySync()
    let screenWidth: Float64 = px2vp(Float64(displayClass.width).px)().value
    let screenHeight: Float64 = px2vp(Float64(displayClass.height).px)().value

    protected override func aboutToAppear() {
        this.defaultValueInit()
        if (this.floatInfo.alignType == 0) { //左上
            this.xOffset = 0.0
            this.yOffset = 0.0
        } else if (this.floatInfo.alignType == 1) { //右上
            this.xOffset = screenWidth - this.layoutWidth
            this.yOffset = 0.0

        } else if (this.floatInfo.alignType == 2) { //左下
            this.xOffset = 0.0
            this.yOffset = screenHeight - this.layoutHeight
        } else if (this.floatInfo.alignType == 3) { //右下
            this.xOffset = screenWidth - this.layoutWidth
            this.yOffset = screenHeight - this.layoutHeight
        } else {
            this.xOffset = this.floatInfo.xOffset
            this.yOffset = this.floatInfo.yOffset
        }

        if (this.floatInfo.defaultLocation.size == 2) {
            this.xOffset = this.xOffset + this.floatInfo.defaultLocation[0]
            this.yOffset = this.yOffset + this.floatInfo.defaultLocation[1]
        }
    }

    func defaultValueInit() {
        this.floatInfo = FixAreaAttributes(
            range: if(this.vLayoutAttribute.range == [0, 0] || this.vLayoutAttribute.range[1] > this.vLayoutData.size) {[0, this.vLayoutData.size] } else {this.vLayoutAttribute.range } ,
            layoutWidth: this.vLayoutAttribute.layoutWidth,
            layoutHeight: this.vLayoutAttribute.layoutHeight,
            aspectRatio: this.vLayoutAttribute.aspectRatio,
            bgColor: this.vLayoutAttribute.bgColor,
            xOffset: this.vLayoutAttribute.xOffset,
            yOffset: this.vLayoutAttribute.yOffset,
            alignType: this.vLayoutAttribute.alignType,
            defaultLocation: this.vLayoutAttribute.defaultLocation,
            zIndex: this.vLayoutAttribute.zIndex,
            padding: this.vLayoutAttribute.padding,
            topPadding: if(this.vLayoutAttribute.padding.size == 4) {
                this.vLayoutAttribute.padding[0]
            } else {
                this.vLayoutAttribute.topPadding
            },
            rightPadding: if(this.vLayoutAttribute.padding.size == 4) {
                this.vLayoutAttribute.padding[1]
            } else {
                this.vLayoutAttribute.rightPadding
            },
            bottomPadding: if(this.vLayoutAttribute.padding.size == 4) {
                this.vLayoutAttribute.padding[2]
            } else {
                this.vLayoutAttribute.bottomPadding
            },
            leftPadding: if(this.vLayoutAttribute.padding.size == 4) {
                this.vLayoutAttribute.padding[3]
            } else {
                this.vLayoutAttribute.leftPadding
            },
            margin: this.vLayoutAttribute.margin,
            topMargin: if(this.vLayoutAttribute.margin.size == 4) {
                this.vLayoutAttribute.margin[0]
            } else {
                this.vLayoutAttribute.topMargin
            },
            rightMargin: if(this.vLayoutAttribute.margin.size == 4) {
                this.vLayoutAttribute.margin[1]
            } else {
                this.vLayoutAttribute.rightMargin
            },
            bottomMargin: if(this.vLayoutAttribute.margin.size == 4) {
                this.vLayoutAttribute.margin[2]
            } else {
                this.vLayoutAttribute.bottomMargin
            },
            leftMargin: if(this.vLayoutAttribute.margin.size == 4) {
                this.vLayoutAttribute.margin[3]
            } else {
                this.vLayoutAttribute.leftMargin
            }
        )
        this.initComponentSize()
        this.computedRange()
    }

    func initComponentSize() {
        //当容器宽度layoutWidth定义了，无法同时给左右外边距
        //当容器纵横比aspectRatio定义了就相当于容器宽度layoutWidth定义了
        //八种情况下只有两种情况同时给定左右外边距能生效
        if (this.floatInfo.layoutWidth == 0.0 && this.floatInfo.layoutHeight == 0.0 && this.floatInfo.aspectRatio == 0.0) {
            this.layoutWidth = 0.0
            this.layoutHeight = 100.0
            this.aspectRatio = 0.0
        } else if (this.floatInfo.layoutWidth != 0.0 && this.floatInfo.layoutHeight == 0.0 && this.floatInfo.aspectRatio == 0.0) {
            this.layoutWidth = this.floatInfo.layoutWidth
            this.layoutHeight = 100.0
            this.aspectRatio = 0.0
        } else if (this.floatInfo.layoutWidth == 0.0 && this.floatInfo.layoutHeight != 0.0 && this.floatInfo.aspectRatio == 0.0) {
            this.layoutWidth = 0.0
            this.layoutHeight = this.floatInfo.layoutHeight
            this.aspectRatio = 0.0
        } else if (this.floatInfo.layoutWidth == 0.0 && this.floatInfo.layoutHeight == 0.0 && this.floatInfo.aspectRatio != 0.0) {
            this.layoutWidth = 0.0
            this.layoutHeight = 0.0
            this.aspectRatio = this.floatInfo.aspectRatio
        } else if (this.floatInfo.layoutWidth != 0.0 && this.floatInfo.layoutHeight != 0.0 && this.floatInfo.aspectRatio != 0.0) {
            this.layoutWidth = this.floatInfo.layoutWidth
            this.layoutHeight = this.floatInfo.layoutHeight
            this.aspectRatio = this.floatInfo.aspectRatio
        } else if (this.floatInfo.layoutWidth != 0.0 && this.floatInfo.layoutHeight != 0.0 && this.floatInfo.aspectRatio == 0.0) {
            this.layoutWidth = this.floatInfo.layoutWidth
            this.layoutHeight = this.floatInfo.layoutHeight
            this.aspectRatio = this.layoutWidth / this.layoutHeight
        } else if (this.floatInfo.layoutWidth != 0.0 && this.floatInfo.layoutHeight == 0.0 && this.floatInfo.aspectRatio != 0.0) {
            this.layoutWidth = this.floatInfo.layoutWidth
            this.layoutHeight = 0.0
            this.aspectRatio = this.floatInfo.aspectRatio
        } else if (this.floatInfo.layoutWidth == 0.0 && this.floatInfo.layoutHeight != 0.0 && this.floatInfo.aspectRatio != 0.0) {
            this.layoutWidth = 0.0
            this.layoutHeight = this.floatInfo.layoutHeight
            this.aspectRatio = this.floatInfo.aspectRatio
        } else {
            Hilog.info(0,"", TAG + 'else')
        }
    }



    func computedRange() {
        //可显示的条目range数组长度为2并且数组元素内第一项大于等于0并且第二项大于第一项
        if (this.floatInfo.range.size == 2 && this.floatInfo.range[0] >= 0 && this.floatInfo.range[1] > this.floatInfo.range[0]) {
            this.vLayoutData = this.vLayoutData.slice(this.floatInfo.range[0], this.floatInfo.range[1])
        } else {
            this.vLayoutData = this.vLayoutData
        }
    }

    func getSize(id: String): Array<Float64>{
        let strJson = getInspectorByKey(id)
        let obj = JsonValue.fromStr(strJson).asObject()
        let fields = obj.getFields()
        let children = fields.get("$rect").getOrThrow().toString()
        let strArr = children.split(",")
        let rect_left = Float64.parse(strArr[0][2..])
        var temp = strArr[1]
        let rect_top = Float64.parse(temp[..temp.size - 1])
        temp = strArr[2]
        let rect_right = Float64.parse(temp[1..])
        temp = strArr[3]
        let rect_bottom = Float64.parse(temp[0..temp.size - 2])
        return [rect_right - rect_left, rect_bottom - rect_top]
    }

    func build() {
        Stack() {
            ForEach(this.vLayoutData, itemGeneratorFunc: {item: layoutDataType, position: Int64 =>
                this.vLayoutContent(item, position)
                if (this.imitatorShow) {
                    Stack() {
                        this.vLayoutContent(item, position)
                    }
                    .width(this.imitatorWidth)
                    .height(this.imitatorHeight)
                    .backgroundColor(0xEEEEEE)
                }
            })
        }
        .onTouch({event =>
            match (event.eventType) {
                case TouchType.Down =>
                    //拷贝块样式
                    let areaInfo = event.target.area
                    //断言数据类型
                    this.imitatorWidth = areaInfo.width
                    this.imitatorHeight = areaInfo.height
                    this.xOffset = areaInfo.globalPosition.x
                    this.yOffset = if(this.yyOffset == 0.0) {areaInfo.globalPosition.y } else { this.yyOffset }
                    //拷贝完成，展示模拟块
                    this.imitatorShow = true
                case TouchType.Move =>
                    this.xOffset = event.touches[0].screenX - this.imitatorWidth / 2.0
                    this.yOffset = event.touches[0].screenY - this.imitatorHeight / 2.0
                case TouchType.Up =>
                    this.imitatorShow = false
                    let displayClass: Display = getDefaultDisplaySync()
                    if (this.xOffset < px2vp(Float64(displayClass.width).px)().value / 2.0) {
                        this.xOffset = 0.0
                    } else {
                        this.xOffset = px2vp(Float64(displayClass.width).px)().value - this.imitatorWidth
                    }
                    this.yyOffset = this.yOffset

                case TouchType.Cancel =>
                    Hilog.warn(0,"", "${TAG} Cancel")
                case _ =>
                    Hilog.warn(0,"", "${TAG} else")
            }

        })
        .id("FLOAT")
        .width(this.layoutWidth)
        .height(this.layoutHeight)
        .aspectRatio(this.aspectRatio)
        .backgroundColor(this.floatInfo.bgColor)
        .position(
            x: this.xOffset,
            y: this.yOffset
        )
        .padding(
            top: this.floatInfo.topPadding,
            right: this.floatInfo.rightPadding,
            bottom: this.floatInfo.bottomPadding,
            left: this.floatInfo.leftPadding
        )
        .zIndex(this.floatInfo.zIndex)
        .margin(
            top: this.floatInfo.topMargin,
            right: this.floatInfo.rightMargin,
            bottom: this.floatInfo.bottomMargin,
            left: this.floatInfo.leftMargin
        )
    }
}