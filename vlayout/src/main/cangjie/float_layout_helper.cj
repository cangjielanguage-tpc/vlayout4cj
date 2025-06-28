/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package vlayout4cj

import ohos.state_macro_manage.Component
import ohos.state_macro_manage.BuilderParam
import ohos.state_macro_manage.State

private const TAG = 'vlayout FLOAT_LAYOUT '

@Component
public class FloatLayout {
    @BuilderParam var vLayoutContent: (layoutDataType, Int64) -> Unit //布局
    var vLayoutData: Array<layoutDataType> = [] //数据源

    @State var floatAttribute: FixAreaAttributes = FixAreaAttributes() //属性

    private var layoutWidth: Float64 = 0.0 //获取的容器高度
    private var layoutHeight: Float64 = 0.0 //获取的容器高度
    private var aspectRatio: Float64 = 0.0 //宽高比
    @State var xOffset: Float64 = 0.0 // x偏移
    @State var yOffset: Float64 = 0.0 //y偏移
    private  var yyOffset: Float64 = 0.0 //y偏移
    @State var imitatorShow: Bool = false //模拟块是否显示
    @State var imitatorWidth: Float64 = 0.0 //模拟块宽度
    @State var imitatorHeight: Float64 = 0.0 //模拟块高度

    private var displayClass: Display = getDefaultDisplaySync()
    private var screenWidth: Float64 = px2vp(Float64(displayClass.width).px)().value
    private var screenHeight: Float64 = px2vp(Float64(displayClass.height).px)().value

    protected override func aboutToAppear() {
        vLayoutData = CommonFunc.computedRange(floatAttribute.range, vLayoutData)
        layoutWidth = CommonFunc.initComponentSize(floatAttribute.layoutWidth, floatAttribute.layoutHeight, floatAttribute.aspectRatio)[0]
        layoutHeight = CommonFunc.initComponentSize(floatAttribute.layoutWidth, floatAttribute.layoutHeight, floatAttribute.aspectRatio)[1]
        aspectRatio = CommonFunc.initComponentSize(floatAttribute.layoutWidth, floatAttribute.layoutHeight, floatAttribute.aspectRatio)[2]
        xOffset = CommonFunc.computedAlignType(
            floatAttribute.xOffset,
            floatAttribute.yOffset,
            floatAttribute.alignType,
            screenWidth,
            screenHeight,
            layoutWidth,
            layoutHeight
            )[0]
        yOffset = CommonFunc.computedAlignType(
            floatAttribute.xOffset,
            floatAttribute.yOffset,
            floatAttribute.alignType,
            screenWidth,
            screenHeight,
            layoutWidth,
            layoutHeight
            )[1]

        if (floatAttribute.defaultLocation.size == 2) {
            xOffset = xOffset + floatAttribute.defaultLocation[0]
            yOffset = yOffset + floatAttribute.defaultLocation[1]
        }
    }

    func build() {
        Stack() {
            ForEach(vLayoutData, itemGeneratorFunc: {item: layoutDataType, position: Int64 =>
                vLayoutContent(item, position)
                if (imitatorShow) {
                    Stack() {
                        vLayoutContent(item, position)
                    }
                    .width(imitatorWidth)
                    .height(imitatorHeight)
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
                    imitatorWidth = areaInfo.width
                    imitatorHeight = areaInfo.height
                    xOffset = areaInfo.globalPosition.x
                    yOffset = if(yyOffset == 0.0) {areaInfo.globalPosition.y } else { yyOffset }
                    //拷贝完成，展示模拟块
                    imitatorShow = true
                case TouchType.Move =>
                    xOffset = event.touches[0].screenX - imitatorWidth / 2.0
                    yOffset = event.touches[0].screenY - imitatorHeight / 2.0
                case TouchType.Up =>
                    imitatorShow = false
                    if (xOffset < screenWidth / 2.0) {
                        xOffset = 0.0
                    } else {
                        xOffset = screenWidth - imitatorWidth
                    }
                    yyOffset = yOffset

                case TouchType.Cancel =>
                    Hilog.error(0x000000, "TouchType", "${TAG} Cancel")
                case _ =>
                    Hilog.error(0x000000, "TouchType", "${TAG} else")
            }

        })
        .id("FLOAT")
        .width(layoutWidth)
        .height(layoutHeight)
        .aspectRatio(aspectRatio)
        .backgroundColor(floatAttribute.bgColor)
        .opacity(floatAttribute.bgOpacity)
        .position(
            x: xOffset,
            y: yOffset
        )
        .padding(
            top: if(floatAttribute.padding.size == 4) {
                floatAttribute.padding[0]
            } else {
                floatAttribute.topPadding
            },
            right: if(floatAttribute.padding.size == 4) {
                floatAttribute.padding[1]
            } else {
                floatAttribute.rightPadding
            },
            bottom: if(floatAttribute.padding.size == 4) {
                floatAttribute.padding[2]
            } else {
                floatAttribute.bottomPadding
            },
            left: if(floatAttribute.padding.size == 4) {
                floatAttribute.padding[3]
            } else {
                floatAttribute.leftPadding
            }
        )
        .zIndex(floatAttribute.zIndex)
        .margin(
            top: if(this.floatAttribute.margin.size == 4) {
                this.floatAttribute.margin[0]
            } else {
                this.floatAttribute.topMargin
            },
            right: if(this.floatAttribute.margin.size == 4) {
                this.floatAttribute.margin[1]
            } else {
                this.floatAttribute.rightMargin
            },
            bottom: if(this.floatAttribute.margin.size == 4) {
                this.floatAttribute.margin[2]
            } else {
                this.floatAttribute.bottomMargin
            },
            left: if(this.floatAttribute.margin.size == 4) {
                this.floatAttribute.margin[3]
            } else {
                this.floatAttribute.leftMargin
            }
        )
    }
}