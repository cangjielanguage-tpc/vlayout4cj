/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package vlayout4cj

import ohos.state_macro_manage.Component
import ohos.state_macro_manage.BuilderParam
import ohos.state_macro_manage.State
import ohos.state_macro_manage.Watch

private const TAG = 'vlayout DEFAULT_LAYOUT '

@Component
public class DefaultLayout {
    @BuilderParam var vLayoutContent: (layoutDataType, Int64, Float64) -> Unit //布局
    var vLayoutData: Array<layoutDataType> = [] //数据源

    @State var defaultAttribute: LinearAttributes = LinearAttributes() //属性

    @State var oneRowHeight: Float64 = 0.0 //单行高度
    @State var layoutHeight: Float64 = 0.0 //list高度
    private var listWidth: Float64 = 0.0 //获取的list高度
    private var listHeight: Float64 = 0.0 //获取的list高度
    private var listItemWidth: Float64 = 0.0 //获取的listItem宽度
    private var listItemHeight: Float64 = 0.0 //获取的listItem高度

    private var displayClass: Display = getDefaultDisplaySync()
    private var screenHeight: Float64 = px2vp(Float64(displayClass.height).px)().value

    protected override func aboutToAppear() {
        vLayoutData = CommonFunc.computedRange(defaultAttribute.range, vLayoutData)
    }

//    func computedHeight() {
//        let rowCount: Int64 = vLayoutData.size
//         if (defaultAttribute.layoutHeight.value != 0.0) {
//            layoutHeight = match (defaultAttribute.layoutHeight.unitType) {
//                case LengthType.px(v) => v
//                case LengthType.vp(v) => v
//                case LengthType.fp(v) => v
//                case LengthType.lpx(v) => v
//                case LengthType.percent(v) => v * screenHeight
//                case _ => 0.0
//            }
//            oneRowHeight = layoutHeight / Float64(rowCount)
//        } else {
//            Hilog.error(0x000000, "computedHeight", TAG + 'something else computedHeight')
//        }
//    }

    func computedExtraHeight(rowCount: Int64) {
        if (defaultAttribute.dividerHeight > 0 && layoutHeight > 0.0) {
            layoutHeight = layoutHeight + Float64(defaultAttribute.dividerHeight * (rowCount - 1))
        }

        if (defaultAttribute.topPadding > 0.0 && layoutHeight > 0.0) {
            layoutHeight = layoutHeight + defaultAttribute.topPadding
        }

        if (defaultAttribute.bottomPadding > 0.0 && layoutHeight > 0.0) {
            layoutHeight = layoutHeight + defaultAttribute.bottomPadding
        }
    }


    func build() {
        List(space: defaultAttribute.dividerHeight) {
            ForEach(vLayoutData, itemGeneratorFunc: {item: layoutDataType, position: Int64 =>
                ListItem() {
                    vLayoutContent(item, position, oneRowHeight)
                }
                .height(oneRowHeight)
                .onAreaChange({oldValue, newValue =>
                    listItemWidth = px2vp(newValue.width.px)().value
                    listItemHeight = px2vp(newValue.height.px)().value
                    layoutHeight = CommonFunc.computedHeight(vLayoutData, defaultAttribute.layoutHeight, screenHeight, TAG)[0]
                    oneRowHeight = CommonFunc.computedHeight(vLayoutData, defaultAttribute.layoutHeight, screenHeight, TAG)[1]
                    Hilog.info(0x000000, "listItem", TAG + 'ListItem listItemWidth = ${listItemWidth}, listItemHeight = ${listItemHeight}')
                })
            })
        }
        .onAreaChange({oldValue, newValue =>
            listWidth = px2vp(newValue.width.px)().value
            listHeight = px2vp(newValue.height.px)().value
            layoutHeight = CommonFunc.computedHeight(vLayoutData, defaultAttribute.layoutHeight, screenHeight, TAG)[0]
            oneRowHeight = CommonFunc.computedHeight(vLayoutData, defaultAttribute.layoutHeight, screenHeight, TAG)[1]
            Hilog.info(0x000000, "list", TAG + 'List listWidth = ${listWidth}, listHeight = ${listHeight}')
        })
        .width(defaultAttribute.layoutWidth)
        .height(defaultAttribute.layoutHeight)
        .edgeEffect(EdgeEffect.None)
        .padding(
            top: if(defaultAttribute.padding.size == 4) {
                defaultAttribute.padding[0]
            } else {
                defaultAttribute.topPadding
            },
            right: if(defaultAttribute.padding.size == 4) {
                defaultAttribute.padding[1]
            } else {
                defaultAttribute.rightPadding
            },
            bottom: if(defaultAttribute.padding.size == 4) {
                defaultAttribute.padding[2]
            } else {
                defaultAttribute.bottomPadding
            },
            left: if(defaultAttribute.padding.size == 4) {
                defaultAttribute.padding[3]
            } else {
                defaultAttribute.leftPadding
            }
        )
        .nestedScroll(NestedScrollOptions(NestedScrollMode.SELF_FIRST, NestedScrollMode.SELF_FIRST))
        .backgroundColor(defaultAttribute.bgColor)
        .opacity(defaultAttribute.bgOpacity)
        .zIndex(defaultAttribute.zIndex)
        .margin(
            top: if(defaultAttribute.margin.size == 4) {
                defaultAttribute.margin[0]
            } else {
                defaultAttribute.topMargin
            },
            right:  if(defaultAttribute.margin.size == 4) {
                defaultAttribute.margin[1]
            } else {
                defaultAttribute.rightMargin
            },
            bottom: if(defaultAttribute.margin.size == 4) {
                defaultAttribute.margin[2]
            } else {
                defaultAttribute.bottomMargin
            },
            left: if(defaultAttribute.margin.size == 4) {
                defaultAttribute.margin[3]
            } else {
                defaultAttribute.leftMargin
            }
        )
    }
}