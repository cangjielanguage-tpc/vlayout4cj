/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package vlayout4cj

import ohos.state_macro_manage.Component
import ohos.state_macro_manage.BuilderParam
import ohos.state_macro_manage.State

@Component
public class ScrollFixLayout {
    @BuilderParam var vLayoutContent: (layoutDataType, Int64) -> Unit //布局
    @State var scrollAttribute: FixAreaAttributes = FixAreaAttributes() //属性
    var vLayoutData: Array<layoutDataType> = [] //数据源
    var layoutType: String = "scroll"
    var TAG: String = 'vlayout SCROLL_FIX_LAYOUT '

    func build() {
        ScrollFixFloatLayoutCommon(
            vLayoutContent: vLayoutContent,
            vLayoutData: vLayoutData,
            vLayoutAttribute: scrollAttribute,
            layoutType: layoutType,
            TAG: TAG
        )
    }
}