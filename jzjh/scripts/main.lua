require 'scripts.utility'
require 'scripts.native'
require 'scripts.common'
require 'scripts.blizzard'
require 'scripts.runtime'

local console = require 'jass.console'

console.write("hello juezhan")

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
end

main()




