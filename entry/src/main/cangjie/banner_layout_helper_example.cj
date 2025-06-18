/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package ohos_app_cangjie_entry

import ohos.state_macro_manage.*

@Entry
@Component
class BannerLayoutHelperExample {
    private var vScroller: Scroller = Scroller()
    var data: Array<layoutDataType> = [layoutDataType(layoutText: "0"),layoutDataType(layoutText: "1"),layoutDataType(layoutText: "2"),layoutDataType(layoutText: "3"),layoutDataType(layoutText: "4"),layoutDataType(layoutText: "5")]

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

    func build() {
        Stack(Alignment.TopStart){
            BannerLayout(
                vLayoutContent: this.bannerLayoutContent,
                vLayoutData: data,
                vLayoutAttribute: BannerAttributes(
                    layoutWidth: 100.percent,
                    layoutHeight: 50.percent,
                    bgColor: 0xFF0000,
                    margin: [10.0, 10.0,10.0,10.0]
                )
            )
        }
        .width(100.percent)
        .height(100.percent)
        .backgroundColor(Color(0xAAAAAA))
    }


}