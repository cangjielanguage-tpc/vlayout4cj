/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package ohos_app_cangjie_entry

import ohos.state_macro_manage.*
@Entry
@Component
class RangeGridLayoutHelperExample {
    private var vScroller: Scroller = Scroller()

    @Builder func rangeGridLayoutContent(item: layoutDataType, position: Int64, gridItemHeight: Float64) {
        Column() {
            Text("${item.layoutText}")
                .width(100.percent)
                .height(100.percent)
                .border(width: 1.vp, color: Color.BLACK, radius: 0.vp, style: BorderStyle.Solid )
                .fontSize(25)
                .fontColor(0x999999)
                .fontWeight(FontWeight.Bold)
                .maxLines(1)
                .textAlign(TextAlign.Center)
                .textOverflow(TextOverflow.Ellipsis)
                .onClick({ _ =>
                    Hilog.info(0x000000, "rangeGridLayoutContent", 'position = ${position}')
                })
            }
            .backgroundColor(item.layoutColor)
            .padding(5)
             .margin(
               top: if(position == 4 || position == 5 || position == 8 || position == 9) { 10 } else { 0 },
               right: if(position == 5 || position == 7 || position == 9 || position == 11) { 10 } else { 0 } ,
               bottom: if(position == 6 || position == 7 || position == 10 || position == 11) { 5 } else { 0},
               left: if(position == 4 || position == 6 || position == 8 || position == 10) { 10 } else { 0 }
             )

    }

    func build() {
        Scroll(){
            Column(){
                RangeGridLayout(
                      vLayoutContent: this.rangeGridLayoutContent,
                      vLayoutData: [
                        layoutDataType( layoutText: '15', layoutColor: 0x00FF00 ),
                        layoutDataType( layoutText: '16', layoutColor: 0x00FF00 ),
                        layoutDataType( layoutText: '17', layoutColor: 0x00FF00 ),
                        layoutDataType( layoutText: '18', layoutColor: 0x00FF00 ),

                        layoutDataType( layoutText: '19', colsSpan: 2, layoutColor: 0xFF0000 ),
                        layoutDataType( layoutText: '20', colsSpan: 2, layoutColor: 0xFF0000 ),
                        layoutDataType( layoutText: '21', colsSpan: 2, layoutColor: 0xFF0000 ),
                        layoutDataType( layoutText: '22', colsSpan: 2, layoutColor: 0xFF0000 ),

                        layoutDataType( layoutText: '23',  layoutColor: 0xFFFF00 ),
                        layoutDataType( layoutText: '24',  layoutColor: 0xFFFF00 ),
                        layoutDataType( layoutText: '25',  layoutColor: 0xFFFF00 ),
                        layoutDataType( layoutText: '26',  layoutColor: 0xFFFF00 ),

                        layoutDataType( layoutText: '27', layoutColor: 0x00FF00 ),
                        layoutDataType( layoutText: '28', layoutColor: 0x00FF00 ),
                        layoutDataType( layoutText: '29', layoutColor: 0x00FF00 ),
                        layoutDataType( layoutText: '30', layoutColor: 0x00FF00 )
                      ],
                      rangeGridAttribute: GridAttributes(
                        layoutHeight: 500.0,
                        spanCount: 4,
                        weights: [20.0, 26.6, 26.6, 26.6],
                        aspectRatio: 4.0,
                        bgColor: 0x00FF00,
                        padding: [10.0, 10.0, 10.0, 10.0],
                        margin: [10.0, 10.0, 10.0, 10.0],
                      )
                    )
            }
            .width(100.percent)
            .height(100.percent)
            .backgroundColor(Color(0xAAAAAA))
        }
    }


}