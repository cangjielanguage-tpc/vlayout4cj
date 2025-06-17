/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package vlayout4cj

import ohos.state_macro_manage.Component
import ohos.state_macro_manage.BuilderParam
import ohos.state_macro_manage.State
import ohos.state_macro_manage.Watch
import std.collection.ArrayList

private const TAG = 'vlayout STAGGEREDGRID_LAYOUT '


@Component
public class StaggeredGridLayout {
    @BuilderParam var vLayoutContent: (layoutDataType, Int64) -> Unit //布局
    var vLayoutData: Array<layoutDataType> = [] //数据源

    @State @Watch[defaultValueInit] var vLayoutAttribute: StaggeredGridAttributes = StaggeredGridAttributes() //属性
    @State var staggeredGridInfo: StaggeredGridAttributes = StaggeredGridAttributes() //属性
    @State var vLayoutId: String = '' //组件标识

    @State var itemHeightArray: Array<Float64> = Array<Float64>(0, item: 0.0) //item高度数组
    @State var itemWidth: Float64 = 0.0 //每个item的宽度
    @State var itemHeight: Float64 = 0.0//每个item的高度
    @State var staggeredWidth: Float64 = 0.0 //瀑布流的宽度
    @State var colHeightArrayMax: Float64 = 0.0 //瀑布流的高度
    private var count: Int64 = 0
    private var layoutCount: Int64 = 0

    protected override func aboutToAppear() {
        itemHeightArray = Array<Float64>(vLayoutData.size, item: 0.0)
        defaultValueInit()
        computedRange()
        computedPosition()
    }

    func defaultValueInit() {
        staggeredGridInfo = StaggeredGridAttributes(
            range: if(vLayoutAttribute.range == [0, 0] || vLayoutAttribute.range[1] > vLayoutData.size) {[0, vLayoutData.size] } else {vLayoutAttribute.range } ,
            staggeredWidth: if(vLayoutAttribute.margin.size == 4) {
                vLayoutAttribute.staggeredWidth - vLayoutAttribute.margin[1] - vLayoutAttribute.margin[3]
            } else{
                vLayoutAttribute.staggeredWidth - vLayoutAttribute.rightMargin - vLayoutAttribute.leftMargin
            } ,
            lanes: vLayoutAttribute.lanes,
            gap:  vLayoutAttribute.gap,
            vGap: vLayoutAttribute.vGap,
            hGap: vLayoutAttribute.hGap,
            bgColor: vLayoutAttribute.bgColor,
            zIndex: vLayoutAttribute.zIndex,
            padding: vLayoutAttribute.padding,
            topPadding: if(vLayoutAttribute.padding.size == 4) {
                vLayoutAttribute.padding[0]
            } else {
                vLayoutAttribute.topPadding
            },
            rightPadding: if(vLayoutAttribute.padding.size == 4) {
                vLayoutAttribute.padding[1]
            } else {
                vLayoutAttribute.rightPadding
            },
            bottomPadding: if(vLayoutAttribute.padding.size == 4) {
                vLayoutAttribute.padding[2]
            } else {
                vLayoutAttribute.bottomPadding
            },
            leftPadding: if(vLayoutAttribute.padding.size == 4) {
                vLayoutAttribute.padding[3]
            } else {
                vLayoutAttribute.leftPadding
            },
            margin: vLayoutAttribute.margin,
            topMargin: if(vLayoutAttribute.margin.size == 4) {
                vLayoutAttribute.margin[0]
            } else {
                vLayoutAttribute.topMargin
            },
            rightMargin: if(vLayoutAttribute.margin.size == 4) {
                vLayoutAttribute.margin[1]
            } else {
                vLayoutAttribute.rightMargin
            },
            bottomMargin: if(vLayoutAttribute.margin.size == 4) {
                vLayoutAttribute.margin[2]
            } else {
                vLayoutAttribute.bottomMargin
            },
            leftMargin: if(vLayoutAttribute.margin.size == 4) {
                vLayoutAttribute.margin[3]
            } else {
                vLayoutAttribute.leftMargin
            }
            )
    }
    func computedRange() {
        //可显示的条目range数组长度为2并且数组元素内第一项大于等于0并且第二项大于第一项
        if (staggeredGridInfo.range.size == 2 && staggeredGridInfo.range[0] >= 0 && staggeredGridInfo.range[1] > staggeredGridInfo.range[0]) {
            vLayoutData = vLayoutData.slice(staggeredGridInfo.range[0], staggeredGridInfo.range[1])
        } else {
            vLayoutData = vLayoutData
        }
    }

