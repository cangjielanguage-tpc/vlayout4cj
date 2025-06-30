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

    @State var linearAttribute: LinearAttributes = LinearAttributes() //属性

    private var displayClass: Display = getDefaultDisplaySync()
    private var screenHeight: Float64 = px2vp(Float64(displayClass.height).px)().value
    @State var oneRowHeight: Float64 = 0.0 //单行高度
    @State var layoutHeight: Float64 = 0.0 //单行高度
    private var listWidth: Float64 = 0.0 //获取的grid宽度
    private var listHeight: Float64 = 0.0 //获取的grid高度
    private var listItemWidth: Float64 = 0.0 //获取的gridItem宽度
    private var listItemHeight: Float64 = 0.0 //获取的gridItem高度

    protected override func aboutToAppear() {
        vLayoutData = CommonFunc.computedRange(linearAttribute.range, vLayoutData)
    }

   func computedHeight() {
        let rowCount: Int64 = vLayoutData.size
         if (linearAttribute.layoutHeight.value != 0.0) {
            match (linearAttribute.layoutHeight.unitType) {
            	case percent => layoutHeight = linearAttribute.layoutHeight.value * screenHeight
                case _ => layoutHeight = linearAttribute.layoutHeight.value
            }
            oneRowHeight = layoutHeight / Float64(rowCount)
        } else {
            Hilog.error(0x000000, "computedHeight", TAG + 'something else computedHeight')
        }

    }

    func computedExtraHeight(rowCount: Int64) {
        if (linearAttribute.dividerHeight > 0 && layoutHeight > 0.0) {
            layoutHeight = layoutHeight + Float64(linearAttribute.dividerHeight * (rowCount - 1))
        }

        if (linearAttribute.topPadding > 0.0 && layoutHeight > 0.0) {
            layoutHeight = layoutHeight + linearAttribute.topPadding
        }

        if (linearAttribute.bottomPadding > 0.0 && layoutHeight > 0.0) {
            layoutHeight = layoutHeight + linearAttribute.bottomPadding
        }
    }

    func build() {
        List(space: linearAttribute.dividerHeight) {
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
        .width(linearAttribute.layoutWidth)
        .edgeEffect(EdgeEffect.None)
        .padding(
                top: if(linearAttribute.padding.size == 4) {
                    linearAttribute.padding[0]
                } else {
                    linearAttribute.topPadding
                },
                right: if(linearAttribute.padding.size == 4) {
                    linearAttribute.padding[1]
                } else {
                    linearAttribute.rightPadding
                },
                bottom: if(linearAttribute.padding.size == 4) {
                    linearAttribute.padding[2]
                } else {
                    linearAttribute.bottomPadding
                },
                left: if(linearAttribute.padding.size == 4) {
                    linearAttribute.padding[3]
                } else {
                    linearAttribute.leftPadding
                }
            )
        .nestedScroll(NestedScrollOptions(NestedScrollMode.SELF_FIRST, NestedScrollMode.SELF_FIRST))
        .backgroundColor(linearAttribute.bgColor)
        .opacity(linearAttribute.bgOpacity)
        .zIndex(linearAttribute.zIndex)
        .margin(
            top: if(linearAttribute.margin.size == 4) {
                linearAttribute.margin[0]
            } else {
                linearAttribute.topMargin
            },
            right:  if(linearAttribute.margin.size == 4) {
                linearAttribute.margin[1]
            } else {
                linearAttribute.rightMargin
            },
            bottom: if(linearAttribute.margin.size == 4) {
                linearAttribute.margin[2]
            } else {
                linearAttribute.bottomMargin
            },
            left: if(linearAttribute.margin.size == 4) {
                linearAttribute.margin[3]
            } else {
                linearAttribute.leftMargin
            }
        )

    }
}
