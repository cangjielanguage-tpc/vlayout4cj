/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package ohos_app_cangjie_entry

import ohos.state_macro_manage.*

@Entry
@Component
class NestedSample {
    let displayClass: Display = getDefaultDisplaySync()
    let screenWidth: Float64 = px2vp(Float64(displayClass.width).px).getOrThrow().value
    let screenHeight: Float64 = px2vp(Float64(displayClass.height).px).getOrThrow().value
    var data: Array<layoutDataType> = [
        layoutDataType(layoutText: ""),
        layoutDataType(layoutText: "2", tag: "TXT"),
        layoutDataType(layoutText: "3", tag: "TXT"),
        layoutDataType(layoutText: "4", tag: "TXT"),
        layoutDataType(layoutText: "5", tag: "TXT"),
        layoutDataType(layoutText: "6", tag: "TXT"),
        layoutDataType(layoutText: "7", tag: "TXT"),
        layoutDataType(layoutText: "8", tag: "TXT")
    ]
    var data4: Array<layoutDataType> = [
        layoutDataType(layoutText: "1"),
        layoutDataType(layoutText: "2"),
        layoutDataType(layoutText: "3"),
        layoutDataType(layoutText: "4")
    ]
    var data2: Array<layoutDataType> = [
        layoutDataType(layoutText: "61"),
        layoutDataType(layoutText: "62"),
        layoutDataType(layoutText: "63"),
        layoutDataType(layoutText: "64"),
        layoutDataType(layoutText: "65"),
        layoutDataType(layoutText: "66"),
        layoutDataType(layoutText: "67"),
        layoutDataType(layoutText: "68"),
        layoutDataType(layoutText: "69"),
        layoutDataType(layoutText: "70"),
        layoutDataType(layoutText: "71"),
        layoutDataType(layoutText: "72"),
        layoutDataType(layoutText: "73"),
        layoutDataType(layoutText: "74"),
        layoutDataType(layoutText: "75"),
        layoutDataType(layoutText: "76"),
        layoutDataType(layoutText: "77"),
        layoutDataType(layoutText: "78"),
        layoutDataType(layoutText: "79"),
        layoutDataType(layoutText: "80"),
        layoutDataType(layoutText: "81"),
        layoutDataType(layoutText: "82"),
        layoutDataType(layoutText: "83"),
        layoutDataType(layoutText: "84"),
        layoutDataType(layoutText: "85"),
        layoutDataType(layoutText: "86"),
        layoutDataType(layoutText: "87"),
        layoutDataType(layoutText: "88"),
        layoutDataType(layoutText: "89"),
        layoutDataType(layoutText: "90"),
        layoutDataType(layoutText: "91"),
        layoutDataType(layoutText: "92"),
        layoutDataType(layoutText: "93"),
        layoutDataType(layoutText: "94"),
        layoutDataType(layoutText: "95"),
        layoutDataType(layoutText: "96")
    ]

    var data3: Array<layoutDataType> = [
        layoutDataType(layoutText: "1"),
        layoutDataType(layoutText: "2"),
        layoutDataType(layoutText: "3"),
        layoutDataType(layoutText: "4"),
        layoutDataType(layoutText: "5"),
        layoutDataType(layoutText: "6"),
        layoutDataType(layoutText: "7"),
        layoutDataType(layoutText: "8", colsSpan: 2 )
    ]

    @State var isVisibility: Bool = true

