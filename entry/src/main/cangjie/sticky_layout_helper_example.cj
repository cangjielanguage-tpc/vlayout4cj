/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package ohos_app_cangjie_entry

import ohos.state_macro_manage.*

@Entry
@Component
class StickyLayoutHelperExample {
    private var vScroller: Scroller = Scroller()
    @State var yPosition: Float64 = 0.0
    @State var isSticky: Bool = false

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
                Hilog.info(0x000000, "columnLayoutContent", 'position = ${position}')
            })
    }

    @Builder func stickyLayoutContent(item: layoutDataType, position: Int64) {
        Text('${item.layoutText}')
        .width(100.percent)
        .height(100.percent)
        .border(width: 1.vp, color: Color.BLACK, radius: 0.vp, style: BorderStyle.Solid )
        .fontSize(25)
        .fontColor(0x999999)
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.Center)
        .textOverflow(TextOverflow.Ellipsis )
        .onClick({ _ =>
            Hilog.info(0x000000, "stickyLayoutContent", 'position = ${position}')
        })
    }

    func build() {
        Column() {
            List() {
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
                                layoutWidth: 100.percent,
                                layoutHeight: 600.vp,
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
                                layoutWidth: 100.percent,
                                layoutHeight: 580.vp,
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
                                layoutWidth: 100.percent,
                                layoutHeight: 180.vp,
                                bgColor: 0xffff00,
                                margin: [5.0, 5.0, 5.0, 5.0],
                                padding:[5.0, 5.0, 5.0, 5.0]
                            )
                        )
                    }

                    ListItem(){
                        StickyLayout(
                            vLayoutContent: this.stickyLayoutContent,
                            vLayoutData: [
                                layoutDataType(layoutText: "Sticky")
                            ],
                            vLayoutAttribute: FixAreaAttributes(
                                layoutHeight: 200.0,
                                layoutWidth: 200.0,
                                bgColor: 0xffff00,
                                zIndex: 10
                            ),
                            isSticky: this.isSticky
                        )
                    }
                    .onAreaChange({oldValue, newValue =>
                        this.yPosition = px2vp(newValue.globalPosition.y.px).getOrThrow().value
                    })

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
                               layoutWidth: 100.percent,
                                layoutHeight: 380.vp,
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
                                layoutWidth: 100.percent,
                                layoutHeight: 580.vp,
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
                                layoutWidth: 100.percent,
                                layoutHeight: 180.vp,
                                bgColor: 0xffff00,
                                margin: [5.0, 5.0, 5.0, 5.0],
                                padding:[5.0, 5.0, 5.0, 5.0]
                            )
                        )
                    }
            }
            .onScroll ({ offset, ScrollState =>
                if(offset > 0.0 && this.yPosition <= 0.0) {
                    this.isSticky = true
                } else if(offset < 0.0 && this.yPosition <= 0.0 && offset < this.yPosition){
                    this.isSticky = true
                } else if(offset < 0.0 && this.yPosition > 0.0){
                    this.isSticky = false
                }

            })
            .nestedScroll(NestedScrollOptions(NestedScrollMode.SELF_FIRST, NestedScrollMode.SELF_FIRST))

            if(this.isSticky) {
                StickyLayout(
                    vLayoutContent: this.stickyLayoutContent,
                    vLayoutData: [
                        layoutDataType(layoutText: "Sticky")
                    ],
                    vLayoutAttribute: FixAreaAttributes(
                        layoutHeight: 200.0,
                        layoutWidth: 200.0,
                        bgColor: 0xffff00,
                        zIndex: 10
                    ),
                    isSticky: this.isSticky
                )
            }

        }
    }
}
