/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package vlayout4cj

import ohos.state_macro_manage.Component
import ohos.state_macro_manage.Link

@Component
public class JumpBar {
    var jumpBarColor: UInt32 = 0x33000000
    var jumpBarAspectRatio: Float64 = 4.0
    var fontSize: Float64 = 17.0
    var textShow: Bool = true
    @Link var scroller: Array<Scroller>
    @Link var textFirst: Int64
    @Link var textExisting: Int64
    @Link var textCreated: Int64
    @Link var textCount: Int64
    @Link var textInput: Int32

    func build(){
        Column() {
            Row() {
                if (this.textShow) {
                    Text("First: ${this.textFirst}")
                        .layoutWeight(1)
                        .fontSize(this.fontSize)
                        .fontColor(Color.WHITE)
                        .maxLines(1)
                        .textAlign(TextAlign.Center)
                        .textOverflow(TextOverflow.Ellipsis)

                    Text("Existing: ${this.textExisting} Created: ${this.textCreated}")
                        .layoutWeight(1)
                        .fontSize(this.fontSize)
                        .fontColor(Color.WHITE)
                        .maxLines(2)
                        .textAlign(TextAlign.Center)
                        .textOverflow(TextOverflow.Ellipsis)

                    Text("Count: ${this.textCount}")
                        .layoutWeight(1)
                        .fontSize(this.fontSize)
                        .fontColor(Color.WHITE)
                        .maxLines(1)
                        .textAlign(TextAlign.Center)
                        .textOverflow(TextOverflow.Ellipsis)
                } else {
                    Blank()
                }
            }.layoutWeight(1)

            Row() {
                Text('Jump Position')
                .width(30.percent)
                .height(100.percent)
                .fontSize(this.fontSize)
                .maxLines(1)
                .textAlign(TextAlign.Center)
                .textOverflow(TextOverflow.Ellipsis)
                Column() {
                    TextInput(placeholder: '请输入...', text: "${this.textInput}")
                        .width(100.percent)
                        .height(100.percent)
                        .setType(InputType.Number)
                        .placeholderColor(0x000000)
                        .placeholderFont( size: this.fontSize )
                        .enterKeyType(EnterKeyType.Go)
                        .caretColor(0x000000)
                        .onChange({value: String =>
                            if (value.size == 0) {
                                this.textInput = 0
                            } else if(Int32.parse(value) < 0) {
                                 Hilog.error(0x000000, "value", "error set")
                            } else {
                                this.textInput = Int32.parse(value)
                            }
                        })
                    Divider().borderWidth(1).color(Color.BLACK)
                }
                .width(20.percent)
                .height(85.percent)

                Button {
                    Text('JUMP')
                    .fontSize(this.fontSize)
                    .fontColor(Color.BLACK)
                    .maxLines(1)
                    .textAlign(TextAlign.Center)
                    .textOverflow(TextOverflow.Ellipsis)
                }
                .shape(ShapeType.Normal)
                .stateEffect(true)
                .width(20.percent)
                .height(85.percent)
                .backgroundColor(0xD6D7D7)
                .onClick({evt =>
                    this.scroller[0].scrollToIndex(this.textInput / 4)
                })

            }.layoutWeight(2)
        }
        .aspectRatio(this.jumpBarAspectRatio)
        .backgroundColor(this.jumpBarColor)
        .zIndex(10)
    }
}