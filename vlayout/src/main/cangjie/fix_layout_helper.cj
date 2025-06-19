/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package vlayout4cj

import ohos.state_macro_manage.Component
import ohos.state_macro_manage.BuilderParam
import ohos.state_macro_manage.State

@Component
public class FixLayout {
    @BuilderParam var vLayoutContent: (layoutDataType, Int64) -> Unit //布局
    @State var fixAttribute: FixAreaAttributes = FixAreaAttributes() //属性
    var vLayoutData: Array<layoutDataType> = [] //数据源
    var layoutType: String = "fix"
    var TAG: String = 'vlayout FIX_LAYOUT '

    func build() {
        ScrollFixFloatLayoutCommon(
            vLayoutContent: vLayoutContent,
            vLayoutData: vLayoutData,
            vLayoutAttribute: fixAttribute,
            layoutType: layoutType,
            TAG: TAG
        )
    }
}