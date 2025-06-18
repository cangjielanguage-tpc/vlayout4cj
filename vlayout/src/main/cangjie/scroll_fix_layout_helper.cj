/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package vlayout4cj

import ohos.state_macro_manage.Component
import ohos.state_macro_manage.BuilderParam
import ohos.state_macro_manage.State
import ohos.state_macro_manage.Watch

private const TAG = 'vlayout SCROLL_FIX_LAYOUT '

@Component
public class ScrollFixLayout {
    @BuilderParam var vLayoutContent: (layoutDataType, Int64) -> Unit //布局
    var vLayoutData: Array<layoutDataType> = [] //数据源

    @State @Watch[defaultValueInit] var vLayoutAttribute: FixAreaAttributes = FixAreaAttributes() //属性
    @State var scrollFixInfo: FixAreaAttributes = FixAreaAttributes() //属性

    private var layoutWidth: Float64 = 0.0 //获取的容器高度
    private var layoutHeight: Float64 = 0.0 //获取的容器高度
    private var aspectRatio: Float64 = 0.0 //宽高比
    private var xOffset: Float64 = 0.0 // x偏移
    private var yOffset: Float64 = 0.0 //y偏移

    protected override func aboutToAppear() {
        defaultValueInit()
    }

    func defaultValueInit() {
        scrollFixInfo = FixAreaAttributes(
            range: if(vLayoutAttribute.range == [0, 0] || vLayoutAttribute.range[1] > vLayoutData.size) {[0, vLayoutData.size] } else {vLayoutAttribute.range } ,
            layoutWidth: vLayoutAttribute.layoutWidth,
            layoutHeight: vLayoutAttribute.layoutHeight,
            aspectRatio: vLayoutAttribute.aspectRatio,
            bgColor: vLayoutAttribute.bgColor,
            xOffset: vLayoutAttribute.xOffset,
            yOffset: vLayoutAttribute.yOffset,
            alignType: vLayoutAttribute.alignType,
            sketchMeasure: vLayoutAttribute.sketchMeasure,
            zIndex: vLayoutAttribute.zIndex,
            padding: vLayoutAttribute.padding,
            topPadding: if(vLayoutAttribute.padding.size == 4) {
                vLayoutAttribute.padding[0]
            } else {
                vLayoutAttribute.topPadding
            },
            rightPadding: if(vLayoutAttribute.padding.size == 4) {
                vLayoutAttribute.padding[1]
            } else {
                vLayoutAttribute.rightPadding
            },
            bottomPadding: if(vLayoutAttribute.padding.size == 4) {
                vLayoutAttribute.padding[2]
            } else {
                vLayoutAttribute.bottomPadding
            },
            leftPadding: if(vLayoutAttribute.padding.size == 4) {
                vLayoutAttribute.padding[3]
            } else {
                vLayoutAttribute.leftPadding
            },
            margin: vLayoutAttribute.margin,
            topMargin: if(vLayoutAttribute.margin.size == 4) {
                vLayoutAttribute.margin[0]
            } else {
                vLayoutAttribute.topMargin
            },
            rightMargin: if(vLayoutAttribute.margin.size == 4) {
                vLayoutAttribute.margin[1]
            } else {
                vLayoutAttribute.rightMargin
            },
            bottomMargin: if(vLayoutAttribute.margin.size == 4) {
                vLayoutAttribute.margin[2]
            } else {
                vLayoutAttribute.bottomMargin
            },
            leftMargin: if(vLayoutAttribute.margin.size == 4) {
                vLayoutAttribute.margin[3]
            } else {
                vLayoutAttribute.leftMargin
            }
        )
        initComponentSize()
        computedRange()
        computedAlignType()
    }

