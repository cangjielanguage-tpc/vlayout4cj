/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package ohos_app_cangjie_entry.level1

import ohos.state_macro_manage.Entry
import ohos.state_macro_manage.Component
import ohos.state_macro_manage.Builder

@Entry
@Component
class TestOneExColWeights {
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
    var data5: Array<layoutDataType> = [
        layoutDataType(layoutText: "0"),
        layoutDataType(layoutText: "1"),
        layoutDataType(layoutText: "2"),
        layoutDataType(layoutText: "3"),
        layoutDataType(layoutText: "4")
    ]
    var data6: Array<layoutDataType> = [
        layoutDataType(layoutText: "0"),
        layoutDataType(layoutText: "1"),
        layoutDataType(layoutText: "2"),
        layoutDataType(layoutText: "3"),
        layoutDataType(layoutText: "4"),
        layoutDataType(layoutText: "5")
    ]
    var data7: Array<layoutDataType> = [
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
            Scroll(Scroller()){
                Column(){
                     Button("back").height(40).margin(top: 5, bottom: 5).fontSize(16)
                        .shape(ShapeType.Capsule).width(95.percent)
                        .stateEffect(true).id("back")
                        .onClick ({ evt =>
                            Router.back()
                        })
                    Text("colWeights 缺省，预期：平均分配------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            bgColor: 0x808000,
                        )
                    )

                    Text("colWeights 长度为1，预期：正常------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            bgColor: 0x808000,
                            colWeights: [10.0]
                        )
                    )

                    Text("colWeights 长度为 > vLayoutData.size，总和 < 100，预期：正常------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            bgColor: 0x808000,
                            colWeights: [20.0,20.0,10.0,5.0,10.0,20.0]
                        )
                    )

                    Text("colWeights 长度为 > vLayoutData.size，总和 < 100， 预期：正常------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            bgColor: 0x808000,
                            colWeights: [20.0,20.0,10.0,55.0,10.0,70.0]
                        )
                    )

                    Text("colWeights 成员 < 0------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            bgColor: 0x808000,
                            colWeights: [-20.0,-20.0,-10.0,-5.0]
                        )
                    )

                    Text("colWeights 2------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            bgColor: 0x808000,
                            colWeights: [20.0,20.0]
                        )
                    )

                    Text("colWeights 3------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            bgColor: 0x808000,
                            colWeights: [20.0,20.0, 20.0]
                        )
                    )

                    Text("colWeights 3------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            bgColor: 0x808000,
                            colWeights: [20.0,20.0, 20.0,10.0,10.0]
                        )
                    )

                    Text("colWeights 3------").height(80).fontSize(14)
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            bgColor: 0x808000,
                            colWeights: [20.0,20.0, 20.0,10.0,10.0,20.0,20.0, 20.0,10.0,10.0]
                        )
                    )

                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data5,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            bgColor: 0x808000,
                            colWeights: [20.0]
                        )
                    )

                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data6,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            bgColor: 0x808000,
                            colWeights: [20.0]
                        )
                    )
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data7,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            bgColor: 0x808000,
                            colWeights: [20.0]
                        )
                    )
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data5,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            bgColor: 0x808000,
                            colWeights: [20.0,20.0]
                        )
                    )
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data6,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            bgColor: 0x808000,
                            colWeights: [20.0,20.0]
                        )
                    )
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data7,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            bgColor: 0x808000,
                            colWeights: [20.0,20.0]
                        )
                    )
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data5,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            bgColor: 0x808000,
                            colWeights: [20.0,20.0,20.0]
                        )
                    )
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data6,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            bgColor: 0x808000,
                            colWeights: [20.0,20.0,20.0]
                        )
                    )
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data7,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            bgColor: 0x808000,
                            colWeights: [20.0,20.0,20.0]
                        )
                    )
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data5,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            bgColor: 0x808000,
                            colWeights: [20.0,20.0,20.0,10.0]
                        )
                    )
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data6,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            bgColor: 0x808000,
                            colWeights: [20.0,20.0,20.0,10.0]
                        )
                    )
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data6,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            bgColor: 0x808000,
                            colWeights: [20.0,20.0,20.0,10.0,10.0]
                        )
                    )
                    OneExLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data7,
                        oneExAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            bgColor: 0x808000,
                            colWeights: [20.0,20.0,20.0,10.0,10.0]
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