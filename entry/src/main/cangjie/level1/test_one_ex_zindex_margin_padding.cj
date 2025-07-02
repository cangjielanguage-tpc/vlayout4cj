/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package ohos_app_cangjie_entry.level1

import ohos.state_macro_manage.Entry
import ohos.state_macro_manage.Component
import ohos.state_macro_manage.Builder

@Entry
@Component
class TestOneExZindexMarginPadding {
    private var vScroller: Scroller = Scroller()
    var data: Array<layoutDataType> = [
        layoutDataType(layoutText: "0"),
        layoutDataType(layoutText: "1"),
        layoutDataType(layoutText: "2"),
        layoutDataType(layoutText: "3"),
        layoutDataType(layoutText: "4"),
        layoutDataType(layoutText: "5"),
        layoutDataType(layoutText: "6")
    ]

    @Builder func layoutContent(item: layoutDataType) {
        Text("${item.layoutText}")
            .width(100.percent)
            .height(100.percent)
            .backgroundColor(Color(0x22EEEEEE))
            .border(width: 1.vp, color: Color.BLACK, radius: 0.vp, style: BorderStyle.Solid )
            .fontSize(25)
            .fontColor(Color(0x999999))
            .fontWeight(FontWeight.Bold)
            .maxLines(1)
            .textAlign(TextAlign.Center)
            .textOverflow(TextOverflow.Ellipsis)
    }

    func build() {
        Stack(Alignment.TopStart) {
            Scroll(Scroller()) {
                Column(){
                     Button("back").height(40).margin(top: 5, bottom: 5).fontSize(16)
                        .shape(ShapeType.Capsule).width(95.percent)
                        .stateEffect(true).id("back")
                        .onClick ({ evt =>
                            Router.back()
                        })
                    Text("zIndex 缺省，预期：0------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                        )
                    )

                    Text("zIndex <= 0，预期：正常------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                            zIndex: -10
                        )
                    )

                    Text("0 < zIndex <= 6，预期：正常------").height(80).fontSize(14)  // D
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                            zIndex: 6
                        )
                    )

                    Text("margin，缺省：默认[]------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000
                        )
                    )

                    Text("margin 元素 < 0，预期：正常------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                            margin:[-10.0,-10.0,-10.0,-10.0]
                        )
                    )

                    Text("0< margin 元素 < 设备高度，预期：正常------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                            margin:[50.0,50.0,50.0,50.0]
                        )
                    )

                    Text("topMargin 缺省，预期：正常------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                        )
                    )

                    Text("topMargin <= 0，预期：正常------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                            topMargin: -20.0
                        )
                    )

                    Text("0 < topMargin <= 设备高度，预期：正常------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                            topMargin: 50.0
                        )
                    )

                    Text("rightMargin 缺省，预期：正常------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                        )
                    )

                    Text("rightMargin <= 0，预期：正常------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                            rightMargin: -20.0
                        )
                    )

                    Text("0 < rightMargin <= 设备高度，预期：正常------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                            rightMargin: 50.0
                        )
                    )

                    Text("bottomMargin 缺省，预期：正常------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                        )
                    )

                    Text("bottomMargin <= 0，预期：正常------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                            bottomMargin: -20.0
                        )
                    )


                    Text("0 < bottomMargin <= 设备高度，预期：正常------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                            bottomMargin: 50.0
                        )
                    )


                    Text("leftMargin 缺省，预期：正常------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                        )
                    )


                    Text("leftMargin <= 0，预期：正常------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                            leftMargin: -20.0
                        )
                    )


                    Text("0 < leftMargin <= 设备高度，预期：正常------").height(80).fontSize(14)
                    Divider().color(0x000000).strokeWidth(1)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                            leftMargin: 50.0
                        )
                    )

                    //----padding----
                    Text("padding，缺省：默认[]------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000
                        )
                    )

                    Text("padding 元素 < 0，预期：正常------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                            padding:[-10.0,-10.0,-10.0,-10.0]
                        )
                    )
                    Text("0< padding 元素 < 设备高度，预期：正常------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                            padding:[50.0,50.0,50.0,50.0]
                        )
                    )

                    Text("topPadding 缺省，预期：正常------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                        )
                    )

                    Text("topPadding <= 0，预期：正常------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                            topMargin: -20.0
                        )
                    )

                    Text("0 < topPadding <= 设备高度，预期：正常------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                            topPadding: 50.0
                        )
                    )

                    Text("rightPadding 缺省，预期：正常------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                        )
                    )

                    Text("rightPadding <= 0，预期：正常------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                            rightPadding: -20.0
                        )
                    )

                    Text("0 < rightPadding <= 设备高度，预期：正常------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                            rightPadding: 50.0
                        )
                    )

                    Text("bottomMargin 缺省，预期：正常------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                        )
                    )

                    Text("bottomPadding <= 0，预期：正常------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                            bottomPadding: -20.0
                        )
                    )

                    Text("0 < bottomPadding <= 设备高度，预期：正常------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                            bottomPadding: 50.0
                        )
                    )

                    Text("leftPadding 缺省，预期：正常------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                        )
                    )

                    Text("leftPadding <= 0，预期：正常------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                            leftPadding: -20.0
                        )
                    )

                    Text("0 < leftPadding <= 设备高度，预期：正常------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                            leftPadding: 50.0
                        )
                    )

                    Text("组合 padding 和 rightPadding ，预期：优先级 padding------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                            padding: [10.0,10.0,10.0,10.0],
                            leftPadding: 50.0
                        )
                    )

                    Text("组合 margin 和 leftMargin ，预期：优先级 margin------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                            margin: [10.0,10.0,10.0,10.0],
                            leftMargin: 50.0
                        )
                    )

                }
            }
            .scrollable(ScrollDirection.Vertical)
            .scrollBar(BarState.On)
        }
        .width(100.percent)
        .height(100.percent)
        .backgroundColor(0xAAAAAA)
    }
}