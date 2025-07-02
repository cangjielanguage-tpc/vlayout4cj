package ohos_app_cangjie_entry

internal import ohos.base.*
internal import ohos.component.*
internal import ohos.state_manage.*
internal import ohos.router.Router
internal import ohos.hilog.Hilog

import ohos.state_macro_manage.*
//internal import ohos_app_cangjie_entry.level0.*
//internal import ohos_app_cangjie_entry.level1.*
//internal import ohos_app_cangjie_entry.level2.*

@Entry
@Component
class EntryView {
    func build() {
        Stack(Alignment.TopStart){
            Column() {
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