/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package ohos_app_cangjie_entry

import ohos.state_macro_manage.*

@Entry
@Component
class OnePlusNLayoutHelperExample {
    private  var vScroller: Scroller = Scroller()

    @Builder func onenLayoutContent(item: layoutDataType) {
        Text("${item.layoutText}")
            .width(100.percent)
            .height(100.percent)
            .border(width: 1.vp, color: Color.BLACK, radius: 0.vp, style: BorderStyle.Solid )
            .fontSize(25)
            .fontColor(Color.BLACK)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Center)
            .textOverflow(TextOverflow.Ellipsis)

    }


    func build() {
        Column(){
            List(scroller: vScroller) {
                ListItem() {
                    OneLayout(
                        vLayoutContent: this.onenLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "18")
                            ],
                        vLayoutAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.0.vp,
                            bgColor: 0xff87e543,
                            margin: [5.0, 5.0, 5.0, 5.0],
                            padding:[5.0, 5.0, 5.0, 5.0]
                        )
                    )
                }

                ListItem() {
                    OneLayout(
                        vLayoutContent: this.onenLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "19")
                            ],
                        vLayoutAttribute: AbstractFullFillAttributes(
                            layoutWidth: 200.0.vp,
                            layoutHeight: 200.0.vp,
                            bgColor: 0xba55d3,
                            margin: [5.0, 5.0, 5.0, 5.0],
                            padding:[5.0, 5.0, 5.0, 5.0]
                        )
                    )
                }

                ListItem() {
                    OneLayout(
                        vLayoutContent: this.onenLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "18")
                            ],
                        vLayoutAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.0.vp,
                            bgColor: 0x808000,
                            margin: [5.0, 5.0, 5.0, 5.0],
                            padding:[5.0, 5.0, 5.0, 5.0]
                        )
                    )
                }

                ListItem() {
                    OneLayout(
                        vLayoutContent: this.onenLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "37"),
                            layoutDataType(layoutText: "38")
                            ],
                        vLayoutAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 120.0.vp,
                            colWeights: [40.0, 45.0],
                            bgColor: 0xff876384,
                            margin: [5.0, 5.0, 5.0, 5.0],
                            padding:[5.0, 5.0, 5.0, 5.0]
                        )
                    )
                }

                ListItem() {
                    OneLayout(
                        vLayoutContent: this.onenLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "39"),
                            layoutDataType(layoutText: "40"),
                            layoutDataType(layoutText: "41"),
                            layoutDataType(layoutText: "42")
                            ],
                        vLayoutAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.0.vp,
                            rowWeights: [10.0, 30.0],
                            colWeights: [40.0, 60.0, 30.0, 30.0],
                            bgColor: 0xffef8ba3,
                            margin: [5.0, 5.0, 5.0, 5.0],
                            padding:[5.0, 5.0, 5.0, 5.0]
                        )
                    )
                }

                ListItem() {
                    OneLayout(
                        vLayoutContent: this.onenLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "43"),
                            layoutDataType(layoutText: "44"),
                            layoutDataType(layoutText: "45")
                            ],
                        vLayoutAttribute: AbstractFullFillAttributes(
                            layoutHeight: 200.0.vp,
                            layoutWidth: 300.0.vp,
                            bgColor: 0xff87e543,
                            colWeights: [33.0, 50.0, 40.0],
                            margin: [5.0, 5.0, 5.0, 5.0],
                            padding:[5.0, 5.0, 5.0, 5.0]
                        )
                    )
                }

                ListItem() {
                    OneLayout(
                        vLayoutContent: this.onenLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "18"),
                            layoutDataType(layoutText: "19"),
                            layoutDataType(layoutText: "20"),
                            layoutDataType(layoutText: "21")
                            ],
                        vLayoutAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.0.vp,
                            bgColor: 0xffd700,
                            rowWeights: [20.0, 20.0],
                            margin: [5.0, 5.0, 5.0, 5.0],
                            padding:[5.0, 5.0, 5.0, 5.0]
                        )
                    )
                }

                ListItem() {
                    OneLayout(
                        vLayoutContent: this.onenLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "18"),
                            layoutDataType(layoutText: "19"),
                            layoutDataType(layoutText: "20"),
                            layoutDataType(layoutText: "21")
                            ],
                        vLayoutAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.0.vp,
                            bgColor: 0xff00ff,
                            colWeights: [20.0, 20.0],
                            margin: [5.0, 5.0, 5.0, 5.0],
                            padding:[5.0, 5.0, 5.0, 5.0]
                        )
                    )
                }

                ListItem() {
                    OneLayout(
                        vLayoutContent: this.onenLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "18"),
                            layoutDataType(layoutText: "19"),
                            layoutDataType(layoutText: "20"),
                            layoutDataType(layoutText: "21"),
                            layoutDataType(layoutText: "22")
                            ],
                        vLayoutAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.0.vp,
                            bgColor: 0xffb6c1,
                            rowWeights: [20.0, 20.0],
                            colWeights: [40.0, 20.0],
                            margin: [5.0, 5.0, 5.0, 5.0],
                            padding:[5.0, 5.0, 5.0, 5.0],
                            hasFooter: true,
                            hasHeader: true
                        )
                    )
                }

                ListItem() {
                    OneLayout(
                        vLayoutContent: this.onenLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "18"),
                            layoutDataType(layoutText: "19"),
                            layoutDataType(layoutText: "20"),
                            layoutDataType(layoutText: "21"),
                            layoutDataType(layoutText: "22"),
                            layoutDataType(layoutText: "23")
                            ],
                        vLayoutAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.0.vp,
                            bgColor: 0xff0000,
                            margin: [5.0, 5.0, 5.0, 5.0],
                            padding:[5.0, 5.0, 5.0, 5.0]
                        )
                    )
                }

            }
        }
        .width(100.percent)
        .height(100.percent)
        .backgroundColor(0xDCDCDC)
    }
}