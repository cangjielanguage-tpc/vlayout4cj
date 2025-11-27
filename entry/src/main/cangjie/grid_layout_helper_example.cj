/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package ohos_app_cangjie_entry

import ohos.state_macro_manage.*



@Entry
@Component
class GridLayoutHelperExample {
    private var vScroller: Scroller = Scroller()

    @Builder func gridLayoutContent(item: layoutDataType, position: Int64, gridItemHeight: Float64) {
        Text("${item.layoutText}")
            .width(100.percent)
            .height(100.percent)
            .backgroundColor(0xEEEEEE)
            .border(width: 1.vp, color: Color.BLACK, radius: 0.vp, style: BorderStyle.Solid )
            .fontSize(25)
            .fontColor(0x999999)
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
                    GridLayout(
                        vLayoutContent: this.gridLayoutContent,
                        vLayoutData: [
                          layoutDataType(layoutText: "11"),
                          layoutDataType(layoutText: "12"),
                          layoutDataType(layoutText: "13"),
                          layoutDataType(layoutText: "14", colsSpan: 3)
                        ],
                        gridAttribute: GridAttributes(
                            aspectRatio: 3.0,
                            bgColor: 0xFF86345A,
                            spanCount: 3,
                            weights: [33.3, 33.3, 33.3],
                            vGap: 10,
                            padding: [10.0, 10.0, 10.0, 10.0],
                            margin:[10.0, 10.0, 10.0, 10.0]

                        )
                  )
                }

                ListItem() {
                    GridLayout(
                        vLayoutContent: this.gridLayoutContent,
                        vLayoutData: [
                          layoutDataType(layoutText: "15"),
                          layoutDataType(layoutText: "16"),
                          layoutDataType(layoutText: "17"),
                          layoutDataType(layoutText: "18", colsSpan: 3),
                          layoutDataType(layoutText: "19", colsSpan: 1)
                        ],
                        gridAttribute: GridAttributes(
                            bgColor: 0x008000,
                            vGap: 10,

                        )
                  )
                }

                ListItem() {
                    GridLayout(
                        vLayoutContent: this.gridLayoutContent,
                        vLayoutData: [
                          layoutDataType(layoutText: "20"),
                          layoutDataType(layoutText: "21"),
                          layoutDataType(layoutText: "22"),
                          layoutDataType(layoutText: "23", colsSpan: 3),
                          layoutDataType(layoutText: "24", colsSpan: 1)
                        ],
                        gridAttribute: GridAttributes(
                            layoutHeight: 500.0,
                            aspectRatio: 3.0,
                            bgColor: 0x008000,
                            spanCount: 4,
                            vGap: 10,
                            hGap: 10,
                            weights: [33.3],
                        )
                  )
                }

                 ListItem() {
                    GridLayout(
                        vLayoutContent: this.gridLayoutContent,
                        vLayoutData: [
                          layoutDataType(layoutText: "25"),
                          layoutDataType(layoutText: "26"),
                          layoutDataType(layoutText: "27"),
                          layoutDataType(layoutText: "28", colsSpan: 3),
                          layoutDataType(layoutText: "29", colsSpan: 1)
                        ],
                        gridAttribute: GridAttributes(
                            layoutHeight: 500.0,
                            bgColor: 0x008000,
                            spanCount: 4,
                            vGap: 10,
                            hGap: 10,
                            weights: [33.3, 20.0],
                            padding: [10.0, 10.0, 10.0, 10.0],
                            margin:[10.0, 10.0, 10.0, 10.0]

                        )
                  )
                }


            }
            .width(100.percent)
            .height(100.percent)
            .nestedScroll(NestedScrollOptions(NestedScrollMode.SELF_FIRST, NestedScrollMode.SELF_FIRST))
        }
        .width(100.percent)
        .height(100.percent)
        .backgroundColor(Color(0xAAAAAA))
    }


}