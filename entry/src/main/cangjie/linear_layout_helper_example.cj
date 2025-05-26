/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package ohos_app_cangjie_entry

import ohos.state_macro_manage.*

@Entry
@Component
class LineartLayoutHelperExample {
    private  var vScroller: Scroller = Scroller()

    @Builder func columnLayoutContent(item: layoutDataType, position: Int64, listItemHeight: Float64) {
        Text("${item.layoutText}")
            .width(100.percent)
            .height(100.percent)
            .backgroundColor(if(position % 2 == 0){ 0xffb6c1 } else { 0x808000 })
            .border(width: 1.vp, color: Color.BLACK, radius: 0.vp, style: BorderStyle.Solid )
            .fontSize(25)
            .fontColor(0x999999)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Center)
            .textOverflow(TextOverflow.Ellipsis)
            .onClick({ _ =>
                Hilog.info(0, "", 'position = ${position}')
            })
    }

    func build() {
        Stack(Alignment.TopStart){
            List(scroller: vScroller) {
                ListItem() {
                    LinearLayout(
                        vLayoutContent: this.columnLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "0000"),
                            layoutDataType(layoutText: "1111"),
                            layoutDataType(layoutText: "2222"),
                            layoutDataType(layoutText: "3333"),
                            layoutDataType(layoutText: "4444"),
                            layoutDataType(layoutText: "5555"),
                            layoutDataType(layoutText: "6666")
                        ],
                        vLayoutAttribute: LinearAttributes()
                    )
                }
                ListItem() {
                    LinearLayout(
                        vLayoutContent: this.columnLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "0"),
                            layoutDataType(layoutText: "1"),
                            layoutDataType(layoutText: "2"),
                            layoutDataType(layoutText: "3"),
                            layoutDataType(layoutText: "4"),
                            layoutDataType(layoutText: "5"),
                            layoutDataType(layoutText: "6")
                        ],
                        vLayoutAttribute: LinearAttributes(
                            aspectRatio: 4.0
                        )
                    )
                }
                ListItem() {
                    LinearLayout(
                        vLayoutContent: this.columnLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "13"),
                            layoutDataType(layoutText: "14"),
                            layoutDataType(layoutText: "15"),
                            layoutDataType(layoutText: "16"),
                            layoutDataType(layoutText: "17"),
                            layoutDataType(layoutText: "18")
                            ],
                        vLayoutAttribute: LinearAttributes(
                            layoutHeight: 580.0,
                            dividerHeight: 5,
                            bgColor: 0xFFF5A623,
                            margin: [5.0, 5.0, 5.0, 5.0],
                            padding:[5.0, 5.0, 5.0, 5.0]
                        )
                    )
                }

                ListItem() {
                    LinearLayout(
                        vLayoutContent: this.columnLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "2")
                            ],
                        vLayoutAttribute: LinearAttributes(
                            aspectRatio: 2.0,
                            bgColor: 0xffff00,
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