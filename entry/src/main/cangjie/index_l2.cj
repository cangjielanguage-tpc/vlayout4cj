/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */

package ohos_app_cangjie_entry

import ohos.state_macro_manage.*

@Entry
@Component
class Level2 {
    let arr_L2: Array<String> = [
        "TestBannerRangeIssue01",
        "TestBannerBgOpacityIssue01",
        "TestBannerLayoutIndexIntervalDuration",
        "TestColumnColWeightsIssue",
        "TestDefaultLayoutHeightIssue",
        "TestFixAlignTypeIssue",
        "TestGridAspectRatioIssue",
        "TestGridGapVgapHgapIssue",
        "TestGridSpanCountWeightIssue",
        "TestLinearLayoutHeightIssue",
        "TestOneColWeightsIssue",
        "TestOneHasHeaderHasFooterIssue",
        "TestStaggeredGridRangeIssue",
        "TestStaggeredGridStaggeredWidthIssue1",
        "TestStickyLayoutWidthIssue",
        "TestStaggeredGridLanesIssue",
        "TestFloatLayoutWidthIssue"
    ]
    var scrollerForChild: Scroller = Scroller()
    func build() {
           Stack(Alignment.TopStart) {
                Column {
                    Text("-- vlayout4cj-L2-用例 --").id("l2_back").height(80)
                    .onClick ({ evt =>
                        Router.back()
                    })
                    Divider().color(0x000000).strokeWidth(1).margin(top: 10, bottom: 10)

                    List(space: 5, scroller: this.scrollerForChild) {
                    ForEach(
                        this.arr_L2,
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
                Button("click1").id("TestLinearLayoutHeightIssueIndex").onClick ({ evt =>
                    this.scrollerForChild.scrollToIndex(13,smooth: false, align: ScrollAlign.START)
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


