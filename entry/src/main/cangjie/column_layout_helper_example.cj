/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package ohos_app_cangjie_entry

import ohos.state_macro_manage.*



@Entry
@Component
class ColumnLayoutHelperExample {
    private var vScroller: Scroller = Scroller()

    @Builder func columnLayoutContent(item: layoutDataType, position: Int64, layoutHeight: Float64) {
        Text("${item.layoutText}")
            .width(100.percent)
            .height(100.percent)
            .backgroundColor(0xEEEEEE)
            .border(width: 1.vp, color: Color.BLACK, radius: 0.vp, style: BorderStyle.Solid )
            .fontSize(25)
            .fontColor(Color(0x999999))
            .fontWeight(FontWeight.Bold)
            .maxLines(1)
            .textAlign(TextAlign.Center)
            .textOverflow(TextOverflow.Ellipsis)
            .onClick({ _ =>
                Hilog.info(0, "", 'position = ${position}')
            })
    }

    func build() {
        Stack(Alignment.TopStart){
            List( scroller: this.vScroller ) {
                ListItem() {
                    ColumnLayout(
                        vLayoutContent: this.columnLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "32"),
                            layoutDataType(layoutText: "33"),
                            layoutDataType(layoutText: "34"),
                            layoutDataType(layoutText: "35"),
                            layoutDataType(layoutText: "36")
                            ],
                        vLayoutAttribute: AbstractFullFillAttributes(
                            aspectRatio: 9.0,
                            colWeights: [40.0, 5.0, 40.0],
                            bgColor: 0xff00f0f0,
                            bottomMargin: 5.0,
                        )
                    )
                }
                ListItem() {
                    ColumnLayout(
                        vLayoutContent: this.columnLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "46"),
                            layoutDataType(layoutText: "47"),
                            layoutDataType(layoutText: "48"),
                            layoutDataType(layoutText: "49")
                            ],
                        vLayoutAttribute: AbstractFullFillAttributes(
                            aspectRatio: 4.0,
                            bgColor: 0xAAAAAA,
                            topMargin: 5.0,
                        )
                    )
                }

                ListItem() {
                    ColumnLayout(
                        vLayoutContent: this.columnLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "32"),
                            layoutDataType(layoutText: "33"),
                            layoutDataType(layoutText: "34"),
                            layoutDataType(layoutText: "35"),
                            layoutDataType(layoutText: "36")
                            ],
                        vLayoutAttribute: AbstractFullFillAttributes(
                            range: [0, 7],
                            bgColor: 0xff0000,
                            colWeights: [30.0, 20.0, 20.0],
                            padding: [10.0, 10.0,10.0,10.0],
                            margin: [10.0, 10.0,10.0,10.0]
                        )
                    )
                }
            }
            .width(100.percent)
            .height(100.percent)
        }
        .width(100.percent)
        .height(100.percent)
        .backgroundColor(Color(0xAAAAAA))
    }


}