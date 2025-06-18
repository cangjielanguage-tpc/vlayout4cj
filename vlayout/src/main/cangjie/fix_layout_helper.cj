/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package vlayout4cj

import ohos.state_macro_manage.Component
import ohos.state_macro_manage.BuilderParam
import ohos.state_macro_manage.State
import ohos.state_macro_manage.Watch

private const TAG = 'vlayout FIX_LAYOUT '

@Component
public class FixLayout {
    @BuilderParam var vLayoutContent: (layoutDataType, Int64) -> Unit //布局
    var vLayoutData: Array<layoutDataType> = [] //数据源

    @State @Watch[defaultValueInit] var vLayoutAttribute: FixAreaAttributes = FixAreaAttributes() //属性
    @State var fixInfo: FixAreaAttributes = FixAreaAttributes() //属性

    private var layoutWidth: Float64 = 0.0 //获取的容器高度
    private var layoutHeight: Float64 = 0.0 //获取的容器高度
    private var aspectRatio: Float64 = 0.0 //宽高比
    private var xOffset: Float64 = 0.0 // x偏移
    private var yOffset: Float64 = 0.0 //y偏移

    protected override func aboutToAppear() {
        this.defaultValueInit()
    }

    func defaultValueInit() {
        this.fixInfo = FixAreaAttributes(
            range: if(this.vLayoutAttribute.range == [0, 0] || this.vLayoutAttribute.range[1] > this.vLayoutData.size) {[0, this.vLayoutData.size] } else {this.vLayoutAttribute.range } ,
            layoutWidth: this.vLayoutAttribute.layoutWidth,
            layoutHeight: this.vLayoutAttribute.layoutHeight,
            aspectRatio: this.vLayoutAttribute.aspectRatio,
            bgColor: this.vLayoutAttribute.bgColor,
            xOffset: this.vLayoutAttribute.xOffset,
            yOffset: this.vLayoutAttribute.yOffset,
            alignType: this.vLayoutAttribute.alignType,
            sketchMeasure: this.vLayoutAttribute.sketchMeasure,
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
        this.computedAlignType()
    }

    func initComponentSize() {
        //当容器宽度layoutWidth定义了，无法同时给左右外边距
        //当容器纵横比aspectRatio定义了就相当于容器宽度layoutWidth定义了
        //八种情况下只有两种情况同时给定左右外边距能生效
        if (this.fixInfo.layoutWidth == 0.0 && this.fixInfo.layoutHeight == 0.0 && this.fixInfo.aspectRatio == 0.0) {
            this.layoutWidth = 0.0
            this.layoutHeight = 100.0
            this.aspectRatio = 0.0
        } else if (this.fixInfo.layoutWidth != 0.0 && this.fixInfo.layoutHeight == 0.0 && this.fixInfo.aspectRatio == 0.0) {
            this.layoutWidth = this.fixInfo.layoutWidth
            this.layoutHeight = 100.0
            this.aspectRatio = 0.0
        } else if (this.fixInfo.layoutWidth == 0.0 && this.fixInfo.layoutHeight != 0.0 && this.fixInfo.aspectRatio == 0.0) {
            this.layoutWidth = 0.0
            this.layoutHeight = this.fixInfo.layoutHeight
            this.aspectRatio = 0.0
        } else if (this.fixInfo.layoutWidth == 0.0 && this.fixInfo.layoutHeight == 0.0 && this.fixInfo.aspectRatio != 0.0) {
            this.layoutWidth = 0.0
            this.layoutHeight = 0.0
            this.aspectRatio = this.fixInfo.aspectRatio
        } else if (this.fixInfo.layoutWidth != 0.0 && this.fixInfo.layoutHeight != 0.0 && this.fixInfo.aspectRatio != 0.0) {
            this.layoutWidth = this.fixInfo.layoutWidth
            this.layoutHeight = this.fixInfo.layoutHeight
            this.aspectRatio = this.fixInfo.aspectRatio
        } else if (this.fixInfo.layoutWidth != 0.0 && this.fixInfo.layoutHeight != 0.0 && this.fixInfo.aspectRatio == 0.0) {
            this.layoutWidth = this.fixInfo.layoutWidth
            this.layoutHeight = this.fixInfo.layoutHeight
            this.aspectRatio = this.layoutWidth / this.layoutHeight
        } else if (this.fixInfo.layoutWidth != 0.0 && this.fixInfo.layoutHeight == 0.0 && this.fixInfo.aspectRatio != 0.0) {
            this.layoutWidth = this.fixInfo.layoutWidth
            this.layoutHeight = 0.0
            this.aspectRatio = this.fixInfo.aspectRatio
        } else if (this.fixInfo.layoutWidth == 0.0 && this.fixInfo.layoutHeight != 0.0 && this.fixInfo.aspectRatio != 0.0) {
            this.layoutWidth = 0.0
            this.layoutHeight = this.fixInfo.layoutHeight
            this.aspectRatio = this.fixInfo.aspectRatio
        } else {
            Hilog.error(0x000000, "initComponentSize", TAG + 'else')
        }
    }



    func computedRange() {
        //可显示的条目range数组长度为2并且数组元素内第一项大于等于0并且第二项大于第一项
        if (this.fixInfo.range.size == 2 && this.fixInfo.range[0] >= 0 && this.fixInfo.range[1] > this.fixInfo.range[0]) {
            this.vLayoutData = this.vLayoutData.slice(this.fixInfo.range[0], this.fixInfo.range[1])
        } else {
            this.vLayoutData = this.vLayoutData
        }
    }

    func computedAlignType() {
        let displayClass: Display = getDefaultDisplaySync();
        let screenWidth: Float64 = px2vp(Float64(displayClass.width).px)().value
        let screenHeight: Float64 = px2vp(Float64(displayClass.height).px)().value

        if (this.fixInfo.alignType == 0) { //左上
            this.xOffset = 0.0
            this.yOffset = 0.0
        } else if (this.fixInfo.alignType == 1) { //右上
            this.xOffset = screenWidth - this.layoutWidth
            this.yOffset = 0.0

        } else if (this.fixInfo.alignType == 2) { //左下
            this.xOffset = 0.0
            this.yOffset = screenHeight - this.layoutHeight
        } else if (this.fixInfo.alignType == 3) { //右下
            this.xOffset = screenWidth - this.layoutWidth
            this.yOffset = screenHeight - this.layoutHeight
        } else {
            this.xOffset = this.fixInfo.xOffset
            this.yOffset = this.fixInfo.yOffset
        }

    }


    func build() {
        Column() {
            ForEach(this.vLayoutData, itemGeneratorFunc: {item: layoutDataType, position: Int64 =>
                this.vLayoutContent(item, position)
            })
        }
        .onAreaChange({oldValue, newValue =>
            this.layoutWidth = if(px2vp(newValue.width.px).isSome()) {px2vp(newValue.width.px)().value} else { 0.0}
            this.layoutHeight = if(px2vp(newValue.height.px).isSome()) { px2vp(newValue.height.px)().value} else { 0.0}
            this.computedAlignType()
            Hilog.info(0x000000, "layout", TAG + 'layoutWidth = ${this.layoutWidth}, layoutHeight = ${this.layoutHeight}')
        })
        .width( if(this.fixInfo.sketchMeasure) { 100.percent }else { this.layoutWidth.vp })
        .height(this.layoutHeight)
        .aspectRatio(this.aspectRatio)
        .backgroundColor(this.fixInfo.bgColor)
        .position(
            x: if(this.fixInfo.sketchMeasure) { 0.0 } else { this.xOffset } ,
            y: this.yOffset
        )
        .padding(
            top: this.fixInfo.topPadding,
            right: this.fixInfo.rightPadding,
            bottom: this.fixInfo.bottomPadding,
            left: this.fixInfo.leftPadding
        )
        .zIndex(this.fixInfo.zIndex)
        .margin(
            top: this.fixInfo.topMargin,
            right: this.fixInfo.rightMargin,
            bottom: this.fixInfo.bottomMargin,
            left: this.fixInfo.leftMargin
        )
    }
}