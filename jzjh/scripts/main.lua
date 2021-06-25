package.path = package.path .. ';scripts\\?.lua'



require 'utility'
require 'native'
require 'common'
require 'blizzard'
require 'runtime'

local console = require 'jass.console'

console.write(package.path)
console.write("hello juezhan3")



require 'util.log'
require 'util.common'
require 'util.api'
require 'util.id'
require 'util.order_id'

require 'entity.init'

require 'util.general_bonus'
require 'util.general_buff'

local logic = require 'logic.init'
-- require 'ui.init'

local kungfu = require 'kungfu.init'

local function main()
    logic.init()
    kungfu.init()
    for k, v in pairs(require 'jass.japi') do
        print(k)
    end
end

main()




