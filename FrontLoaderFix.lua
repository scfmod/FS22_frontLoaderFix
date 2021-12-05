
local FrontLoaderFix = {
    override = false
}

function FrontLoaderFix.beforeOnPreAttachImplement()
    FrontLoaderFix.override = true
end
function FrontLoaderFix.afterOnPreAttachImplement()
    FrontLoaderFix.override = false
end

function FrontLoaderFix.setComponentJointRotLimit(self, func, ...)
    if FrontLoaderFix.override ~= true then
        func(self, ...)
    end
end


FrontloaderAttacher.onPreAttachImplement = Utils.prependedFunction(
    FrontloaderAttacher.onPreAttachImplement,
    FrontLoaderFix.beforeOnPreAttachImplement
)

FrontloaderAttacher.onPreAttachImplement = Utils.appendedFunction(
    FrontloaderAttacher.onPreAttachImplement,
    FrontLoaderFix.afterOnPreAttachImplement
)

Vehicle.setComponentJointRotLimit = Utils.overwrittenFunction(
    Vehicle.setComponentJointRotLimit,
    FrontLoaderFix.setComponentJointRotLimit
)