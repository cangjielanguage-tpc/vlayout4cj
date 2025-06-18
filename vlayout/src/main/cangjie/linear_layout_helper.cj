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

    @State var vLayoutAttribute: LinearAttributes = LinearAttributes() //属性

    @State var oneRowHeight: Float64 = 0.0 //单行高度
    @State var layoutHeight: Float64 = 0.0 //单行高度
    private var listWidth: Float64 = 0.0 //获取的grid宽度
    private var listHeight: Float64 = 0.0 //获取的grid高度
    private var listItemWidth: Float64 = 0.0 //获取的gridItem宽度
    private var listItemHeight: Float64 = 0.0 //获取的gridItem高度

    protected override func aboutToAppear() {
        computedRange()
    }

    func computedRange() {
        //可显示的条目range数组长度为2并且数组元素内第一项大于等于0并且第二项大于第一项
        let range = if(vLayoutAttribute.range == [0, 0] || vLayoutAttribute.range[1] > vLayoutData.size) {[0, vLayoutData.size] } else {vLayoutAttribute.range }
        if (range.size == 2 && range[0] >= 0 && range[1] > range[0]) {
            vLayoutData = vLayoutData.slice(range[0], range[1])
        } else {
            vLayoutData = vLayoutData
        }
    }

   func computedHeight() {
        let rowCount: Int64 = vLayoutData.size
        layoutHeight = vLayoutAttribute.layoutHeight.value
        oneRowHeight = vLayoutAttribute.layoutHeight.value / Float64(rowCount)
        computedExtraHeight(rowCount)

    }

    func computedExtraHeight(rowCount: Int64) {
        if (vLayoutAttribute.dividerHeight > 0 && layoutHeight > 0.0) {
            layoutHeight = layoutHeight + Float64(vLayoutAttribute.dividerHeight * (rowCount - 1))
        }

        if (vLayoutAttribute.topPadding > 0.0 && layoutHeight > 0.0) {
            layoutHeight = layoutHeight + vLayoutAttribute.topPadding
        }

        if (vLayoutAttribute.bottomPadding > 0.0 && layoutHeight > 0.0) {
            layoutHeight = layoutHeight + vLayoutAttribute.bottomPadding
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
        .height(layoutHeight)
        .width(vLayoutAttribute.layoutWidth)
        .edgeEffect(EdgeEffect.None)
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
        .nestedScroll(NestedScrollOptions(NestedScrollMode.SELF_FIRST, NestedScrollMode.SELF_FIRST))
        .backgroundColor(vLayoutAttribute.bgColor)
        .zIndex(vLayoutAttribute.zIndex)
        .margin(
            top: if(this.vLayoutAttribute.margin.size == 4) {
                this.vLayoutAttribute.margin[0]
            } else {
                this.vLayoutAttribute.topMargin
            },
            right:  if(this.vLayoutAttribute.margin.size == 4) {
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
