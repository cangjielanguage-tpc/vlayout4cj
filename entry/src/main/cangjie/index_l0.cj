package ohos_app_cangjie_entry

import ohos.state_macro_manage.*


@Entry
@Component
class Level0 {
    let arr_L0: Array<String> = [
        "TestBannerRange",
        "TestBannerLayoutWidth",
        "TestBannerLayoutHeight",
        "TestBannerBgColor",
        "TestBannerBgOpacity",
        "TestBannerLayoutIndex",
        "TestBannerLayoutAutoPlay",
        "TestBannerLayoutInterval",
        "TestBannerLayoutIndicator",
        "TestBannerLayoutLoopDuration",
        "TestBannerLayoutVerticalItemSpace",
        "TestBannerLayoutEffectMode",
        "TestBannerZindexMargin",
        "TestColumnRange",
        "TestColumnLayoutWidth",
        "TestColumnLayoutHeight",
        "TestColumnBgColor",
        "TestColumnBgOpacity",
        "TestColumnZindexMarginPadding",
        "TestColumnColWeights",
        "TestDefaultRange",
        "TestDefaultLayoutWidth",
        "TestDefaultLayoutHeight",
        "TestDefaultBgColor",
        "TestDefaultBgOpacity",
        "TestDefaultZindexMarginPadding",
        "TestDefaultDividerHeight",
        "TestFixRange",
        "TestFixBgColor",
        "TestFixBgOpacity",
        "TestFixLayoutWidth",
        "TestFixLayoutHeight",
        "TestFixAspectRatio",
        "TestFixLayoutWidthHeightAspectRatio",
        "TestFixAlignType",
        "TestFixXOffsetYOffset",
        "TestFixXOffsetYOffsetAlignType",
        "TestFixSketchMeasure",
        "TestFixIndexMarginPadding",
        "TestScrollFixRange",
        "TestScrollFixBgColor",
        "TestScrollFixBgOpacity",
        "TestScrollFixLayoutWidth",
        "TestScrollFixLayoutHeight",
        "TestScrollFixAspectRatio",
        "TestScrollFixLayoutWidthHeightAspectRatio",
        "TestScrollFixAlignType",
        "TestScrollFixXOffsetYOffset",
        "TestScrollFixXOffsetYOffsetAlignType",
        "TestScrollFixSketchMeasure",
        "TestScrollFixIndexMarginPadding",
        "TestFloatRange",
        "TestFloatBgColor",
        "TestFloatBgOpacity",
        "TestFloatLayoutWidth",
        "TestFloatLayoutHeight",
        "TestFloatAspectRatio",
        "TestFloatLayoutWidthHeightAspectRatio",
        "TestFloatAlignType",
        "TestFloatXOffsetYOffset",
        "TestFloatXOffsetYOffsetAlignType",
        "TestFloatIndexMarginPadding",
        "TestFloatDefaultLocation",
        "TestStickyBgColor",
        "TestStickyBgOpacity",
        "TestStickyLayoutWidth",
        "TestStickyLayoutHeight",
        "TestStickyZindexMarginPadding",
        "TestStickyAspectRatio",
        "TestStickyFixLayoutWidthHeightAspectRatio",
        "TestStickyIsSticky"
    ]
    var scrollerl0: Scroller = Scroller()
    var scrollerForChild: Scroller = Scroller()
    func build() {
        Stack(Alignment.TopStart) {
            Column {
                Text("-- vlayout4cj-L0-用例 --").id("l0_back").height(80)
                .onClick ({ evt =>
                    Router.back()
                })
                Divider().color(0x000000).strokeWidth(1).margin(top: 10, bottom: 10)

                List(space: 5, scroller: this.scrollerForChild) {
                    ForEach(
                        this.arr_L0,
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
                Button("click1").id("TestColumnRangeIndex").onClick ({ evt =>
                    this.scrollerForChild.scrollToIndex(13,smooth: false, align: ScrollAlign.START)
                }).backgroundColor(Color(0x22ff0000))
                Button("click2").id("TestFixRangeIndex").onClick ({ evt =>
                    this.scrollerForChild.scrollToIndex(27,smooth: false, align: ScrollAlign.START)
                }).backgroundColor(Color(0x22ff0000))
                Button("click3").id("TestScrollFixBgColorIndex").onClick ({ evt =>
                    this.scrollerForChild.scrollToIndex(40,smooth: false, align: ScrollAlign.START)
                }).backgroundColor(Color(0x22ff0000))
                Button("click4").id("TestFloatBgOpacityIndex").onClick ({ evt =>
                    this.scrollerForChild.scrollToIndex(53,smooth: false, align: ScrollAlign.START)
                }).backgroundColor(Color(0x22ff0000))
                Button("click5").id("TestStickyLayoutHeightIndex").onClick ({ evt =>
                    this.scrollerForChild.scrollToIndex(66,smooth: false, align: ScrollAlign.START)
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


