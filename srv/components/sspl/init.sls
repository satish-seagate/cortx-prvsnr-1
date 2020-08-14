#
# Copyright (c) 2020 Seagate Technology LLC and/or its Affiliates
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# For any questions about this software or licensing,
# please email opensource@seagate.com or cortx-questions@seagate.com.
#

{% if not salt['file.file_exists']('/opt/seagate/cortx/provisioner/generated_configs/{0}.sspl'.format(grains['id'])) %}
include:
  - components.sspl.prepare
  - components.sspl.install
  - components.sspl.config
  - components.sspl.start
#  - components.sspl.sanity_check

Generate sspl checkpoint flag:
  file.managed:
    - name: /opt/seagate/cortx/provisioner/generated_configs/{{ grains['id'] }}.sspl
    - makedirs: True
    - create: True
    - order: last

{%- else -%}

SSPL already applied:
  test.show_notification:
    - text: "SSPL states already executed on node: {{ grains['id'] }}. Execute 'salt '*' state.apply components.sspl.teardown' to reprovision these states."

{%- endif -%}
