/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package ohos_app_cangjie_entry

import ohos.state_macro_manage.*

@Entry
@Component
class OnePlusNExLayoutHelperExample {
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
                    OneExLayout(
                        vLayoutContent: this.onenLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "23"),
                            layoutDataType(layoutText: "24"),
                            layoutDataType(layoutText: "25"),
                            layoutDataType(layoutText: "26"),
                            layoutDataType(layoutText: "27")
                            ],
                        vLayoutAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.0.vp,
                            bgColor: 0xff87e543,
                            topMargin: 5.0,
                            bottomMargin: 5.0
                        )
                    )
                }

                ListItem() {
                    OneExLayout(
                        vLayoutContent: this.onenLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "28"),
                            layoutDataType(layoutText: "29"),
                            layoutDataType(layoutText: "30"),
                            layoutDataType(layoutText: "31"),
                            layoutDataType(layoutText: "32")
                            ],
                        vLayoutAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.0.vp,
                            bgColor: 0xba55d3,
                            colWeights: [40.0, 45.0, 15.0, 60.0, 0.0],
                            topMargin: 5.0,
                            bottomMargin: 5.0,
                        )
                    )
                }

                ListItem() {
                    OneExLayout(
                        vLayoutContent: this.onenLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "33"),
                            layoutDataType(layoutText: "34"),
                            layoutDataType(layoutText: "35"),
                            layoutDataType(layoutText: "36"),
                            layoutDataType(layoutText: "37")
                            ],
                        vLayoutAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.0.vp,
                            bgColor: 0x808000,
                            colWeights: [20.0, 80.0, 0.0, 60.0, 20.0],
                            topMargin: 5.0,
                            bottomMargin: 5.0
                        )
                    )
                }

                ListItem() {
                    OneExLayout(
                        vLayoutContent: this.onenLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "38"),
                            layoutDataType(layoutText: "39"),
                            layoutDataType(layoutText: "40"),
                            layoutDataType(layoutText: "41"),
                            layoutDataType(layoutText: "42"),
                            layoutDataType(layoutText: "43")
                            ],
                        vLayoutAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.0.vp,
                            bgColor: 0xff876384,
                            topMargin: 5.0,
                            bottomMargin: 5.0
                        )
                    )
                }

                ListItem() {
                    OneExLayout(
                        vLayoutContent: this.onenLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "44"),
                            layoutDataType(layoutText: "45"),
                            layoutDataType(layoutText: "46"),
                            layoutDataType(layoutText: "47"),
                            layoutDataType(layoutText: "48"),
                            layoutDataType(layoutText: "49"),
                            layoutDataType(layoutText: "50")
                            ],
                        vLayoutAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.0.vp,
                            bgColor: 0xffef8ba3,
                            topMargin: 5.0,
                            bottomMargin: 5.0
                        )
                    )
                }

                ListItem() {
                    OneExLayout(
                        vLayoutContent: this.onenLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "51"),
                            layoutDataType(layoutText: "52"),
                            layoutDataType(layoutText: "53"),
                            layoutDataType(layoutText: "54"),
                            layoutDataType(layoutText: "55"),
                            layoutDataType(layoutText: "56"),
                            layoutDataType(layoutText: "57")
                            ],
                        vLayoutAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.0.vp,
                            bgColor: 0xff87e543,
                            colWeights: [40.0, 45.0, 15.0, 60.0, 0.0, 30.0, 30.0],
                            topMargin: 5.0,
                            bottomMargin: 5.0
                        )
                    )
                }

                ListItem() {
                    OneExLayout(
                        vLayoutContent: this.onenLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "58"),
                            layoutDataType(layoutText: "59"),
                            layoutDataType(layoutText: "60"),
                            layoutDataType(layoutText: "61"),
                            layoutDataType(layoutText: "62"),
                            layoutDataType(layoutText: "63"),
                            layoutDataType(layoutText: "64")
                            ],
                        vLayoutAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.0.vp,
                            bgColor: 0xffd700,
                            colWeights: [30.0, 20.0, 50.0, 40.0, 30.0, 35.0, 35.0]
                        )
                    )
                }

                ListItem() {
                    OneExLayout(
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
                    OneExLayout(
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
                    OneExLayout(
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