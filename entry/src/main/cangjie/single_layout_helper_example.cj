/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package ohos_app_cangjie_entry

import ohos.state_macro_manage.*

@Entry
@Component
class SingleLayoutHelperExample {
    private var vScroller: Scroller = Scroller()
    @State var singleLayoutAttribute: AbstractFullFillAttributes = AbstractFullFillAttributes()

    public override func aboutToAppear() {
        this.singleLayoutAttribute.layoutWidth = 100.percent
        this.singleLayoutAttribute.layoutHeight = 20.percent
        this.singleLayoutAttribute.bgColor = 0xffc0cb
        this.singleLayoutAttribute.padding = [5.0, 5.0, 5.0, 5.0]
        this.singleLayoutAttribute.margin = [5.0, 5.0, 5.0, 5.0]
    }
    @Builder func columnLayoutContent(item: layoutDataType, position: Int64) {
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
        Scroll(){
            Column() {
                Button('change').width(100.percent).onClick({ _ =>
                  this.singleLayoutAttribute.bgColor = 0xffff00
                })

                SingleLayout(
                    vLayoutContent: this.columnLayoutContent,
                    vLayoutData: [
                        layoutDataType(layoutText: "32")
                        ],
                    singleAttribute: this.singleLayoutAttribute
                )


                SingleLayout(
                    vLayoutContent: this.columnLayoutContent,
                    vLayoutData: [
                        layoutDataType(layoutText: "46"),
                        layoutDataType(layoutText: "47"),
                        layoutDataType(layoutText: "48"),
                        layoutDataType(layoutText: "49")
                        ],
                    singleAttribute: this.singleLayoutAttribute
                )

                SingleLayout(
                    vLayoutContent: this.columnLayoutContent,
                    vLayoutData: [
                        layoutDataType(layoutText: "32"),
                        layoutDataType(layoutText: "33"),
                        layoutDataType(layoutText: "34"),
                        layoutDataType(layoutText: "35"),
                        layoutDataType(layoutText: "36")
                        ],
                    singleAttribute: this.singleLayoutAttribute
                )

            }
            .width(100.percent)
            .height(100.percent)
        }
        .scrollable(ScrollDirection.Vertical)
        .width(100.percent)
        .height(100.percent)
        .backgroundColor(Color(0xAAAAAA))
    }


}