    @Builder func onenLayoutContent(item: layoutDataType) {
        Text("${item.layoutText}")
            .width(100.percent)
            .height(100.percent)
            .backgroundColor(item.layoutColor)
            .border(width: 1.vp, color: Color.BLACK, radius: 0.vp, style: BorderStyle.Solid )
            .fontSize(25)
            .fontColor(Color.BLACK)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Center)
            .textOverflow(TextOverflow.Ellipsis)

    }

    @Builder func bannerLayoutContent(item: layoutDataType, position: Int64) {
        Text("Banner: ${item.layoutText}")
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
            .onClick({ _ =>
                Hilog.info(0, "", 'position = ${position}')
            })
    }

    @Builder func gridLayoutContent1(item: layoutDataType, position: Int64, gridItemHeight: Float64) {
        if (item.tag == 'TXT') {
            Text("${item.layoutText}")
                .width(100.percent)
                .height(100.percent)
                .backgroundColor(Color(0x22EEEEEE))
                .border(width: 1.vp, color: Color.BLACK, radius: 0.vp, style: BorderStyle.Solid )
                .fontSize(25)
                .fontColor(Color(0x999999))
                .fontWeight(FontWeight.Bold)
                .textAlign(TextAlign.Center)
                .textOverflow(TextOverflow.Ellipsis)
                .onClick({ _ =>
                    Hilog.info(0, "", 'position = ${position}')
                })
        } else {
            OneLayout(
                vLayoutContent: this.onenLayoutContent,
                vLayoutData: [
                    layoutDataType(layoutText: "", layoutColor: 0xFFFACD),
                    layoutDataType(layoutText: "", layoutColor: 0xFFF0F5),
                    layoutDataType(layoutText: "", layoutColor: 0xF0FFF0)
                ],
                vLayoutAttribute: AbstractFullFillAttributes(
                    layoutHeight: gridItemHeight,
                    bgColor: 0xffffff,
                    padding:[15.0, 15.0, 15.0, 15.0]
                )
            )
        }
    }

    @Builder func gridLayoutContent2(item: layoutDataType, position: Int64, gridItemHeight: Float64) {
        if (item.tag == 'TXT') {
            Text("${item.layoutText}")
                .width(100.percent)
                .height(100.percent)
                .backgroundColor(Color(0x22EEEEEE))
                .border(width: 1.vp, color: Color.BLACK, radius: 0.vp, style: BorderStyle.Solid )
                .fontSize(25)
                .fontColor(Color(0x999999))
                .fontWeight(FontWeight.Bold)
                .textAlign(TextAlign.Center)
                .textOverflow(TextOverflow.Ellipsis)
                .onClick({ _ =>
                    Hilog.info(0, "", 'position = ${position}')
                })
        } else {
            OneLayout(
                vLayoutContent: this.onenLayoutContent,
                vLayoutData: [
                    layoutDataType(layoutText: "A", layoutColor: 0xFFF0F5),
                    layoutDataType(layoutText: "B", layoutColor: 0xFFF0F5),
                    layoutDataType(layoutText: "C", layoutColor: 0xF0FFF0)
                ],
                vLayoutAttribute: AbstractFullFillAttributes(
                    layoutHeight: gridItemHeight,
                    bgColor: 0xffffff,
                    padding:[5.0, 5.0, 5.0, 5.0]
                )
            )
        }
    }

    @Builder func gridLayoutContent3(item: layoutDataType, position: Int64, gridItemHeight: Float64) {
        if (position == 1) {
            BannerLayout(
                vLayoutContent: this.bannerLayoutContent,
                vLayoutData: data4,
                vLayoutAttribute: BannerAttributes(
                    layoutHeight: gridItemHeight,
                    layoutWidth: 200.0,
                    bgColor: 0xF0FFF0,
                )
            )
        } else {
            Text("${item.layoutText}")
                .width(100.percent)
                .height(100.percent)
                .backgroundColor(Color(0x22EEEEEE))
                .border(width: 1.vp, color: Color.BLACK, radius: 0.vp, style: BorderStyle.Solid )
                .fontSize(25)
                .fontColor(Color(0x999999))
                .fontWeight(FontWeight.Bold)
                .textAlign(TextAlign.Center)
                .textOverflow(TextOverflow.Ellipsis)
                .onClick({ _ =>
                    Hilog.info(0, "", 'position = ${position}')
                })
        }
    }

    @Builder func gridLayoutContent4(item: layoutDataType, position: Int64, gridItemHeight: Float64) {
        Text("${item.layoutText}")
            .width(100.percent)
            .height(100.percent)
            .backgroundColor(Color(0x22EEEEEE))
            .border(width: 1.vp, color: Color.BLACK, radius: 0.vp, style: BorderStyle.Solid )
            .fontSize(25)
            .fontColor(Color(0x999999))
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Center)
            .textOverflow(TextOverflow.Ellipsis)
            .onClick({ _ =>
                Hilog.info(0, "", 'position = ${position}')
            })

    }

    func build() {
        Scroll() {
            Column() {
                Text("").visibility(if(this.isVisibility) { Visibility.None}else {Visibility.Visible})
                Text('GRID_LAYOUT嵌套ONEN_LAYOUT：').width(100.percent)

                GridLayout(
                    vLayoutContent: this.gridLayoutContent1,
                    vLayoutData: this.data,
                    vLayoutAttribute: GridAttributes(
                        spanCount: 4,
                        weights: [25.0, 25.0, 25.0, 25.0],
                        aspectRatio: 2.0 ,
                        bgColor: 0xCFCFCF,
                        layoutHeight: 450.0,
                        margin:[10.0, 10.0, 10.0, 10.0]

                    )
                )

                Text('GRID_LAYOUT嵌套ONEN_LAYOUT(可内部滑动)：').width(100.percent)
                GridLayout(
                    vLayoutContent: this.gridLayoutContent2,
                    vLayoutData: this.data,
                    vLayoutAttribute: GridAttributes(
                        spanCount: 2,
                        weights: [46.665, 53.335],
                        aspectRatio: 2.0 ,
                        bgColor: 0xCFCFCF,
                        layoutHeight: 340.0,
                        hGap: 10,
                        vGap: 10,
                        padding: [5.0, 5.0, 5.0, 5.0],
                        margin: [5.0, 5.0, 5.0, 5.0],

                    )
                )

                Text('GRID_LAYOUT嵌套BANNER_LAYOUT(可内部滑动)：').width(100.percent)
                GridLayout(
                    vLayoutContent: this.gridLayoutContent3,
                    vLayoutData: this.data2,
                    vLayoutAttribute: GridAttributes(
                        spanCount: 3,
                        aspectRatio: 2.0 ,
                        bgColor: 0xCFCFCF,
                        layoutHeight: screenHeight / 2.0,
                        vGap: 3,
                        leftPadding: 5.0,
                        rightPadding: 5.0,
                        margin: [0.0, 10.0, 10.0, 10.0],

                    )
                )

                Text('GRID_LAYOUT的colsSpan使用(可内部滑动)：').width(100.percent)
                GridLayout(
                    vLayoutContent: this.gridLayoutContent4,
                    vLayoutData: this.data3,
                    vLayoutAttribute: GridAttributes(
                        spanCount: 3,
                        weights: [50.0],
                        aspectRatio: 2.0 ,
                        bgColor: 0xCFCFCF,
                        layoutHeight: screenHeight / 2.0,
                        margin: [0.0, 10.0, 0.0, 10.0],

                    )
                )

            }
        }
        .onAreaChange({oldValue, newValue =>
          this.isVisibility = !this.isVisibility
        })
        .width(100.percent)
        .height(100.percent)
        .backgroundColor(0xAAAAAA)
    }


}