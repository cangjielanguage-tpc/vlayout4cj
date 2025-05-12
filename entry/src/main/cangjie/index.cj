/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */

package ohos_app_cangjie_entry

internal import ohos.base.*
internal import ohos.component.*
internal import ohos.state_manage.*
internal import ohos.router.Router
internal import ohos.hilog.Hilog

import ohos.state_macro_manage.*

@Entry
@Component
class EntryView {
    func build() {
        Stack(Alignment.TopStart){
            Column() {
                Button("BannerLayoutHelperExample Test")
                    .shape(ShapeType.Capsule)
                    .backgroundColor(0x317aff)
                    .onClick { _ =>
                        Router.push(url: "BannerLayoutHelperExample")
                    }
             }
            .width(100.percent)
            .height(100.percent)
            .backgroundColor(0xDCDCDC)
            .padding(top: 5.px,bottom: 200.px)
        }
    }


}


