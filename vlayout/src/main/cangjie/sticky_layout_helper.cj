/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package vlayout4cj

import ohos.state_macro_manage.Component
import ohos.state_macro_manage.BuilderParam
import ohos.state_macro_manage.Builder
import ohos.state_macro_manage.State
import ohos.state_macro_manage.Watch
import ohos.state_macro_manage.Prop


private const TAG = 'vlayout STICKY_LAYOUT '

@Component
public class StickyLayout {
    @BuilderParam var vLayoutContent: (layoutDataType, Int64) -> Unit //布局
    var vLayoutData: Array<layoutDataType> = [] //数据源

    @State @Watch[defaultValueInit] var vLayoutAttribute: FixAreaAttributes = FixAreaAttributes() //属性
    @State var stickyInfo: FixAreaAttributes = FixAreaAttributes() //属性

    @Prop var isSticky: Bool

    private var layoutWidth: Float64 = 0.0 //获取的容器高度
    private var layoutHeight: Float64 = 0.0 //获取的容器高度
    private var aspectRatio: Float64 = 0.0 //宽高比

    protected override func aboutToAppear() {
        defaultValueInit()
        initComponentSize()
        computedRange()
    }

    func defaultValueInit() {
        stickyInfo = FixAreaAttributes(
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

    func initComponentSize() {
        if (stickyInfo.layoutWidth == 0.0 && stickyInfo.layoutHeight == 0.0 && stickyInfo.aspectRatio == 0.0) {
            layoutWidth = 0.0
            layoutHeight = 100.0
            aspectRatio = 0.0
        } else if (stickyInfo.layoutWidth != 0.0 && stickyInfo.layoutHeight == 0.0 && stickyInfo.aspectRatio == 0.0) {
            layoutWidth = stickyInfo.layoutWidth
            aspectRatio = 1.0
            layoutHeight = layoutWidth / aspectRatio
        } else if (stickyInfo.layoutWidth == 0.0 && stickyInfo.layoutHeight != 0.0 && stickyInfo.aspectRatio == 0.0) {
            layoutHeight = stickyInfo.layoutHeight
            aspectRatio = 1.0
            layoutWidth = 0.0
        } else if (stickyInfo.layoutWidth == 0.0 && stickyInfo.layoutHeight == 0.0 && stickyInfo.aspectRatio != 0.0) {
            aspectRatio = stickyInfo.aspectRatio
            layoutHeight = 100.0
            layoutWidth = 100.0 * aspectRatio
        } else if (stickyInfo.layoutWidth != 0.0 && stickyInfo.layoutHeight != 0.0 && stickyInfo.aspectRatio != 0.0) {
            layoutWidth = stickyInfo.layoutWidth
            layoutHeight = stickyInfo.layoutHeight
            aspectRatio = stickyInfo.aspectRatio
        } else if (stickyInfo.layoutWidth != 0.0 && stickyInfo.layoutHeight != 0.0 && stickyInfo.aspectRatio == 0.0) {
            layoutWidth = stickyInfo.layoutWidth
            layoutHeight = stickyInfo.layoutHeight
            aspectRatio = layoutWidth / layoutHeight
        } else if (stickyInfo.layoutWidth != 0.0 && stickyInfo.layoutHeight == 0.0 && stickyInfo.aspectRatio != 0.0) {
            layoutWidth = stickyInfo.layoutWidth
            aspectRatio = stickyInfo.aspectRatio
            layoutHeight = layoutWidth / aspectRatio

        } else if (stickyInfo.layoutWidth == 0.0 && stickyInfo.layoutHeight != 0.0 && stickyInfo.aspectRatio != 0.0) {
            layoutHeight = stickyInfo.layoutHeight
            aspectRatio = stickyInfo.aspectRatio
            layoutWidth = layoutHeight * aspectRatio
        } else {
            Hilog.info(0x000000,"initComponentSize", TAG + 'error')
        }
    }

    func computedRange() {
        //可显示的条目range数组长度为2并且数组元素内第一项大于等于0并且第二项大于第一项
        if (stickyInfo.range.size == 2 && stickyInfo.range[0] >= 0 && stickyInfo.range[1] > stickyInfo.range[0]) {
            vLayoutData = vLayoutData.slice(stickyInfo.range[0], stickyInfo.range[1])
        } else {
            vLayoutData = vLayoutData
        }
    }

    func build() {
        Column() {
            if(isSticky) {
                Stack() {
                    ForEach(this.vLayoutData, itemGeneratorFunc: {item: layoutDataType, position: Int64 =>
                        this.vLayoutContent(item, position)
                    })
                }

                .width(layoutWidth)
                .height(layoutHeight)
                .aspectRatio(aspectRatio)
                .backgroundColor(stickyInfo.bgColor)
                .padding(
                    top: stickyInfo.topPadding,
                    right: stickyInfo.rightPadding,
                    bottom: stickyInfo.bottomPadding,
                    left: stickyInfo.leftPadding
                )
                .zIndex(stickyInfo.zIndex)
                .margin(
                    top: stickyInfo.topMargin,
                    right: stickyInfo.rightMargin,
                    bottom: stickyInfo.bottomMargin,
                    left: stickyInfo.leftMargin
                )
                .position(x: 0.0, y: 0.0)
            } else{
                Stack() {
                    ForEach(this.vLayoutData, itemGeneratorFunc: {item: layoutDataType, position: Int64 =>
                        this.vLayoutContent(item, position)
                    })
                }

                .width(layoutWidth)
                .height(layoutHeight)
                .aspectRatio(aspectRatio)
                .backgroundColor(stickyInfo.bgColor)
                .padding(
                    top: stickyInfo.topPadding,
                    right: stickyInfo.rightPadding,
                    bottom: stickyInfo.bottomPadding,
                    left: stickyInfo.leftPadding
                )
                .zIndex(stickyInfo.zIndex)
                .margin(
                    top: stickyInfo.topMargin,
                    right: stickyInfo.rightMargin,
                    bottom: stickyInfo.bottomMargin,
                    left: stickyInfo.leftMargin
                )
            }

        }
    }
}