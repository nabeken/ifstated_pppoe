#
# Author:: Ken-ichi TANABE (<nabeken@tknetworks.org>)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
include_recipe "ifstated_pppoe::gw"

template "/etc/hostname.carp0" do
  owner "root"
  group "wheel"
  mode 0600
  source "hostname.carp.erb"
  variables :advskew => 100,
            :vhid => 1,
            :carpdev => 'em1',
            :inet => '192.168.50.10 255.255.255.0'
end

template "/etc/hostname.carp1" do
  owner "root"
  group "wheel"
  mode 0600
  source "hostname.carp.erb"
  variables :advskew => 100,
            :vhid => 2,
            :carpdev => 'em2',
            :inet => '192.168.60.10 255.255.255.0'
end
