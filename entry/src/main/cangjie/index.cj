/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */

package ohos_app_cangjie_entry

internal import ohos.base.*
internal import ohos.component.*
internal import ohos.state_manage.*
internal import ohos.router.Router
internal import ohos.hilog.Hilog
internal import ohos.display.*
internal import std.convert.*

import ohos.state_macro_manage.*

internal import vlayout4cj.*

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
                Button("ColumnLayoutHelperExample Test")
                    .shape(ShapeType.Capsule)
                    .backgroundColor(0x317aff)
                    .onClick { _ =>
                        Router.push(url: "ColumnLayoutHelperExample")
                    }
                Button("DefaultLayoutHelperExample Test")
                    .shape(ShapeType.Capsule)
                    .backgroundColor(0x317aff)
                    .onClick { _ =>
                        Router.push(url: "DefaultLayoutHelperExample")
                    }
                Button("FixLayoutHelperExample Test")
                    .shape(ShapeType.Capsule)
                    .backgroundColor(0x317aff)
                    .onClick { _ =>
                        Router.push(url: "FixLayoutHelperExample")
                    }
                Button("FloatLayoutHelperExample Test")
                    .shape(ShapeType.Capsule)
                    .backgroundColor(0x317aff)
                    .onClick { _ =>
                        Router.push(url: "FloatLayoutHelperExample")
                    }
                Button("GridLayoutHelperExample Test")
                    .shape(ShapeType.Capsule)
                    .backgroundColor(0x317aff)
                    .onClick { _ =>
                        Router.push(url: "GridLayoutHelperExample")
                    }
                Button("LineartLayoutHelperExample Test")
                    .shape(ShapeType.Capsule)
                    .backgroundColor(0x317aff)
                    .onClick { _ =>
                        Router.push(url: "LineartLayoutHelperExample")
                    }
                Button("ScrollFixLayoutHelperExample Test")
                    .shape(ShapeType.Capsule)
                    .backgroundColor(0x317aff)
                    .onClick { _ =>
                        Router.push(url: "ScrollFixLayoutHelperExample")
                    }
                Button("StickyLayoutHelperExample Test")
                    .shape(ShapeType.Capsule)
                    .backgroundColor(0x317aff)
                    .onClick { _ =>
                        Router.push(url: "StickyLayoutHelperExample")
                    }
                Button("OnePlusNLayoutHelperExample Test")
                    .shape(ShapeType.Capsule)
                    .backgroundColor(0x317aff)
                    .onClick { _ =>
                        Router.push(url: "OnePlusNLayoutHelperExample")
                    }
                Button("OnePlusNExLayoutHelperExample Test")
                    .shape(ShapeType.Capsule)
                    .backgroundColor(0x317aff)
                    .onClick { _ =>
                        Router.push(url: "OnePlusNExLayoutHelperExample")
                    }
                Button("SingleLayoutHelperExample Test")
                    .shape(ShapeType.Capsule)
                    .backgroundColor(0x317aff)
                    .onClick { _ =>
                        Router.push(url: "SingleLayoutHelperExample")
                    }
                Button("RangeGridLayoutHelperExample Test")
                    .shape(ShapeType.Capsule)
                    .backgroundColor(0x317aff)
                    .onClick { _ =>
                        Router.push(url: "RangeGridLayoutHelperExample")
                    }
                Button("JumpBarExample Test")
                    .shape(ShapeType.Capsule)
                    .backgroundColor(0x317aff)
                    .onClick { _ =>
                        Router.push(url: "JumpBarExample")
                    }
                Button("StaggeredGridlayoutHelperExample Test")
                    .shape(ShapeType.Capsule)
                    .backgroundColor(0x317aff)
                    .onClick { _ =>
                        Router.push(url: "StaggeredGridlayoutHelperExample")
                    }

             }
            .width(100.percent)
            .height(100.percent)
            .backgroundColor(0xDCDCDC)
            .padding(top: 5.px,bottom: 200.px)
        }
    }


}


