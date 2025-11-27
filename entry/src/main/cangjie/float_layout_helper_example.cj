/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package ohos_app_cangjie_entry

import ohos.state_macro_manage.*
import vlayout4cj.commons.layoutDataType

@Entry
@Component
class FloatLayoutHelperExample {
    private  var vScroller: Scroller = Scroller()

    @Builder func columnLayoutContent(item: layoutDataType, position: Int64, listItemHeight: Float64) {
        Text("${item.layoutText}")
            .width(100.percent)
            .height(100.percent)
            .backgroundColor(if(position % 2 == 0){ 0xaa00ff00 } else { 0xccff00ff })
            .border(width: 0.vp, color: Color.BLACK, radius: 0.vp, style: BorderStyle.Solid )
            .fontSize(18)
            .fontColor(Color.BLACK)
            .fontWeight(FontWeight.Normal)
            .textAlign(TextAlign.Start)
            .textOverflow(TextOverflow.Ellipsis)
            .onClick({ _ =>
                Hilog.info(0, "", 'position = ${position}')
            })
    }

    @Builder func fixLayoutContent(item: layoutDataType, position: Int64) {
        Text("${item.layoutText}")
            .width(100.percent)
            .height(100.percent)
            .backgroundColor(0xEEEEEE)
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
    @Builder func floatxLayoutContent(item: layoutDataType, position: Int64) {
        Text("${item.layoutText}")
            .width(100.percent)
            .height(100.percent)
            .backgroundColor(0xff0000)
            .border(width: 1.vp, color: Color.BLACK, radius: 0.vp, style: BorderStyle.Solid )
            .fontSize(25)
            .fontColor(0xffffff)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Center)
            .textOverflow(TextOverflow.Ellipsis)
            .onClick({ _ =>
                Hilog.info(0, "", 'position = ${position}')
            })
    }

    func build() {
        Column(){
            List(scroller: vScroller) {
                ListItem() {
                    DefaultLayout(
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
                        defaultAttribute: LinearAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 400.vp,
                            dividerHeight: 5,
                            margin: [25.0, 5.0, 2.0, 5.0],
                            padding:[15.0, 10.0, 12.0, 10.0]
                        )
                    )
                }
                ListItem() {
                    DefaultLayout(
                        vLayoutContent: this.columnLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "8"),
                            layoutDataType(layoutText: "9")
                            ],
                        defaultAttribute: LinearAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 400.vp,
                            dividerHeight: 5,
                            margin: [13.0, 5.0, 12.0, 5.0],
                            padding:[23.0, 20.0, 22.0, 30.0]
                        )
                    )
                }
            }
            FixLayout(
                vLayoutContent: this.fixLayoutContent,
                vLayoutData: [layoutDataType(layoutText: 'FIX(1)')],
                fixAttribute: FixAreaAttributes(
                    layoutWidth: 100.0,
                    layoutHeight: 100.0,
                    //aspectRatio: 2.0,
                    sketchMeasure: false,
                    bgColor: 0xc71585,
//                    xOffset: 20.0,
//                    yOffset: 30.0,
                    alignType: 0,
                    zIndex: 10,
                )
            )

            FloatLayout(
                vLayoutContent: this.floatxLayoutContent,
                vLayoutData: [layoutDataType(layoutText: 'Float')],
                floatAttribute: FixAreaAttributes(
                    layoutWidth: 80.0,
                    layoutHeight: 80.0,
                    aspectRatio: 2.0,
                    bgColor: 0xc71585,
//                    xOffset: 20.0,
//                    yOffset: 100.0,
                    alignType: 1,
                    zIndex: 10,
                )
            )

            FloatLayout(
                vLayoutContent: this.floatxLayoutContent,
                vLayoutData: [layoutDataType(layoutText: 'Float')],
                floatAttribute: FixAreaAttributes(
                    layoutWidth: 80.0,
                    layoutHeight: 80.0,
                    aspectRatio: 2.0,
                    bgColor: 0xc71585,
                    xOffset: 20.0,
                    yOffset: 300.0,
                    zIndex: 10,
                )
            )

            FloatLayout(
                vLayoutContent: this.floatxLayoutContent,
                vLayoutData: [layoutDataType(layoutText: 'Float')],
                floatAttribute: FixAreaAttributes(
                    layoutWidth: 80.0,
                    layoutHeight: 80.0,
                    aspectRatio: 2.0,
                    bgColor: 0xc71585,
                    xOffset: 20.0,
                    yOffset: 300.0,
                    zIndex: 10,
                    defaultLocation:[40.0, 50.0]
                )
            )

        }
        .width(100.percent)
        .height(100.percent)
        .backgroundColor(0xDCDCDC)
    }
}