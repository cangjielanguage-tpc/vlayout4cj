/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package vlayout4cj

import ohos.state_macro_manage.Component
import ohos.state_macro_manage.BuilderParam
import ohos.state_macro_manage.State
import ohos.state_macro_manage.Watch

private const TAG = 'vlayout SINGLE_LAYOUT '

@Component
public class SingleLayout {
    @BuilderParam var vLayoutContent: (layoutDataType, Int64) -> Unit //布局
    var vLayoutData: Array<layoutDataType> = [] //数据源

    @State @Watch[defaultValueInit] var vLayoutAttribute: AbstractFullFillAttributes = AbstractFullFillAttributes() //属性
    @State var singleInfo: AbstractFullFillAttributes = AbstractFullFillAttributes() //属性

    private var itemWidth: Float64 = 0.0 //每个item的宽度
    private var itemHeight: Float64 = 0.0 //每个item的高度

    private var layoutWidth: Float64 = 0.0 //获取的容器高度
    private var layoutHeight: Float64 = 0.0 //获取的容器高度
    private var aspectRatio: Float64 = 0.0 //宽高比

    let displayClass: Display = getDefaultDisplaySync()
    let screenWidth: Float64 = px2vp(Float64(displayClass.width).px)().value
    let screenHeight: Float64 = px2vp(Float64(displayClass.height).px)().value

    protected override func aboutToAppear() {
        defaultValueInit()
        initComponentSize()
        computedRange()
    }

    func defaultValueInit() {
        singleInfo = AbstractFullFillAttributes(
            range: if(vLayoutAttribute.range == [0, 0] || vLayoutAttribute.range[1] > vLayoutData.size) {[0, vLayoutData.size] } else {vLayoutAttribute.range } ,
            layoutWidth: vLayoutAttribute.layoutWidth,
            layoutHeight: vLayoutAttribute.layoutHeight,
            aspectRatio: vLayoutAttribute.aspectRatio,
            bgColor: vLayoutAttribute.bgColor,
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

    }
    func computedRange() {
        //可显示的条目range数组长度为2并且数组元素内第一项大于等于0并且第二项大于第一项
        if (singleInfo.range.size == 2 && singleInfo.range[0] >= 0 && singleInfo.range[1] > singleInfo.range[0]) {
            vLayoutData = vLayoutData.slice(singleInfo.range[0], singleInfo.range[1])
        } else {
            vLayoutData = vLayoutData
        }
    }

    func initComponentSize() {
        if (singleInfo.layoutWidth == 0.0 && singleInfo.layoutHeight == 0.0 && singleInfo.aspectRatio == 0.0) {
            //当不设置容器宽度、高度、纵横比时，宽度默认屏幕宽度，纵横比默认1；
            layoutWidth = screenWidth
            aspectRatio = 1.0
            layoutHeight = layoutWidth / aspectRatio
        } else if (singleInfo.layoutWidth != 0.0 && singleInfo.layoutHeight == 0.0 && singleInfo.aspectRatio == 0.0) {
            //当设置容器宽度，不设置高度、纵横比时，纵横比默认1；
            layoutWidth = singleInfo.layoutWidth
            aspectRatio = 1.0
            layoutHeight = layoutWidth / aspectRatio
        } else if (singleInfo.layoutWidth == 0.0 && singleInfo.layoutHeight != 0.0 && singleInfo.aspectRatio == 0.0) {
            layoutWidth = screenWidth
            layoutHeight = singleInfo.layoutHeight
            aspectRatio = layoutWidth / layoutHeight
        } else if (singleInfo.layoutWidth == 0.0 && singleInfo.layoutHeight == 0.0 && singleInfo.aspectRatio != 0.0) {
            layoutWidth = screenWidth
            layoutHeight = layoutWidth / singleInfo.aspectRatio
            aspectRatio = singleInfo.aspectRatio
        } else if (singleInfo.layoutWidth != 0.0 && singleInfo.layoutHeight != 0.0 && singleInfo.aspectRatio != 0.0) {
            layoutWidth = singleInfo.layoutWidth
            layoutHeight = singleInfo.layoutHeight
            aspectRatio = singleInfo.aspectRatio
        } else if (singleInfo.layoutWidth != 0.0 && singleInfo.layoutHeight != 0.0 && singleInfo.aspectRatio == 0.0) {
            layoutWidth = singleInfo.layoutWidth
            layoutHeight = singleInfo.layoutHeight
            aspectRatio = layoutWidth / layoutHeight
        } else if (singleInfo.layoutWidth != 0.0 && singleInfo.layoutHeight == 0.0 && singleInfo.aspectRatio != 0.0) {
            layoutWidth = singleInfo.layoutWidth
            layoutHeight = layoutWidth / singleInfo.aspectRatio
            aspectRatio = singleInfo.aspectRatio
        } else if (singleInfo.layoutWidth == 0.0 && singleInfo.layoutHeight != 0.0 && singleInfo.aspectRatio != 0.0) {
            layoutWidth = singleInfo.layoutHeight * singleInfo.aspectRatio
            layoutHeight = singleInfo.layoutHeight
            aspectRatio = singleInfo.aspectRatio
        } else {
            Hilog.error(0x000000, "computedSize", '${TAG}computedSize else')
        }
    }

    func computedHeight() {
        layoutHeight = itemHeight
        computedExtraHeight()
    }

    func computedExtraHeight() {
        layoutHeight = layoutHeight + singleInfo.topPadding
        layoutHeight = layoutHeight + singleInfo.bottomPadding
    }


    func build() {
        Column() {
            Stack(){
                ForEach(vLayoutData, itemGeneratorFunc: {item: layoutDataType, position: Int64 =>
                    Column() {
                        vLayoutContent(item, position)
                    }
                    .onAreaChange({oldValue, newValue =>
                        itemWidth = px2vp(newValue.width.px)().value
                        itemHeight = px2vp(newValue.height.px)().value
                        Hilog.info(0x000000,"item", TAG + 'itemWidth = ${itemWidth}, itemHeight = ${itemHeight}')
                    })
                })
            }
            .width(layoutWidth)
            .height(layoutHeight)
            .padding(
                top: singleInfo.topPadding,
                right: singleInfo.rightPadding,
                bottom: singleInfo.bottomPadding,
                left: singleInfo.leftPadding
            )
        }
        .backgroundColor(singleInfo.bgColor)
        .zIndex(singleInfo.zIndex)
        .margin(
            top: singleInfo.topMargin,
            right: singleInfo.rightMargin,
            bottom: singleInfo.bottomMargin,
            left: singleInfo.leftMargin
        )

    }
}