    func getColHeightArrayMax(colHeightArray: Array<Float64>): Float64 {
        var maxHeight: Float64 = colHeightArray[0]
        var index = 0
        for (i in 0..colHeightArray.size) {
            if (maxHeight < colHeightArray[i]) {
                maxHeight = colHeightArray[i]
                index = i
            }
        }
        return colHeightArray[index]
    }

    func computedPosition() {
        if (this.count == this.vLayoutData.size) {
            var colHeightArray: ArrayList<Float64> = ArrayList<Float64>()
            for (i in 0..this.vLayoutData.size) {
                if (this.staggeredGridInfo.lanes != 0 && i < this.staggeredGridInfo.lanes && this.itemWidth != 0.0) { //确定第一行
                    if (this.staggeredGridInfo.gap != 0.0 && this.staggeredGridInfo.vGap == 0.0 && this.staggeredGridInfo.hGap == 0.0) { //gap行列间距定义了
                        this.vLayoutData[i].top = this.staggeredGridInfo.gap
                        this.vLayoutData[i].left = (this.itemWidth + this.staggeredGridInfo.gap) * Float64(i) + this.staggeredGridInfo.gap
                        colHeightArray.append(this.itemHeightArray[i] + this.staggeredGridInfo.gap)
                    } else if (this.staggeredGridInfo.gap == 0.0 && this.staggeredGridInfo.vGap != 0.0 && this.staggeredGridInfo.hGap == 0.0) { //vGap行间距定义了
                        this.vLayoutData[i].top = this.staggeredGridInfo.vGap
                        this.vLayoutData[i].left = this.itemWidth * Float64(i)
                        colHeightArray.append(this.itemHeightArray[i] + this.staggeredGridInfo.vGap)
                    } else if (this.staggeredGridInfo.gap == 0.0 && this.staggeredGridInfo.vGap == 0.0 && this.staggeredGridInfo.hGap != 0.0) { //hGap列间距定义了
                        this.vLayoutData[i].top = 0.0
                        this.vLayoutData[i].left = (this.itemWidth + this.staggeredGridInfo.hGap) * Float64(i) + this.staggeredGridInfo.hGap
                        colHeightArray.append(this.itemHeightArray[i])
                    } else if (this.staggeredGridInfo.gap == 0.0 && this.staggeredGridInfo.vGap != 0.0 && this.staggeredGridInfo.hGap != 0.0) { //vGap行间距、hGap列间距同时定义了
                        this.vLayoutData[i].top = this.staggeredGridInfo.vGap
                        this.vLayoutData[i].left = (this.itemWidth + this.staggeredGridInfo.hGap) * Float64(i) + this.staggeredGridInfo.hGap
                        colHeightArray.append(this.itemHeightArray[i] + this.staggeredGridInfo.vGap)
                    } else if (this.staggeredGridInfo.gap == 0.0 && this.staggeredGridInfo.vGap == 0.0 && this.staggeredGridInfo.hGap == 0.0) { //gap、vGap、hGap同时未定义
                        this.vLayoutData[i].top = 0.0
                        this.vLayoutData[i].left = this.itemWidth * Float64(i)
                        colHeightArray.append(this.itemHeightArray[i])
                    } else if (this.staggeredGridInfo.gap != 0.0) { //三个都定义，只走gap
                        this.vLayoutData[i].top = this.staggeredGridInfo.gap
                        this.vLayoutData[i].left = (this.itemWidth + this.staggeredGridInfo.gap) * Float64(i) + this.staggeredGridInfo.gap
                        colHeightArray.append(this.itemHeightArray[i] + this.staggeredGridInfo.gap)
                    }
                } else if (this.staggeredGridInfo.lanes != 0) {
                    //其它行 先找到数组中的最小高度以及它的索引
                    var minHeight = colHeightArray[0] //定义最小的高度
                    var index = 0 //定义最小高度的下标
                    for (j in 0..this.staggeredGridInfo.lanes) {
                        if (minHeight > colHeightArray[j]) {
                            minHeight = colHeightArray[j]
                            index = j
                        }
                    }
                    //设置下一行的第一个盒子的位置
                    //top的值就是最小列的高度 + gap
                    //left的值就是最小距离左边的距离
                    //修改最小列的高度
                    //最小列的高度 = 当前的高度 + 拼接的高度 + 间隙的高度
                    if (this.staggeredGridInfo.gap != 0.0 && this.staggeredGridInfo.vGap == 0.0 && this.staggeredGridInfo.hGap == 0.0) { //gap行列间距定义了
                        this.vLayoutData[i].top = colHeightArray[index] + this.staggeredGridInfo.gap
                        this.vLayoutData[i].left = this.vLayoutData[index].left
                        colHeightArray[index] = colHeightArray[index] + this.itemHeightArray[i] + this.staggeredGridInfo.gap
                    } else if (this.staggeredGridInfo.gap == 0.0 && this.staggeredGridInfo.vGap != 0.0 && this.staggeredGridInfo.hGap == 0.0) { //vGap行间距定义了
                        this.vLayoutData[i].top = colHeightArray[index] + this.staggeredGridInfo.vGap
                        this.vLayoutData[i].left = this.vLayoutData[index].left
                        colHeightArray[index] = colHeightArray[index] + this.itemHeightArray[i] + this.staggeredGridInfo.vGap
                    } else if (this.staggeredGridInfo.gap == 0.0 && this.staggeredGridInfo.vGap == 0.0 && this.staggeredGridInfo.hGap != 0.0) { //hGap列间距定义了
                        this.vLayoutData[i].top = colHeightArray[index]
                        this.vLayoutData[i].left = this.vLayoutData[index].left
                        colHeightArray[index] = colHeightArray[index] + this.itemHeightArray[i]
                    } else if (this.staggeredGridInfo.gap == 0.0 && this.staggeredGridInfo.vGap != 0.0 && this.staggeredGridInfo.hGap != 0.0) { //vGap行间距、hGap列间距同时定义了
                        this.vLayoutData[i].top = colHeightArray[index] + this.staggeredGridInfo.vGap
                        this.vLayoutData[i].left = this.vLayoutData[index].left
                        colHeightArray[index] = colHeightArray[index] + this.itemHeightArray[i] + this.staggeredGridInfo.vGap
                    } else if (this.staggeredGridInfo.gap == 0.0 && this.staggeredGridInfo.vGap == 0.0 && this.staggeredGridInfo.hGap == 0.0) { //gap、vGap、hGap同时未定义
                        this.vLayoutData[i].top = colHeightArray[index]
                        this.vLayoutData[i].left = this.vLayoutData[index].left
                        colHeightArray[index] = colHeightArray[index] + this.itemHeightArray[i]
                    } else if (this.staggeredGridInfo.gap != 0.0) { //三个都定义，只走gap
                        this.vLayoutData[i].top = colHeightArray[index] + this.staggeredGridInfo.gap
                        this.vLayoutData[i].left = this.vLayoutData[index].left
                        colHeightArray[index] = colHeightArray[index] + this.itemHeightArray[i] + this.staggeredGridInfo.gap
                    }
                }
            }
            this.count = 0
            colHeightArrayMax = getColHeightArrayMax(colHeightArray.toArray())
        } else {
            Hilog.error(0x000000, "computedPosition", '${TAG}computedPosition else')
        }
    }



