/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package vlayout4cj

import ohos.state_macro_manage.Component
import ohos.state_macro_manage.BuilderParam
import ohos.state_macro_manage.State

@Component
public class GridLayout {
    @BuilderParam var vLayoutContent: (layoutDataType, Int64, Float64) -> Unit //布局
    @State var gridAttribute: GridAttributes = GridAttributes() //属性
    var vLayoutData: Array<layoutDataType> = [] //数据源
    var layoutType: String = "grid"
    var TAG: String = 'vlayout GRID_LAYOUT '

    func build() {
        GridLayoutCommon(
            vLayoutContent: vLayoutContent,
            vLayoutData: vLayoutData,
            gridLayoutAttribute: gridAttribute,
            layoutType: layoutType,
            TAG: TAG
        )
    }
}
