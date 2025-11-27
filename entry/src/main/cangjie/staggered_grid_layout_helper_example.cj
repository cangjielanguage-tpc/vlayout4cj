/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package ohos_app_cangjie_entry

import ohos.state_macro_manage.*
import ohos.display.Display
import ohos.display.getDefaultDisplaySync

@Entry
@Component
class StaggeredGridlayoutHelperExample {
    private var vScroller: Scroller = Scroller()
    let displayClass: Display = getDefaultDisplaySync()
    let screenWidth: Float64 = px2vp(Float64(displayClass.width).px).getOrThrow().value

    @Builder func columnLayoutContent(item: layoutDataType, position: Int64) {
        if (position % 2 == 0) {
          Text("${item.layoutText}")
            .width(100.percent)
            .height(220)
            .border(width: 1.vp, color: Color.BLACK, radius: 0.vp, style: BorderStyle.Solid )
            .fontSize(25)
            .backgroundColor(0x33EEEEEE)
            .fontColor(Color(0x999999))
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Center)
            .textOverflow(TextOverflow.Ellipsis)
            .onClick({ _ =>
                Hilog.info(0, "", 'position = ${position}')
            })
        } else {
          Text("${item.layoutText}")
            .width(100.percent)
            .height(150)
            .border(width: 1.vp, color: Color.BLACK, radius: 0.vp, style: BorderStyle.Solid )
            .fontSize(25)
            .backgroundColor(0x33EEEEEE)
            .fontColor(Color(0x999999))
            .fontWeight(FontWeight.Bold)
            .maxLines(1)
            .textAlign(TextAlign.Center)
            .textOverflow(TextOverflow.Ellipsis)
            .onClick({ _ =>
                Hilog.info(0, "", 'position = ${position}')
            })
        }

    }

    func build() {
        Scroll(){
            Column() {
                StaggeredGridLayout(
                    vLayoutContent: this.columnLayoutContent,
                    vLayoutData: [
                        layoutDataType(layoutText: "0"),
                        layoutDataType(layoutText: "1"),
                        layoutDataType(layoutText: "2"),
                        layoutDataType(layoutText: "3"),
                        layoutDataType(layoutText: "4"),
                        layoutDataType(layoutText: "5"),
                        layoutDataType(layoutText: "6"),
                        layoutDataType(layoutText: "7"),
                        layoutDataType(layoutText: "8"),
                        layoutDataType(layoutText: "9"),
                        layoutDataType(layoutText: "10"),
                        layoutDataType(layoutText: "11"),
                        layoutDataType(layoutText: "12"),
                        layoutDataType(layoutText: "13"),
                        layoutDataType(layoutText: "14"),
                        layoutDataType(layoutText: "15"),
                        layoutDataType(layoutText: "16"),
                        layoutDataType(layoutText: "17"),
                        layoutDataType(layoutText: "18"),
                        layoutDataType(layoutText: "19"),
                        layoutDataType(layoutText: "20"),
                        layoutDataType(layoutText: "21"),
                        layoutDataType(layoutText: "22"),
                        layoutDataType(layoutText: "23"),
                        layoutDataType(layoutText: "24"),
                        layoutDataType(layoutText: "25"),
                        layoutDataType(layoutText: "26"),
                        layoutDataType(layoutText: "27"),
                        layoutDataType(layoutText: "28"),
                        layoutDataType(layoutText: "29"),
                        layoutDataType(layoutText: "30"),
                        layoutDataType(layoutText: "31"),
                        layoutDataType(layoutText: "32"),
                        layoutDataType(layoutText: "33")
                    ],
                    staggeredGridAttribute: StaggeredGridAttributes(
                        staggeredWidth: screenWidth,
                        lanes: 3,
                        gap: 5.0,
                        margin: [10.0, 5.0, 10.0, 5.0],
                        bgColor: 0xFF86345A
                    ),
                    vLayoutId: 'STAGGERED'
                )

            }
        }
        .scrollable(ScrollDirection.Vertical)
        .backgroundColor(Color(0xAAAAAA))
    }
}