    func initComponentSize() {
        if (scrollFixInfo.layoutWidth == 0.0 && scrollFixInfo.layoutHeight == 0.0 && scrollFixInfo.aspectRatio == 0.0) {
            layoutHeight = 100.0
            aspectRatio = 1.0
            layoutWidth = layoutHeight * aspectRatio
        } else if (scrollFixInfo.layoutWidth != 0.0 && scrollFixInfo.layoutHeight == 0.0 && scrollFixInfo.aspectRatio == 0.0) {
            layoutWidth = scrollFixInfo.layoutWidth
            layoutHeight = 100.0
            aspectRatio = layoutWidth / layoutHeight
        } else if (scrollFixInfo.layoutWidth == 0.0 && scrollFixInfo.layoutHeight != 0.0 && scrollFixInfo.aspectRatio == 0.0) {
            layoutHeight = scrollFixInfo.layoutHeight
            aspectRatio = 1.0
            layoutWidth = layoutHeight * aspectRatio
        } else if (scrollFixInfo.layoutWidth == 0.0 && scrollFixInfo.layoutHeight == 0.0 && scrollFixInfo.aspectRatio != 0.0) {
            layoutHeight = 100.0
            aspectRatio = scrollFixInfo.aspectRatio
            layoutWidth = layoutHeight * aspectRatio
        } else if (scrollFixInfo.layoutWidth != 0.0 && scrollFixInfo.layoutHeight != 0.0 && scrollFixInfo.aspectRatio != 0.0) {
            layoutWidth = scrollFixInfo.layoutWidth
            layoutHeight = scrollFixInfo.layoutHeight
            aspectRatio = scrollFixInfo.aspectRatio
        } else if (scrollFixInfo.layoutWidth != 0.0 && scrollFixInfo.layoutHeight != 0.0 && scrollFixInfo.aspectRatio == 0.0) {
            layoutWidth = scrollFixInfo.layoutWidth
            layoutHeight = scrollFixInfo.layoutHeight
            aspectRatio = layoutWidth / layoutHeight
        } else if (scrollFixInfo.layoutWidth != 0.0 && scrollFixInfo.layoutHeight == 0.0 && scrollFixInfo.aspectRatio != 0.0) {
            layoutWidth = scrollFixInfo.layoutWidth
            aspectRatio = scrollFixInfo.aspectRatio
            layoutHeight = layoutWidth / aspectRatio
        } else if (scrollFixInfo.layoutWidth == 0.0 && scrollFixInfo.layoutHeight != 0.0 && scrollFixInfo.aspectRatio != 0.0) {
            layoutHeight = scrollFixInfo.layoutHeight
            aspectRatio = scrollFixInfo.aspectRatio
            layoutWidth = layoutHeight * aspectRatio
        } else {
            Hilog.error(0x000000, "initComponentSize", TAG + 'else')
        }
    }



    func computedRange() {
        //可显示的条目range数组长度为2并且数组元素内第一项大于等于0并且第二项大于第一项
        if (scrollFixInfo.range.size == 2 && scrollFixInfo.range[0] >= 0 && scrollFixInfo.range[1] > scrollFixInfo.range[0]) {
            vLayoutData = vLayoutData.slice(scrollFixInfo.range[0], scrollFixInfo.range[1])
        } else {
            vLayoutData = vLayoutData
        }
    }

    func computedAlignType() {
        let displayClass: Display = getDefaultDisplaySync();
        let screenWidth: Float64 = px2vp(Float64(displayClass.width).px)().value
        let screenHeight: Float64 = px2vp(Float64(displayClass.height).px)().value

        if (scrollFixInfo.alignType == 0) { //左上
            xOffset = 0.0
            yOffset = 0.0
        } else if (scrollFixInfo.alignType == 1) { //右上
            xOffset = screenWidth - layoutWidth
            yOffset = 0.0

        } else if (scrollFixInfo.alignType == 2) { //左下
            xOffset = 0.0
            yOffset = screenHeight - layoutHeight
        } else if (scrollFixInfo.alignType == 3) { //右下
            xOffset = screenWidth - layoutWidth
            yOffset = screenHeight - layoutHeight
        } else {
            xOffset = scrollFixInfo.xOffset
            yOffset = scrollFixInfo.yOffset
        }

    }


    func build() {
        Column() {
            ForEach(vLayoutData, itemGeneratorFunc: {item: layoutDataType, position: Int64 =>
                vLayoutContent(item, position)
            })
        }
        .onAreaChange({oldValue, newValue =>
            layoutWidth = if(px2vp(newValue.width.px).isSome()) {px2vp(newValue.width.px)().value} else { 0.0}
            layoutHeight = if(px2vp(newValue.height.px).isSome()) { px2vp(newValue.height.px)().value} else { 0.0}
            computedAlignType()
            Hilog.info(0x000000,"layoutWidthHeight", TAG + 'layoutWidth = ${layoutWidth}, layoutHeight = ${layoutHeight}')
        })
        .width( if(scrollFixInfo.sketchMeasure) { 100.percent }else { layoutWidth.vp })
        .height(layoutHeight)
        .aspectRatio(aspectRatio)
        .backgroundColor(scrollFixInfo.bgColor)
        .position(
            x: if(scrollFixInfo.sketchMeasure) { 0.0 } else { xOffset } ,
            y: yOffset
        )
        .padding(
            top: scrollFixInfo.topPadding,
            right: scrollFixInfo.rightPadding,
            bottom: scrollFixInfo.bottomPadding,
            left: scrollFixInfo.leftPadding
        )
        .zIndex(scrollFixInfo.zIndex)
        .margin(
            top: scrollFixInfo.topMargin,
            right: scrollFixInfo.rightMargin,
            bottom: scrollFixInfo.bottomMargin,
            left: scrollFixInfo.leftMargin
        )
    }
}