    func getSize(id: String): Array<Float64>{
        let strJson = getInspectorByKey(id)
        let obj = JsonValue.fromStr(strJson).asObject()
        let fields = obj.getFields()
        let children = fields.get("$rect").getOrThrow().toString()
        let strArr = children.split(",")
        let rect_left = Float64.parse(strArr[0][2..])
        var temp = strArr[1]
        let rect_top = Float64.parse(temp[..temp.size - 1])
        temp = strArr[2]
        let rect_right = Float64.parse(temp[1..])
        temp = strArr[3]
        let rect_bottom = Float64.parse(temp[0..temp.size - 2])
        return [rect_right - rect_left, rect_bottom - rect_top]
    }

    func build() {
        Column() {
            Stack() {
                ForEach(this.vLayoutData, itemGeneratorFunc: {item: layoutDataType, position: Int64 =>
                    Stack() {
                        this.vLayoutContent(item, position)
                    }
                    .id("this.vLayoutId${position}")
                    .onAreaChange({ oldValue, newValue =>
                        this.layoutCount++
                        if (this.layoutCount > this.vLayoutData.size) {
                            return
                        }

                        let mSize: Array<Float64> = this.getSize("this.vLayoutId${position}")
                        this.itemHeight = px2vp(mSize[1].px)().value
                        if (this.staggeredGridInfo.gap != 0.0 && this.staggeredGridInfo.vGap == 0.0 && this.staggeredGridInfo.hGap == 0.0 && this.staggeredGridInfo.lanes != 0) { //gap行列间距定义了
                            this.itemWidth = (this.staggeredGridInfo.staggeredWidth - Float64(this.staggeredGridInfo.lanes + 1) * this.staggeredGridInfo.gap) / Float64(this.staggeredGridInfo.lanes)
                        } else if (this.staggeredGridInfo.gap == 0.0 && this.staggeredGridInfo.vGap != 0.0 && this.staggeredGridInfo.hGap == 0.0 && this.staggeredGridInfo.lanes != 0) { //vGap行间距定义了
                            this.itemWidth = (this.staggeredGridInfo.staggeredWidth - Float64(this.staggeredGridInfo.lanes + 1) * this.staggeredGridInfo.gap) / Float64(this.staggeredGridInfo.lanes)
                        } else if (this.staggeredGridInfo.gap == 0.0 && this.staggeredGridInfo.vGap == 0.0 && this.staggeredGridInfo.hGap != 0.0 && this.staggeredGridInfo.lanes != 0) { //hGap列间距定义了
                            this.itemWidth = (this.staggeredGridInfo.staggeredWidth - Float64(this.staggeredGridInfo.lanes + 1) * this.staggeredGridInfo.hGap) / Float64(this.staggeredGridInfo.lanes)
                        } else if (this.staggeredGridInfo.gap == 0.0 && this.staggeredGridInfo.vGap != 0.0 && this.staggeredGridInfo.hGap != 0.0 && this.staggeredGridInfo.lanes != 0) { //vGap行间距、hGap列间距同时定义了
                            this.itemWidth = (this.staggeredGridInfo.staggeredWidth - Float64(this.staggeredGridInfo.lanes + 1) * this.staggeredGridInfo.hGap) / Float64(this.staggeredGridInfo.lanes)
                        } else if (this.staggeredGridInfo.gap == 0.0 && this.staggeredGridInfo.vGap == 0.0 && this.staggeredGridInfo.hGap == 0.0 && this.staggeredGridInfo.lanes != 0) { //gap、vGap、hGap同时未定义
                            this.itemWidth = (this.staggeredGridInfo.staggeredWidth - Float64(this.staggeredGridInfo.lanes + 1) * this.staggeredGridInfo.gap) / Float64(this.staggeredGridInfo.lanes)
                        } else if (this.staggeredGridInfo.lanes != 0 && this.staggeredGridInfo.gap != 0.0) { //三个都定义，只走gap
                            this.itemWidth = (this.staggeredGridInfo.staggeredWidth - Float64(this.staggeredGridInfo.lanes + 1) * this.staggeredGridInfo.gap) / Float64(this.staggeredGridInfo.lanes)
                        }
                        this.itemHeightArray[position] = this.itemHeight
                        this.count = this.count + 1
                        this.computedPosition()
                    })
                    .width(this.itemWidth)
                    .position( x: item.left, y: item.top )
                })
            }
            .width(100.percent)
            .height(
                if(colHeightArrayMax != 0.0) {
                    if(this.staggeredGridInfo.gap == 0.0 && this.staggeredGridInfo.vGap != 0.0) {
                        (colHeightArrayMax + this.staggeredGridInfo.vGap).vp
                    } else if(this.staggeredGridInfo.gap != 0.0) {
                        (colHeightArrayMax + this.staggeredGridInfo.gap).vp
                    } else {
                        colHeightArrayMax.vp
                    }
                } else {
                      100.percent
                }
            )
            .padding(
                top: this.staggeredGridInfo.topPadding,
                right: this.staggeredGridInfo.rightPadding,
                bottom: this.staggeredGridInfo.bottomPadding,
                left: this.staggeredGridInfo.leftPadding
            )
        }
        .backgroundColor(this.staggeredGridInfo.bgColor)
        .zIndex(this.staggeredGridInfo.zIndex)
        .margin(
            top: this.staggeredGridInfo.topMargin,
            right: this.staggeredGridInfo.rightMargin,
            bottom: this.staggeredGridInfo.bottomMargin,
            left: this.staggeredGridInfo.leftMargin
        )
    }
}