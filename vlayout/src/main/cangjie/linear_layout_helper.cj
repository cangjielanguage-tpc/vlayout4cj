/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package vlayout4cj

import ohos.state_macro_manage.Component
import ohos.state_macro_manage.BuilderParam
import ohos.state_macro_manage.State
import ohos.state_macro_manage.Watch
import std.collection.ArrayList

private const TAG = 'vlayout LINEAR_LAYOUT '

@Component
public class LinearLayout {
    @BuilderParam var vLayoutContent: (layoutDataType, Int64, Float64) -> Unit //布局
    var vLayoutData: Array<layoutDataType> = [] //数据源

    @State @Watch[defaultValueInit] var vLayoutAttribute: LinearAttributes = LinearAttributes() //属性
    @State var linearInfo: LinearAttributes = LinearAttributes() //属性

    @State var oneRowHeight: Float64 = 0.0 //单行高度
    @State var layoutHeight: Float64 = 0.0 //grid高度
    private var listWidth: Float64 = 0.0 //获取的grid宽度
    private var listHeight: Float64 = 0.0 //获取的grid高度
    private var listItemWidth: Float64 = 0.0 //获取的gridItem宽度
    private var listItemHeight: Float64 = 0.0 //获取的gridItem高度

    protected override func aboutToAppear() {
        defaultValueInit()
        computedRange()
    }

    func defaultValueInit() {
        linearInfo = LinearAttributes(
            range: if(vLayoutAttribute.range == [0, 0] || vLayoutAttribute.range[1] > vLayoutData.size) {[0, vLayoutData.size] } else {vLayoutAttribute.range } ,
            dividerHeight: vLayoutAttribute.dividerHeight,
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
        if (linearInfo.range.size == 2 && linearInfo.range[0] >= 0 && linearInfo.range[1] > linearInfo.range[0]) {
            vLayoutData = vLayoutData.slice(linearInfo.range[0], linearInfo.range[1])
        } else {
            vLayoutData = vLayoutData
        }
    }

   func computedHeight() {
        let rowCount: Int64 = vLayoutData.size
        if (linearInfo.layoutHeight == 0.0 && linearInfo.aspectRatio == 0.0) {
            layoutHeight = listItemHeight * Float64(rowCount)
            computedExtraHeight(rowCount)
        } else if (linearInfo.layoutHeight == 0.0 && linearInfo.aspectRatio > 0.0) {
            oneRowHeight = listWidth / linearInfo.aspectRatio
            layoutHeight = oneRowHeight * Float64(rowCount)
            computedExtraHeight(rowCount)
        } else if (linearInfo.layoutHeight != 0.0 && linearInfo.aspectRatio > 0.0) {
            oneRowHeight = listWidth / linearInfo.aspectRatio
        } else if (linearInfo.layoutHeight != 0.0 && linearInfo.aspectRatio == 0.0) {
            oneRowHeight = linearInfo.layoutHeight / Float64(rowCount)
        } else {
            Hilog.error(0xffa500,"computedHeight", TAG + 'something else computedHeight')
        }
    }

    func computedExtraHeight(rowCount: Int64) {
        if (linearInfo.dividerHeight > 0 && layoutHeight > 0.0) {
            layoutHeight = layoutHeight + Float64(linearInfo.dividerHeight * (rowCount - 1))
        }

        if (linearInfo.topPadding > 0.0 && layoutHeight > 0.0) {
            layoutHeight = layoutHeight + linearInfo.topPadding
        }

        if (linearInfo.bottomPadding > 0.0 && layoutHeight > 0.0) {
            layoutHeight = layoutHeight + linearInfo.bottomPadding
        }
    }

    func build() {
        List(space: vLayoutAttribute.dividerHeight) {
            ForEach(vLayoutData, itemGeneratorFunc: {item: layoutDataType, position: Int64 =>
                ListItem() {
                    vLayoutContent(item, position, oneRowHeight)
                }
                .height(oneRowHeight)
                .onAreaChange({oldValue, newValue =>
                    listItemWidth = px2vp(newValue.width.px)().value
                    listItemHeight = px2vp(newValue.height.px)().value
                    computedHeight()
                     Hilog.info(0x008000, "listItem", TAG + 'ListItem listItemWidth = ${listItemWidth}, listItemHeight = ${listItemHeight}')
                })
            })
        }
        .onAreaChange({oldValue, newValue =>
            listWidth = px2vp(newValue.width.px)().value
            listHeight = px2vp(newValue.height.px)().value
            computedHeight()
            Hilog.info(0x008000,"list", TAG + 'List listWidth = ${listWidth}, listHeight = ${listHeight}')
        })
        .height(if(linearInfo.layoutHeight == 0.0) { layoutHeight} else { linearInfo.layoutHeight })
        .edgeEffect(EdgeEffect.None)
        .padding(
            top: linearInfo.topPadding,
            right: linearInfo.rightPadding,
            bottom: linearInfo.bottomPadding,
            left: linearInfo.leftPadding
        )
        .nestedScroll(NestedScrollOptions(NestedScrollMode.SELF_FIRST, NestedScrollMode.SELF_FIRST))
        .backgroundColor(linearInfo.bgColor)
        .zIndex(linearInfo.zIndex)
        .margin(
            top: linearInfo.topMargin,
            right: linearInfo.rightMargin,
            bottom: linearInfo.bottomMargin,
            left: linearInfo.leftMargin
        )

    }
}
