/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */

package ohos_app_cangjie_entry

import ohos.state_macro_manage.*

@Entry
@Component
class Level1 {
    let arr_L1: Array<String> = [
        "TestGridAspectRatio",
        "TestGridColumnBgColor",
        "TestGridColumnBgOpacity",
        "TestGridColumnLayoutHeight",
        "TestGridColumnRange",
        "TestGridColumnZindexMarginPadding",
        "TestGridColumnSpanCountWeight",
        "TestGridGapVgapHgap",
        "TestRangeGridAspectRatio",
        "TestRangeGridColumnBgColor",
        "TestRangeGridColumnBgOpacity",
        "TestRangeGridColumnLayoutHeight",
        "TestRangeGridColumnRange",
        "TestRangeGridColumnZindexMarginPadding", //13
        "TestRangeGridColumnSpanCountWeight",
        "TestRangeGridGapVgapHgap",
        "TestRangeGridAll",
        "TestOneRange",
        "TestOneLayoutWidth",
        "TestOneLayoutHeight",
        "TestOneBgColor",
        "TestOneBgOpacity",
        "TestOneZindexMarginPadding",
        "TestOneColWeights",
        "TestOneRowWeights",
        "TestOneHasHeaderHasFooter",
        "TestOneVlayoutData",
        "TestOneExRange", // 26
        "TestOneExLayoutWidth",
        "TestOneExLayoutHeight",
        "TestOneExBgColor",
        "TestOneExBgOpacity",
        "TestOneExZindexMarginPadding",
        "TestOneExColWeights",
        "TestOneExRowWeights",
        "TestOneExVlayoutData",
        "TestLinearRange",
        "TestLinearLayoutWidth",
        "TestLinearLayoutHeight",
        "TestLinearBgColor",
        "TestLinearBgOpacity",
        "TestLinearZindexMarginPadding", //39
        "TestLinearDividerHeight",
        "TestSingleRange",
        "TestSingleLayoutWidth",
        "TestSingleLayoutHeight",
        "TestSingleBgColor",
        "TestSingleBgOpacity",
        "TestSingleZindexMarginPadding",
        "TestStaggeredGridBgColor",
        "TestStaggeredStaggeredGridBgOpacity",
        "TestStaggeredGridGapVgapHgap",
        "TestStaggeredGridRange",
        "TestStaggeredGridZindexMarginPadding",
        "TestStaggeredGridStaggeredWidth",
        "TestStaggeredGridLanes", // 52
        "TestJumpBar01",
        "TestJumpBar02",
        "TestLayoutDataType"
    ]
    var scrollerForChild: Scroller = Scroller()
    func build() {
        Stack(Alignment.TopStart) {
            Column {
                Text("-- vlayout4cj-L1-用例 --").id("l1_back").height(80)
                .onClick ({ evt =>
                    Router.back()
                })
                Divider().color(0x000000).strokeWidth(1).margin(top: 10, bottom: 10)

                List(space: 5, scroller: this.scrollerForChild) {
                    ForEach(
                        this.arr_L1,
                        itemGeneratorFunc: {
                            item: String, idx: Int64 =>
                                ListItem {
                                    Button(item).height(40).fontSize(16)
                                        .shape(ShapeType.Capsule).width(95.percent)
                                        .stateEffect(true).id(item)
                                        .onClick {
                                            Router.push(url: item)
                                        }
                                }.width(100.percent)
                        }
                    )
                 }.width(100.percent)
            }.height(85.percent).width(100.percent)

            Column() {
                Button("click1").id("TestRangeGridColumnZindexMarginPaddingIndex").onClick ({ evt =>
                    this.scrollerForChild.scrollToIndex(13,smooth: false, align: ScrollAlign.START)
                }).backgroundColor(Color(0x22ff0000))
                Button("click2").id("TestOneExRangeIndex").onClick ({ evt =>
                    this.scrollerForChild.scrollToIndex(26,smooth: false, align: ScrollAlign.START)
                }).backgroundColor(Color(0x22ff0000))
                Button("click3").id("TestLinearZindexMarginPaddingIndex").onClick ({ evt =>
                    this.scrollerForChild.scrollToIndex(39,smooth: false, align: ScrollAlign.START)
                }).backgroundColor(Color(0x22ff0000))
                Button("click4").id("TestStaggeredGridLanesIndex").onClick ({ evt =>
                    this.scrollerForChild.scrollToIndex(52,smooth: false, align: ScrollAlign.START)
                }).backgroundColor(Color(0x22ff0000))
            }.zIndex(10)
            .position(x: 0, y: 0)
            .alignItems(HorizontalAlign.Start)
            .justifyContent(FlexAlign.Start)
            .border(width: 2.px, color: Color.RED)
        }
        .width(100.percent)
        .height(100.percent)
        .backgroundColor(0xAAAAAA)
    }
}


