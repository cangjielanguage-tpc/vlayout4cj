/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package vlayout4cj.commons

import ohos.state_macro_manage.Component
import ohos.state_macro_manage.State

@Component
public class TextCommon {
    @State var text: String = ""

    func build() {
        Text('${text}')
            .width(100.percent)
            .height(100.percent)
            .backgroundColor(0xEEEEEE)
            .border( width: 1.vp, color: Color.BLACK, radius: 0.vp, style: BorderStyle.Solid )
            .fontSize(25)
            .fontColor(0x999999)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Center)
            .textOverflow( TextOverflow.Ellipsis )
    }
}