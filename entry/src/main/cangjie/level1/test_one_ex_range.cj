/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package ohos_app_cangjie_entry.level1

import ohos.state_macro_manage.Entry
import ohos.state_macro_manage.Component
import ohos.state_macro_manage.Builder

@Entry
@Component
class TestOneExRange {
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
    var data1: Array<layoutDataType> = [
        layoutDataType(layoutText: "0"),
        layoutDataType(layoutText: "1"),
        layoutDataType(layoutText: "2"),
        layoutDataType(layoutText: "3"),
        layoutDataType(layoutText: "4"),
        layoutDataType(layoutText: "5"),
        layoutDataType(layoutText: "6"),
        layoutDataType(layoutText: "8"),
        layoutDataType(layoutText: "9"),
        layoutDataType(layoutText: "10"),
        layoutDataType(layoutText: "11"),
        layoutDataType(layoutText: "12")
    ]

    @Builder func layoutContent(item: layoutDataType) {
        Text("${item.layoutText}")
            .width(100.percent)
            .height(100.percent)
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
            Scroll(Scroller()){
                Column(){
                     Button("back").height(40).margin(top: 5, bottom: 5).fontSize(16)
                        .shape(ShapeType.Capsule).width(95.percent)
                        .stateEffect(true).id("back")
                        .onClick ({ evt =>
                            Router.back()
                        })
                    Text("range 缺省，预期：显示全部 vLayoutData------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000
                        )
                    )

                    Text("range [0,2]，预期：显示文本 ------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                            range:[0,2]
                        )
                    )

                    Text("range [3,7]，预期： ------").height(80).fontSize(14)  // D
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data1,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                            range:[5,20]
                        )
                    )

                    Text("range [120,520]，预期： ------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                            range:[120,520]
                        )
                    )

                    Text("range [0,7]小于等于vLayoutData长度范围[0,13]，预期：显示 7 个 vLayoutData------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                            range:[0,3]
                        )
                    )

                }
            }
            .scrollable(ScrollDirection.Vertical)
            .scrollBar(BarState.On)
            .width(100.percent)
            .height(100.percent)
            .backgroundColor(0xAAAAAA)
        }
        .width(100.percent)
        .height(100.percent)
        .backgroundColor(0xAAAAAA)
    }

}