/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package vlayout4cj.commons

import ohos.state_macro_manage.Component
import ohos.state_macro_manage.BuilderParam
import ohos.state_macro_manage.State

@Component
public class ScrollFixFloatLayoutCommon {
    @BuilderParam var vLayoutContent: (layoutDataType, Int64) -> Unit //布局
    @State var vLayoutAttribute: FixAreaAttributes = FixAreaAttributes() //属性
    var vLayoutData: Array<layoutDataType> = [] //数据源
    var layoutType: String = ""
    var TAG: String = ""

    private var layoutWidth: Float64 = 0.0 //获取的容器高度
    private var layoutHeight: Float64 = 0.0 //获取的容器高度
    private var aspectRatio: Float64 = 0.0 //宽高比
    @State var xOffset: Float64 = 0.0 // x偏移
    @State var yOffset: Float64 = 0.0 //y偏移

    private var screenWidth: Float64 = 0.0
    private var screenHeight: Float64 = 0.0


    protected override func aboutToAppear() {
        var displayClass: Display = getDefaultDisplaySync()
        screenWidth = px2vp(Float64(displayClass.width).px)().value
        screenHeight = px2vp(Float64(displayClass.height).px)().value
        vLayoutData = CommonFunc.computedRange(vLayoutAttribute.range, vLayoutData)
        layoutWidth = CommonFunc.initComponentSize(
            vLayoutAttribute.layoutWidth,
            vLayoutAttribute.layoutHeight,
            vLayoutAttribute.aspectRatio
            )[0]
        layoutHeight = CommonFunc.initComponentSize(
            vLayoutAttribute.layoutWidth,
            vLayoutAttribute.layoutHeight,
            vLayoutAttribute.aspectRatio
            )[1]
        aspectRatio = CommonFunc.initComponentSize(
            vLayoutAttribute.layoutWidth,
            vLayoutAttribute.layoutHeight,
            vLayoutAttribute.aspectRatio
            )[2]
        xOffset = CommonFunc.computedAlignType(vLayoutAttribute.xOffset,vLayoutAttribute.yOffset,vLayoutAttribute.alignType,screenWidth,screenHeight,layoutWidth,layoutHeight)[0]
        yOffset = CommonFunc.computedAlignType(vLayoutAttribute.xOffset,vLayoutAttribute.yOffset,vLayoutAttribute.alignType,screenWidth,screenHeight,layoutWidth,layoutHeight)[1]
    }

    func build() {
        Column() {
            ForEach(vLayoutData, itemGeneratorFunc: {item: layoutDataType, position: Int64 =>
                vLayoutContent(item, position)
            })
        }
        .onAreaChange({oldValue, newValue =>
            xOffset = CommonFunc.computedAlignType(vLayoutAttribute.xOffset,vLayoutAttribute.yOffset,vLayoutAttribute.alignType,screenWidth,screenHeight,layoutWidth,layoutHeight)[0]
            yOffset = CommonFunc.computedAlignType(vLayoutAttribute.xOffset,vLayoutAttribute.yOffset,vLayoutAttribute.alignType,screenWidth,screenHeight,layoutWidth,layoutHeight)[1]
            Hilog.info(0x000000, "layout", TAG + 'layoutWidth = ${layoutWidth}, layoutHeight = ${layoutHeight}')
        })
        .width( if(vLayoutAttribute.sketchMeasure) { 100.percent }else { layoutWidth.vp })
        .height(layoutHeight)
        .aspectRatio(aspectRatio)
        .backgroundColor(vLayoutAttribute.bgColor)
        .opacity(vLayoutAttribute.bgOpacity)
        .position(
            x: if(vLayoutAttribute.sketchMeasure) { 0.0 } else { xOffset } ,
            y: yOffset
        )
        .padding(
            top: if(vLayoutAttribute.padding.size == 4) {
                vLayoutAttribute.padding[0]
            } else {
                vLayoutAttribute.topPadding
            },
            right: if(vLayoutAttribute.padding.size == 4) {
                vLayoutAttribute.padding[1]
            } else {
                vLayoutAttribute.rightPadding
            },
            bottom: if(vLayoutAttribute.padding.size == 4) {
                vLayoutAttribute.padding[2]
            } else {
                vLayoutAttribute.bottomPadding
            },
            left: if(vLayoutAttribute.padding.size == 4) {
                vLayoutAttribute.padding[3]
            } else {
                vLayoutAttribute.leftPadding
            }
        )
        .zIndex(vLayoutAttribute.zIndex)
        .margin(
            top: if(this.vLayoutAttribute.margin.size == 4) {
                this.vLayoutAttribute.margin[0]
            } else {
                this.vLayoutAttribute.topMargin
            },
            right: if(this.vLayoutAttribute.margin.size == 4) {
                this.vLayoutAttribute.margin[1]
            } else {
                this.vLayoutAttribute.rightMargin
            },
            bottom: if(this.vLayoutAttribute.margin.size == 4) {
                this.vLayoutAttribute.margin[2]
            } else {
                this.vLayoutAttribute.bottomMargin
            },
            left: if(this.vLayoutAttribute.margin.size == 4) {
                this.vLayoutAttribute.margin[3]
            } else {
                this.vLayoutAttribute.leftMargin
            }
        )
    }
}