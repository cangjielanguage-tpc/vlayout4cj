/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package ohos_app_cangjie_entry.level1

import ohos.state_macro_manage.Entry
import ohos.state_macro_manage.Component
import ohos.state_macro_manage.Builder

@Entry
@Component
class TestGridColumnSpanCountWeight {
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
        layoutDataType(layoutText: "0", colsSpan: 1),
        layoutDataType(layoutText: "1", colsSpan: 0),
        layoutDataType(layoutText: "2", colsSpan: 2),
        layoutDataType(layoutText: "3"),
        layoutDataType(layoutText: "4", colsSpan: 5),
        layoutDataType(layoutText: "5"),
        layoutDataType(layoutText: "6")
    ]

    @Builder func layoutContent(item: layoutDataType, position: Int64, itemHeight: Float64) {
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
            .onClick({ _ =>
                Hilog.info(0, "", 'position = ${position}')
            })
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
                    Text("spanCount weights 缺省，预期：spanCounts 默认 4 列------").height(80).fontSize(14)
                    GridLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        gridAttribute: GridAttributes(
                            layoutHeight: 300.0,
                            bgColor: 0xFF0000
                        )
                    )
                    Text("spanCount < 0 weights 缺省，预期：显示4列------").height(80).fontSize(14)
                    GridLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        gridAttribute: GridAttributes(
                            layoutHeight: 300.0,
                            bgColor: 0xFF0000,
                            spanCount: -3
                        )
                    )
                    Text("0 < spanCount：5 <= 21 weights 缺省，预期：5列------").height(80).fontSize(14)
                    GridLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        gridAttribute: GridAttributes(
                            layoutHeight: 300.0,
                            bgColor: 0xFF0000,
                            spanCount: 5
                        )
                    )
                    Text("spanCount == 0 && weights.size != 0 ，预期：weights.size 为 3 列-----").height(80).fontSize(14)
                    GridLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        gridAttribute: GridAttributes(
                            layoutHeight: 300.0,
                            bgColor: 0xFF0000,
                            weights:[10.0,20.0,10.0]
                        )
                    )
                    Text("weights.size == 0 ，预期：weights.size 为 4 列-----").height(80).fontSize(14)
                    GridLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        gridAttribute: GridAttributes(
                            layoutHeight: 300.0,
                            bgColor: 0xFF0000
                        )
                    )
                    Text("0 < weights 长度 <= vLayoutData.size ，预期：weights.size 为 5 列-----").height(80).fontSize(14)
                    GridLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        gridAttribute: GridAttributes(
                            layoutHeight: 300.0,
                            bgColor: 0xFF0000,
                            weights:[10.0,20.0,10.0,5.0,25.0]
                        )
                    )
                    Text("weights 长度 > vLayoutData.size ，预期：7列-----").height(80).fontSize(14)
                    GridLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        gridAttribute: GridAttributes(
                            layoutHeight: 300.0,
                            bgColor: 0xFF0000,
                            weights:[10.0,20.0,10.0,5.0,25.0,10.0,10.0,5.0,10.0]
                        )
                    )
                    Text("weights 百分比 > 100%，且长度 <  vLayoutData.size，预期：4列,其余不显示-----").height(80).fontSize(14)
                    GridLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        gridAttribute: GridAttributes(
                            layoutHeight: 300.0,
                            bgColor: 0xFF0000,
                            weights:[10.0,20.0,10.0,65.0]
                        )
                    )
                    Text("weights 百分比 > 100%，且长度 >  vLayoutData.size，预期：7列-----").height(80).fontSize(14)
                    GridLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        gridAttribute: GridAttributes(
                            layoutHeight: 300.0,
                            bgColor: 0xFF0000,
                            weights:[10.0,20.0,10.0,5.0,25.0,10.0,10.0,5.0,10.0]
                        )
                    )

                    Text("spanCount == 5 && weights.size = 3，预期：5列-----").height(80).fontSize(14)
                    GridLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        gridAttribute: GridAttributes(
                            layoutHeight: 300.0,
                            bgColor: 0xFF0000,
                            spanCount: 5,
                            weights:[10.0,20.0,10.0]
                        )
                    )
                    Text("spanCount == 3 && weights.size = 5，预期：5列-----").height(80).fontSize(14)
                    GridLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        gridAttribute: GridAttributes(
                            layoutHeight: 300.0,
                            bgColor: 0xFF0000,
                            spanCount: 5,
                            weights:[10.0,20.0,10.0,25.0,20.0]
                        )
                    )
                    //--加---
                    Text("weights.size > spanCount 且 weights 前三项<100").height(80).fontSize(14)
                    GridLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        gridAttribute: GridAttributes(
                            layoutHeight: 300.0,
                            bgColor: 0xFF0000,
                            spanCount: 3,
                            weights:[10.0,20.0,10.0,25.0,20.0]
                        )
                    )
                    Text("weights.size > spanCount 且 weights 前三>100").height(80).fontSize(14)
                    GridLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        gridAttribute: GridAttributes(
                            layoutHeight: 300.0,
                            bgColor: 0xFF0000,
                            spanCount: 3,
                            weights:[50.0,40.0,20.0,25.0,20.0]
                        )
                    )
                    Text("weights.size 3 ").height(80).fontSize(14)
                    GridLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        gridAttribute: GridAttributes(
                            layoutHeight: 300.0,
                            bgColor: 0xFF0000,
                            spanCount: 5,
                            weights:[50.0,20.0,40.0]
                        )
                    )

                    Text("weights.size 3 ").height(80).fontSize(14)
                    GridLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data1,
                        gridAttribute: GridAttributes(
                            layoutHeight: 300.0,
                            bgColor: 0xFF0000,
                            spanCount: 3,
                            weights:[30.0,20.0,10.0]
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