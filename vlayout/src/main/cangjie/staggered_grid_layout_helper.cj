/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package vlayout4cj

import ohos.state_macro_manage.Component
import ohos.state_macro_manage.BuilderParam
import ohos.state_macro_manage.State
import std.collection.ArrayList

private const TAG = 'vlayout STAGGEREDGRID_LAYOUT '

@Component
public class StaggeredGridLayout {
    @BuilderParam var vLayoutContent: (layoutDataType, Int64) -> Unit //布局
    var vLayoutData: Array<layoutDataType> = [] //数据源

    @State var staggeredGridAttribute: StaggeredGridAttributes = StaggeredGridAttributes() //属性
    @State var vLayoutId: String = '' //组件标识

    private var displayClass: Display = getDefaultDisplaySync()
    private var screenWidth: Float64 = px2vp(Float64(displayClass.width).px)().value
    @State var itemHeightArray: Array<Float64> = Array<Float64>(0, repeat: 0.0) //item高度数组
    @State var itemWidth: Float64 = 0.0 //每个item的宽度
    @State var itemHeight: Float64 = 0.0//每个item的高度
    @State var staggeredWidth: Float64 = 0.0 //瀑布流的宽度
    @State var colHeightArrayMax: Float64 = 0.0 //瀑布流的高度
    private var lanes: Int64 = 1
    private var count: Int64 = 0
    private var layoutCount: Int64 = 0

    protected override func aboutToAppear() {
        itemHeightArray = Array<Float64>(vLayoutData.size, repeat: 0.0)
        staggeredWidth = if(staggeredGridAttribute.staggeredWidth != 0.0) {
            staggeredGridAttribute.staggeredWidth
        } else {
            screenWidth
        }
        staggeredWidth = if(staggeredGridAttribute.margin.size == 4) {
            staggeredWidth - staggeredGridAttribute.margin[1] - staggeredGridAttribute.margin[3]
        } else{
            staggeredWidth - staggeredGridAttribute.rightMargin - staggeredGridAttribute.leftMargin
        }
        lanes = if(staggeredGridAttribute.lanes <= 0) {1} else {staggeredGridAttribute.lanes}
        vLayoutData = CommonFunc.computedRange(staggeredGridAttribute.range, vLayoutData)
        computedPosition()
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
        if (count == vLayoutData.size && vLayoutData.size != 0) {
            var colHeightArray: ArrayList<Float64> = ArrayList<Float64>()
            for (i in 0..vLayoutData.size) {
                if (lanes > 0 && i < lanes && itemWidth != 0.0) { //确定第一行
                    colHeightArray = computedPositionFirstLine(colHeightArray, i)
                } else if (lanes > 0) {
                    //其它行 先找到数组中的最小高度以及它的索引
                    colHeightArray = computedPositionOtherLine(colHeightArray, i)
                }
            }
            count = 0
            colHeightArrayMax = getColHeightArrayMax(colHeightArray.toArray())
        } else {
            Hilog.error(0x000000, "computedPosition", '${TAG}computedPosition else')
        }
    }

    func computedPositionFirstLine(colHeightArr: ArrayList<Float64>, index: Int64): ArrayList<Float64>{
        var colHeightArray = colHeightArr
        if (staggeredGridAttribute.gap != 0.0 && staggeredGridAttribute.vGap == 0.0 && staggeredGridAttribute.hGap == 0.0) { //gap行列间距定义了
            vLayoutData[index].top = staggeredGridAttribute.gap
            vLayoutData[index].left = (itemWidth + staggeredGridAttribute.gap) * Float64(index) + staggeredGridAttribute.gap
            colHeightArray.add(itemHeightArray[index] + staggeredGridAttribute.gap)
        } else if (staggeredGridAttribute.gap == 0.0 && staggeredGridAttribute.vGap != 0.0 && staggeredGridAttribute.hGap == 0.0) { //vGap行间距定义了
            vLayoutData[index].top = staggeredGridAttribute.vGap
            vLayoutData[index].left = itemWidth * Float64(index)
            colHeightArray.add(itemHeightArray[index] + staggeredGridAttribute.vGap)
        } else if (staggeredGridAttribute.gap == 0.0 && staggeredGridAttribute.vGap == 0.0 && staggeredGridAttribute.hGap != 0.0) { //hGap列间距定义了
            vLayoutData[index].top = 0.0
            vLayoutData[index].left = (itemWidth + staggeredGridAttribute.hGap) * Float64(index) + staggeredGridAttribute.hGap
            colHeightArray.add(itemHeightArray[index])
        } else if (staggeredGridAttribute.gap == 0.0 && staggeredGridAttribute.vGap != 0.0 && staggeredGridAttribute.hGap != 0.0) { //vGap行间距、hGap列间距同时定义了
            vLayoutData[index].top = staggeredGridAttribute.vGap
            vLayoutData[index].left = (itemWidth + staggeredGridAttribute.hGap) * Float64(index) + staggeredGridAttribute.hGap
            colHeightArray.add(itemHeightArray[index] + staggeredGridAttribute.vGap)
        } else if (staggeredGridAttribute.gap == 0.0 && staggeredGridAttribute.vGap == 0.0 && staggeredGridAttribute.hGap == 0.0) { //gap、vGap、hGap同时未定义
            vLayoutData[index].top = 0.0
            vLayoutData[index].left = itemWidth * Float64(index)
            colHeightArray.add(itemHeightArray[index])
        } else if (staggeredGridAttribute.gap != 0.0) { //三个都定义，只走gap
            vLayoutData[index].top = staggeredGridAttribute.gap
            vLayoutData[index].left = (itemWidth + staggeredGridAttribute.gap) * Float64(index) + staggeredGridAttribute.gap
            colHeightArray.add(itemHeightArray[index] + staggeredGridAttribute.gap)
        }
        return colHeightArray
    }

