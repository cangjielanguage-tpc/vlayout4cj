/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package vlayout4cj

import ohos.state_macro_manage.Component
import ohos.state_macro_manage.Link

@Component
public class JumpBar {
    var jumpBarWidth: Length = 100.percent
    var jumpBarHeight: Length = 100.percent
    var jumpBarColor: UInt32 = 0x33000000
    var jumpBarAspectRatio: Float64 = 4.0
    var fontSize: Float64 = 17.0
    var btBgColor: UInt32 = 0xD6D7D7
    @Link var textShow: Bool
    @Link var scroller: Array<Scroller>
    @Link var textFirst: Int64
    @Link var textExisting: Int64
    @Link var textCreated: Int64
    @Link var textCount: Int64
    @Link var textInput: Int32

    func build(){
        Column() {
            if(textShow) {
                Row() {
                    Text("First: ${textFirst}")
                        .layoutWeight(1)
                        .fontSize(fontSize)
                        .fontColor(Color.WHITE)
                        .maxLines(1)
                        .textAlign(TextAlign.Center)
                        .textOverflow(TextOverflow.Ellipsis)

                    Text("Existing: ${textExisting} Created: ${textCreated}")
                        .layoutWeight(1)
                        .fontSize(fontSize)
                        .fontColor(Color.WHITE)
                        .maxLines(2)
                        .textAlign(TextAlign.Center)
                        .textOverflow(TextOverflow.Ellipsis)

                    Text("Count: ${textCount}")
                        .layoutWeight(1)
                        .fontSize(fontSize)
                        .fontColor(Color.WHITE)
                        .maxLines(1)
                        .textAlign(TextAlign.Center)
                        .textOverflow(TextOverflow.Ellipsis)
                }.layoutWeight(1)
            }
            Row() {
                Text('Jump Position')
                .width(30.percent)
                .height(100.percent)
                .fontSize(fontSize)
                .maxLines(1)
                .textAlign(TextAlign.Center)
                .textOverflow(TextOverflow.Ellipsis)
                Column() {
                    TextInput(placeholder: '请输入...', text: "${textInput}")
                        .width(100.percent)
                        .height(100.percent)
                        .setType(InputType.Number)
                        .placeholderColor(0x000000)
                        .placeholderFont( size: fontSize )
                        .enterKeyType(EnterKeyType.Go)
                        .caretColor(0x000000)
                        .onChange({value: String =>
                            if (value.size == 0) {
                                textInput = 0
                            } else if(Int32.parse(value) < 0) {
                                 Hilog.error(0x000000, "value", "error set")
                            } else {
                                textInput = Int32.parse(value)
                            }
                        })
                    Divider().borderWidth(1).color(Color.BLACK)
                }
                .width(20.percent)
                .height(85.percent)

                Button {
                    Text('JUMP')
                    .fontSize(fontSize)
                    .fontColor(Color.BLACK)
                    .maxLines(1)
                    .textAlign(TextAlign.Center)
                    .textOverflow(TextOverflow.Ellipsis)
                }
                .shape(ShapeType.Normal)
                .stateEffect(true)
                .width(20.percent)
                .height(85.percent)
                .backgroundColor(btBgColor)
                .onClick({evt =>
                    scroller[0].scrollToIndex(textInput / 4)
                })

            }.layoutWeight(if(textShow) { 2 }else { 1 } )
        }
        .aspectRatio(jumpBarAspectRatio)
        .zIndex(10)
        .width(jumpBarWidth)
        .height(jumpBarHeight)
    }
}