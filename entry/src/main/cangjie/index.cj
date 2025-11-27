package ohos_app_cangjie_entry

internal import ohos.base.*
internal import ohos.component.*
internal import ohos.state_manage.*
internal import ohos.router.Router
internal import ohos.hilog.Hilog

import ohos.state_macro_manage.*
internal import vlayout4cj.commons.*
internal import vlayout4cj.*

//internal import ohos_app_cangjie_entry.level0.*
//internal import ohos_app_cangjie_entry.level1.*
//internal import ohos_app_cangjie_entry.level2.*

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
                    .id("BannerLayoutHelperExample")
                Button("ColumnLayoutHelperExample Test")
                    .shape(ShapeType.Capsule)
                    .backgroundColor(0x317aff)
                    .onClick { _ =>
                        Router.push(url: "ColumnLayoutHelperExample")
                    }
                    .id("ColumnLayoutHelperExample")
                Button("DefaultLayoutHelperExample Test")
                    .shape(ShapeType.Capsule)
                    .backgroundColor(0x317aff)
                    .onClick { _ =>
                        Router.push(url: "DefaultLayoutHelperExample")
                    }
                    .id("DefaultLayoutHelperExample")
                Button("FixLayoutHelperExample Test")
                    .shape(ShapeType.Capsule)
                    .backgroundColor(0x317aff)
                    .onClick { _ =>
                        Router.push(url: "FixLayoutHelperExample")
                    }
                    .id("FixLayoutHelperExample")
                Button("FloatLayoutHelperExample Test")
                    .shape(ShapeType.Capsule)
                    .backgroundColor(0x317aff)
                    .onClick { _ =>
                        Router.push(url: "FloatLayoutHelperExample")
                    }
                    .id("FloatLayoutHelperExample")
                Button("GridLayoutHelperExample Test")
                    .shape(ShapeType.Capsule)
                    .backgroundColor(0x317aff)
                    .onClick { _ =>
                        Router.push(url: "GridLayoutHelperExample")
                    }
                    .id("GridLayoutHelperExample")
                Button("LineartLayoutHelperExample Test")
                    .shape(ShapeType.Capsule)
                    .backgroundColor(0x317aff)
                    .onClick { _ =>
                        Router.push(url: "LineartLayoutHelperExample")
                    }
                    .id("LineartLayoutHelperExample")
                Button("ScrollFixLayoutHelperExample Test")
                    .shape(ShapeType.Capsule)
                    .backgroundColor(0x317aff)
                    .onClick { _ =>
                        Router.push(url: "ScrollFixLayoutHelperExample")
                    }
                    .id("ScrollFixLayoutHelperExample")
                Button("StickyLayoutHelperExample Test")
                    .shape(ShapeType.Capsule)
                    .backgroundColor(0x317aff)
                    .onClick { _ =>
                        Router.push(url: "StickyLayoutHelperExample")
                    }
                    .id("StickyLayoutHelperExample")
                Button("OnePlusNLayoutHelperExample Test")
                    .shape(ShapeType.Capsule)
                    .backgroundColor(0x317aff)
                    .onClick { _ =>
                        Router.push(url: "OnePlusNLayoutHelperExample")
                    }
                    .id("OnePlusNLayoutHelperExample")
                Button("OnePlusNExLayoutHelperExample Test")
                    .shape(ShapeType.Capsule)
                    .backgroundColor(0x317aff)
                    .onClick { _ =>
                        Router.push(url: "OnePlusNExLayoutHelperExample")
                    }
                    .id("OnePlusNExLayoutHelperExample")
                Button("SingleLayoutHelperExample Test")
                    .shape(ShapeType.Capsule)
                    .backgroundColor(0x317aff)
                    .onClick { _ =>
                        Router.push(url: "SingleLayoutHelperExample")
                    }
                    .id("SingleLayoutHelperExample")
                Button("RangeGridLayoutHelperExample Test")
                    .shape(ShapeType.Capsule)
                    .backgroundColor(0x317aff)
                    .onClick { _ =>
                        Router.push(url: "RangeGridLayoutHelperExample")
                    }
                    .id("RangeGridLayoutHelperExample")
                Button("JumpBarExample Test")
                    .shape(ShapeType.Capsule)
                    .backgroundColor(0x317aff)
                    .onClick { _ =>
                        Router.push(url: "JumpBarExample")
                    }
                    .id("JumpBarExample")
                Button("StaggeredGridlayoutHelperExample Test")
                    .shape(ShapeType.Capsule)
                    .backgroundColor(0x317aff)
                    .onClick { _ =>
                        Router.push(url: "StaggeredGridlayoutHelperExample")
                    }
                    .id("StaggeredGridlayoutHelperExample")
                Button("NestedSample Test")
                    .shape(ShapeType.Capsule)
                    .backgroundColor(0x317aff)
                    .onClick { _ =>
                        Router.push(url: "NestedSample")
                    }
                    .id("NestedSample")
                Button("Level0 Test")
                    .id("Level0")
                    .shape(ShapeType.Capsule)
                    .backgroundColor(0x317aff)
                    .onClick { _ =>
                        Router.push(url: "Level0")
                    }
                Button("Level1 Test")
                    .id("Level1")
                    .shape(ShapeType.Capsule)
                    .backgroundColor(0x317aff)
                    .onClick { _ =>
                        Router.push(url: "Level1")
                    }
                Button("Level2 Test")
                    .id("Level2")
                    .shape(ShapeType.Capsule)
                    .backgroundColor(0x317aff)
                    .onClick { _ =>
                        Router.push(url: "Level2")
                    }
             }
            .width(100.percent)
            .height(100.percent)
            .backgroundColor(0xDCDCDC)
            .padding(top: 5.px,bottom: 200.px)
        }
    }


}