    func computedPositionOtherLine(colHeightArr: ArrayList<Float64>, index: Int64): ArrayList<Float64>{
        var colHeightArray = colHeightArr
        var minHeight = colHeightArray[0] //定义最小的高度
        var idx = 0 //定义最小高度的下标
        for (j in 0..lanes) {
            if (minHeight > colHeightArray[j]) {
                minHeight = colHeightArray[j]
                idx = j
            }
        }
        if (staggeredGridAttribute.gap != 0.0 && staggeredGridAttribute.vGap == 0.0 && staggeredGridAttribute.hGap == 0.0) { //gap行列间距定义了
            vLayoutData[index].top = colHeightArray[idx] + staggeredGridAttribute.gap
            vLayoutData[index].left = vLayoutData[idx].left
            colHeightArray[idx] = colHeightArray[idx] + itemHeightArray[index] + staggeredGridAttribute.gap
        } else if (staggeredGridAttribute.gap == 0.0 && staggeredGridAttribute.vGap != 0.0 && staggeredGridAttribute.hGap == 0.0) { //vGap行间距定义了
            vLayoutData[index].top = colHeightArray[idx] + staggeredGridAttribute.vGap
            vLayoutData[index].left = vLayoutData[idx].left
            colHeightArray[idx] = colHeightArray[idx] + itemHeightArray[index] + staggeredGridAttribute.vGap
        } else if (staggeredGridAttribute.gap == 0.0 && staggeredGridAttribute.vGap == 0.0 && staggeredGridAttribute.hGap != 0.0) { //hGap列间距定义了
            vLayoutData[index].top = colHeightArray[idx]
            vLayoutData[index].left = vLayoutData[idx].left
            colHeightArray[idx] = colHeightArray[idx] + itemHeightArray[index]
        } else if (staggeredGridAttribute.gap == 0.0 && staggeredGridAttribute.vGap != 0.0 && staggeredGridAttribute.hGap != 0.0) { //vGap行间距、hGap列间距同时定义了
            vLayoutData[index].top = colHeightArray[idx] + staggeredGridAttribute.vGap
            vLayoutData[index].left = vLayoutData[idx].left
            colHeightArray[idx] = colHeightArray[idx] + itemHeightArray[index] + staggeredGridAttribute.vGap
        } else if (staggeredGridAttribute.gap == 0.0 && staggeredGridAttribute.vGap == 0.0 && staggeredGridAttribute.hGap == 0.0) { //gap、vGap、hGap同时未定义
            vLayoutData[index].top = colHeightArray[idx]
            vLayoutData[index].left = vLayoutData[idx].left
            colHeightArray[idx] = colHeightArray[idx] + itemHeightArray[index]
        } else if (staggeredGridAttribute.gap != 0.0) { //三个都定义，只走gap
            vLayoutData[index].top = colHeightArray[idx] + staggeredGridAttribute.gap
            vLayoutData[index].left = vLayoutData[idx].left
            colHeightArray[idx] = colHeightArray[idx] + itemHeightArray[index] + staggeredGridAttribute.gap
        }
        return colHeightArray
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
                ForEach(vLayoutData, itemGeneratorFunc: {item: layoutDataType, position: Int64 =>
                    Stack() {
                        vLayoutContent(item, position)
                    }
                    .id("${vLayoutId}${position}")
                    .onAreaChange({ oldValue, newValue =>
                        layoutCount++
                        if (layoutCount > vLayoutData.size) {
                            return
                        }

                        let mSize: Array<Float64> = getSize("${vLayoutId}${position}")
                        itemHeight = px2vp(mSize[1].px)().value
                        if (staggeredGridAttribute.gap != 0.0 && staggeredGridAttribute.vGap == 0.0 && staggeredGridAttribute.hGap == 0.0 && lanes > 0) { //gap行列间距定义了
                            itemWidth = (staggeredWidth - Float64(lanes + 1) * staggeredGridAttribute.gap) / Float64(lanes)
                        } else if (staggeredGridAttribute.gap == 0.0 && staggeredGridAttribute.vGap != 0.0 && staggeredGridAttribute.hGap == 0.0 && lanes > 0) { //vGap行间距定义了
                            itemWidth = (staggeredWidth - Float64(lanes + 1) * staggeredGridAttribute.gap) / Float64(lanes)
                        } else if (staggeredGridAttribute.gap == 0.0 && staggeredGridAttribute.vGap == 0.0 && staggeredGridAttribute.hGap != 0.0 && lanes > 0) { //hGap列间距定义了
                            itemWidth = (staggeredWidth - Float64(lanes + 1) * staggeredGridAttribute.hGap) / Float64(lanes)
                        } else if (staggeredGridAttribute.gap == 0.0 && staggeredGridAttribute.vGap != 0.0 && staggeredGridAttribute.hGap != 0.0 && lanes > 0) { //vGap行间距、hGap列间距同时定义了
                            itemWidth = (staggeredWidth - Float64(lanes + 1) * staggeredGridAttribute.hGap) / Float64(lanes)
                        } else if (staggeredGridAttribute.gap == 0.0 && staggeredGridAttribute.vGap == 0.0 && staggeredGridAttribute.hGap == 0.0 && lanes > 0) { //gap、vGap、hGap同时未定义
                            itemWidth = (staggeredWidth - Float64(lanes + 1) * staggeredGridAttribute.gap) / Float64(lanes)
                        } else if (lanes != 0 && staggeredGridAttribute.gap != 0.0) { //三个都定义，只走gap
                            itemWidth = (staggeredWidth - Float64(lanes + 1) * staggeredGridAttribute.gap) / Float64(lanes)
                        }
                        itemHeightArray[position] = itemHeight
                        count = count + 1
                        computedPosition()
                    })
                    .width(itemWidth)
                    .position( x: item.left, y: item.top )
                })
            }
            .width(
                if(staggeredGridAttribute.gap != 0.0) {
                    (staggeredWidth + staggeredGridAttribute.hGap).vp
                } else if(staggeredGridAttribute.hGap != 0.0) {
                    (staggeredWidth + staggeredGridAttribute.gap).vp
                } else {
                    staggeredWidth.vp
                }
            )
            .height(
                if(colHeightArrayMax != 0.0) {
                    if(staggeredGridAttribute.gap == 0.0 && staggeredGridAttribute.vGap != 0.0) {
                        (colHeightArrayMax + staggeredGridAttribute.vGap).vp
                    } else if(staggeredGridAttribute.gap != 0.0) {
                        (colHeightArrayMax + staggeredGridAttribute.gap).vp
                    } else {
                        colHeightArrayMax.vp
                    }
                } else {
                      100.percent
                }
            )
            .padding(
                top: Utils.binaryExpression(staggeredGridAttribute.padding.size == 4, staggeredGridAttribute.padding, 0, staggeredGridAttribute.topPadding),
                right: Utils.binaryExpression(staggeredGridAttribute.padding.size == 4, staggeredGridAttribute.padding, 1, staggeredGridAttribute.rightPadding),
                bottom: Utils.binaryExpression(staggeredGridAttribute.padding.size == 4, staggeredGridAttribute.padding, 2, staggeredGridAttribute.bottomPadding),
                left: Utils.binaryExpression(staggeredGridAttribute.padding.size == 4, staggeredGridAttribute.padding, 3, staggeredGridAttribute.leftPadding)
            )
        }
        .backgroundColor(staggeredGridAttribute.bgColor)
        .opacity(staggeredGridAttribute.bgOpacity)
        .zIndex(staggeredGridAttribute.zIndex)
        .margin(
            top: Utils.binaryExpression(staggeredGridAttribute.margin.size == 4, staggeredGridAttribute.margin, 0, staggeredGridAttribute.topMargin),
            right:  Utils.binaryExpression(staggeredGridAttribute.margin.size == 4, staggeredGridAttribute.margin, 1, staggeredGridAttribute.rightMargin),
            bottom: Utils.binaryExpression(staggeredGridAttribute.margin.size == 4, staggeredGridAttribute.margin, 2, staggeredGridAttribute.bottomMargin),
            left: Utils.binaryExpression(staggeredGridAttribute.margin.size == 4, staggeredGridAttribute.margin, 3, staggeredGridAttribute.leftMargin)
        )
    }
}