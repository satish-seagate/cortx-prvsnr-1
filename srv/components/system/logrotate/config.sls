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

# general settings
Logrotate config file - Generic:
  file.managed:
    - name: /etc/logrotate.conf
    - source: salt://components/system/logrotate/files/etc/logrotate.conf

# logrotate.d
Create logrotate.d with specific component settings:
  file.recurse:
  - name: /etc/logrotate.d
  - source: salt://components/system/logrotate/files/etc/logrotate.d
  - keep_source: True
  - dir_mode: 0750
  - file_mode: 0640
  - user: root
  - group: root
  - clean: False
  - include_empty: True

Setup cron job:
  file.managed:
    - name: /etc/cron.daily/logrotate
    - contents: |
        #!/bin/sh
        /usr/sbin/logrotate -s /var/lib/logrotate/logrotate.status /etc/logrotate.conf
        EXITVALUE=$?
        if [ $EXITVALUE != 0 ]; then
            /usr/bin/logger -t logrotate "ALERT exited abnormally with [$EXITVALUE]"
        fi
        exit 0
    - create: True
    - makedirs: True
    - replace: False
    - user: root
    - group: root
    - dir_mode: 755
    - mode: 0700
