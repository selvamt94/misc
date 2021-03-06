## Privilege Escalation

```
{
	"action": "violate",
	"aggregation_from": 1641549705,
	"cluster_name": "cluster.local",
	"count": 1,
	"enforcer_id": "c84320ee4d265748a94beb1953bee31d7fcb0eaa1d3d6e47d91186786cea1462",
	"enforcer_name": "allinone",
	"host_id": "debian64-auto:K6QR:PQYY:TJMD:FBY2:SX6V:6N3Y:JWH3:HNFX:L5VS:AEZ5:AU5B:T6OJ",
	"host_name": "debian64-auto",
	"id": "0b4bf9f9-a937-45bf-81a0-92d6c41e6501",
	"level": "Critical",
	"message": "Unauthorized root privilege escalation!",
	"name": "Container.Privilege.Escalation",
	"proc_cmd": "sh -c /usr/bin/passwd",
	"proc_effective_uid": 1000,
	"proc_effective_user": "test",
	"proc_name": "sh",
	"proc_parent_name": "cow",
	"proc_parent_path": "/tmp/case/cow",
	"proc_path": "/bin/dash",
	"proc_real_uid": 1000,
	"proc_real_user": "test",
	"reported_at": "2022-01-07T10:01:45Z",
	"reported_timestamp": 1641549705,
	"rule_id": "00000000-0000-0000-0000-000000000003",
	"workload_id": "80a5ab2b9dc6e148eab17d7f56ec004046b73c2ccd52180db92c1ebd4cebb76c",
	"workload_image": "quay.io/nvlab/ubuntu:14.04",
	"workload_name": "ubuntu",
	"workload_service": "nvlab:ubuntu"
},
```

## SQL Injection
```
{
  "action": "alert",
  "application": "MySQL",
  "cap_len": 119,
  "client_ip": "172.17.0.5",
  "client_port": 48452,
  "client_workload_id": "8246a19ee33cc4fa89b05abdcf9580fa60b9ba7eb934765e285c5ef925b74d9a",
  "client_workload_image": "iperfclient",
  "client_workload_name": "iperfclient",
  "client_workload_service": "iperfclient",
  "cluster_name": "cluster.local",
  "count": 1,
  "enforcer_id": "39c647deab1691ae0aa894b1c229d3f9a21ee2f719d29187203f9eff23ac7db5",
  "enforcer_name": "allinone",
  "ether_type": 2048,
  "group": "",
  "host_id": "NV-Ubuntu1604-Automation:32JS:JUQ6:CVBG:66ZA:O67X:3PBY:DLR2:K7MP:NLFJ:6L7C:6EQ6:NU3P",
  "host_name": "NV-Ubuntu1604-Automation",
  "icmp_code": 0,
  "icmp_type": 0,
  "id": "2fef5593-ece0-11ec-8086-20ea7ebb3f0c",
  "ip_proto": 6,
  "level": "Critical",
  "message": "SQL Injection, application=2001",
  "monitor": true,
  "name": "SQL.Injection",
  "reported_at": "2022-06-15T19:20:14Z",
  "reported_timestamp": 1655320814,
  "sensor": "",
  "server_conn_port": 3306,
  "server_ip": "172.17.0.4",
  "server_port": 3306,
  "server_workload_id": "ae791ec0bcb911e54da211e754a29b8fe1615d537183eb28bfeb2d797c74d2cf",
  "server_workload_image": "iperfserver",
  "server_workload_name": "iperfserver",
  "server_workload_service": "iperfserver",
  "severity": "Critical",
  "target": "server",
  "threat_id": 2022
}
```

## DDoS Attack
```
{
  "action": "alert",
  "application": "",
  "client_ip": "172.17.0.5",
  "client_port": 0,
  "client_workload_id": "a7834d9100a838b2c35b06c84c4c2df00e0e4cda0c3bf7a879c75ec46318e7ee",
  "client_workload_image": "iperfclient",
  "client_workload_name": "iperfclient",
  "client_workload_service": "iperfclient",
  "cluster_name": "cluster.local",
  "count": 1,
  "enforcer_id": "8a348dfd8cf4ccddd0415b6c59d93faadae02710bed21a1297da960c68a224d2",
  "enforcer_name": "allinone",
  "ether_type": 2048,
  "group": "",
  "host_id": "NV-Ubuntu1604-Automation:32JS:JUQ6:CVBG:66ZA:O67X:3PBY:DLR2:K7MP:NLFJ:6L7C:6EQ6:NU3P",
  "host_name": "NV-Ubuntu1604-Automation",
  "icmp_code": 0,
  "icmp_type": 8,
  "id": "797c28c2-ece1-11ec-8a61-63b3b04327b7",
  "ip_proto": 1,
  "level": "Critical",
  "message": "Packet rate 101(pps) exceeds the shreshold 100(pps)",
  "monitor": true,
  "name": "ICMP.Flood",
  "reported_at": "2022-06-15T19:29:28Z",
  "reported_timestamp": 1655321368,
  "sensor": "",
  "server_conn_port": 0,
  "server_ip": "172.17.0.4",
  "server_port": 0,
  "server_workload_id": "7408203d2c30ba427390ac4af1d3a678b6868cc9cf644986e7e77238706f28b2",
  "server_workload_image": "iperfserver",
  "server_workload_name": "iperfserver",
  "server_workload_service": "iperfserver",
  "severity": "Critical",
  "target": "server",
  "threat_id": 1002
}

{
  "action": "alert",
  "application": "",
  "cap_len": 32043,
  "client_ip": "172.17.0.5",
  "client_port": 0,
  "client_workload_id": "0bf5b7b04f964adbfab5feb1bd7b39e8a4fe3fb1f4a30b36bd72eb6f2d8ca221",
  "client_workload_image": "iperfclient",
  "client_workload_name": "iperfclient",
  "client_workload_service": "iperfclient",
  "cluster_name": "cluster.local",
  "count": 1,
  "enforcer_id": "9f1cfa2ebbb3cb4b0c3d9abcd066a602fe38409c0b9f855b4f6f9fed459322f0",
  "enforcer_name": "allinone",
  "ether_type": 2048,
  "group": "",
  "host_id": "NV-Ubuntu1604-Automation:32JS:JUQ6:CVBG:66ZA:O67X:3PBY:DLR2:K7MP:NLFJ:6L7C:6EQ6:NU3P",
  "host_name": "NV-Ubuntu1604-Automation",
  "icmp_code": 0,
  "icmp_type": 8,
  "id": "219f9a5b-ecdf-11ec-8d43-0f0e222151c4",
  "ip_proto": 1,
  "level": "Critical",
  "message": "Large ICMP packet payload of size 32001 (>32000)",
  "monitor": true,
  "name": "Ping.Death",
  "reported_at": "2022-06-15T19:12:42Z",
  "reported_timestamp": 1655320362,
  "sensor": "",
  "server_conn_port": 0,
  "server_ip": "172.17.0.4",
  "server_port": 0,
  "server_workload_id": "b6188ce78df73ce9894549407e1e63f6b053b8871eac837db58c6b71ebf9dad5",
  "server_workload_image": "iperfserver",
  "server_workload_name": "iperfserver",
  "server_workload_service": "iperfserver",
  "severity": "Critical",
  "target": "server",
  "threat_id": 2006
}
```

## Port Scanning

```
{
  "action": "violate",
  "aggregation_from": 1656001521,
  "client_ip": "172.17.0.5",
  "client_port": 46499,
  "cluster_name": "cluster.local",
  "count": 1,
  "enforcer_id": "59475b72a8a54730f31561abc8cb4c63eaf3fc866bafbd6f8caa7c4f664c1001",
  "enforcer_name": "allinone",
  "ether_type": 2048,
  "group": "nv.nvlab:debian_iperf",
  "host_id": "NV-Ubuntu1604-Automation:32JS:JUQ6:CVBG:66ZA:O67X:3PBY:DLR2:K7MP:NLFJ:6L7C:6EQ6:NU3P",
  "host_name": "NV-Ubuntu1604-Automation",
  "id": "2fd75a1a-07c3-4749-8918-e2875b6403a0",
  "ip_proto": 17,
  "level": "Warning",
  "message": "Risky application: Port Scanner",
  "name": "Container.Suspicious.Process",
  "proc_cmd": "nmap -v -iR 10000 -Pn -p 80",
  "proc_effective_user": "root",
  "proc_name": "nmap",
  "proc_parent_name": "bash",
  "proc_parent_path": "/bin/bash",
  "proc_path": "/usr/bin/nmap",
  "remote_workload_id": "external",
  "remote_workload_name": "external",
  "reported_at": "2022-06-23T16:25:21Z",
  "reported_timestamp": 1656001521,
  "rule_id": "00000000-0000-0000-0000-000000000001",
  "server_conn_port": 53,
  "server_ip": "8.8.8.8",
  "server_port": 53,
  "workload_id": "83918a56d19628f9445b88c75d0c6020a87bc9e16625c10695217d3a2e10aab9",
  "workload_image": "quay.io/nvlab/debian_iperf",
  "workload_name": "iperfserver",
  "workload_service": "nvlab:debian_iperf"
}
```

## Reverse Shell
```
{
  "action": "violate",
  "aggregation_from": 1655331080,
  "client_ip": "0.0.0.0",
  "client_port": 47521,
  "cluster_name": "cluster.local",
  "count": 1,
  "enforcer_id": "0032eafbadb6747040b1d1eea3e787641217dcfd57382a111e3f4f0b0d33253a",
  "enforcer_name": "allinone",
  "ether_type": 2048,
  "group": "nv.iperfclient",
  "host_id": "NV-Ubuntu1604-Automation:32JS:JUQ6:CVBG:66ZA:O67X:3PBY:DLR2:K7MP:NLFJ:6L7C:6EQ6:NU3P",
  "host_name": "NV-Ubuntu1604-Automation",
  "id": "ebe42509-642b-479b-9ea5-d30e1a894eb4",
  "ip_proto": 17,
  "level": "Warning",
  "message": "Risky application: dns tunneling",
  "name": "Container.Suspicious.Process",
  "proc_cmd": "/tmp/dns_tunneling/iodine/bin/iodine -f -r -P     mytest.com",
  "proc_effective_user": "root",
  "proc_name": "iodine",
  "proc_parent_name": "sh",
  "proc_parent_path": "/bin/dash",
  "proc_path": "/tmp/dns_tunneling/iodine/bin/iodine",
  "remote_workload_id": "external",
  "remote_workload_name": "external",
  "reported_at": "2022-06-15T22:11:20Z",
  "reported_timestamp": 1655331080,
  "rule_id": "00000000-0000-0000-0000-000000000001",
  "server_ip": "0.0.0.0",
  "workload_id": "b35070b4f04c3adb4815fb7ab99cd0a6783c89ef44074e8f3bbb1576f38c1927",
  "workload_image": "iperfclient",
  "workload_name": "iperfclient",
  "workload_service": "iperfclient"
}

{
  "action": "violate",
  "aggregation_from": 1655320149,
  "client_ip": "172.17.0.5",
  "client_port": 57228,
  "cluster_name": "cluster.local",
  "count": 1,
  "enforcer_id": "86330c2ba281b78e0a003c39317b5eb34e44be5fa8b3c9dce78b4555b0463bd5",
  "enforcer_name": "allinone",
  "ether_type": 2048,
  "group": "nv.iperfclient",
  "host_id": "NV-Ubuntu1604-Automation:32JS:JUQ6:CVBG:66ZA:O67X:3PBY:DLR2:K7MP:NLFJ:6L7C:6EQ6:NU3P",
  "host_name": "NV-Ubuntu1604-Automation",
  "id": "ac034635-1801-40f5-a62f-c9d2bc726180",
  "ip_proto": 6,
  "level": "Warning",
  "message": "Tunnel detected: reverse shell",
  "name": "Container.Tunnel.Detected",
  "proc_cmd": "sleep 20",
  "proc_effective_user": "root",
  "proc_name": "sleep",
  "proc_parent_name": "sh",
  "proc_parent_path": "/bin/dash",
  "proc_path": "/bin/sleep",
  "remote_workload_id": "1ac21b26f5255efeab642b784a0f8412d74c8f0ccb6af42c7a6e7d2765ea0526",
  "remote_workload_image": "iperfserver",
  "remote_workload_name": "iperfserver",
  "remote_workload_service": "iperfserver",
  "reported_at": "2022-06-15T19:09:09Z",
  "reported_timestamp": 1655320149,
  "rule_id": "00000000-0000-0000-0000-000000000002",
  "server_conn_port": 6068,
  "server_ip": "172.17.0.4",
  "server_port": 6068,
  "workload_id": "b56ae1241bfa6031cb3836265fbf11dbdd03f16bf9f811ffcb934391e7674586",
  "workload_image": "iperfclient",
  "workload_name": "iperfclient",
  "workload_service": "iperfclient"
}

{
  "action": "violate",
  "aggregation_from": 1655331080,
  "client_ip": "0.0.0.0",
  "client_port": 47521,
  "cluster_name": "cluster.local",
  "count": 1,
  "enforcer_id": "0032eafbadb6747040b1d1eea3e787641217dcfd57382a111e3f4f0b0d33253a",
  "enforcer_name": "allinone",
  "ether_type": 2048,
  "group": "nv.iperfclient",
  "host_id": "NV-Ubuntu1604-Automation:32JS:JUQ6:CVBG:66ZA:O67X:3PBY:DLR2:K7MP:NLFJ:6L7C:6EQ6:NU3P",
  "host_name": "NV-Ubuntu1604-Automation",
  "id": "ebe42509-642b-479b-9ea5-d30e1a894eb4",
  "ip_proto": 17,
  "level": "Warning",
  "message": "Risky application: dns tunneling",
  "name": "Container.Suspicious.Process",
  "proc_cmd": "/tmp/dns_tunneling/iodine/bin/iodine -f -r -P     mytest.com",
  "proc_effective_user": "root",
  "proc_name": "iodine",
  "proc_parent_name": "sh",
  "proc_parent_path": "/bin/dash",
  "proc_path": "/tmp/dns_tunneling/iodine/bin/iodine",
  "remote_workload_id": "external",
  "remote_workload_name": "external",
  "reported_at": "2022-06-15T22:11:20Z",
  "reported_timestamp": 1655331080,
  "rule_id": "00000000-0000-0000-0000-000000000001",
  "server_ip": "0.0.0.0",
  "workload_id": "b35070b4f04c3adb4815fb7ab99cd0a6783c89ef44074e8f3bbb1576f38c1927",
  "workload_image": "iperfclient",
  "workload_name": "iperfclient",
  "workload_service": "iperfclient"
}

{
  "action": "violate",
  "aggregation_from": 1655320149,
  "client_ip": "172.17.0.5",
  "client_port": 57228,
  "cluster_name": "cluster.local",
  "count": 1,
  "enforcer_id": "86330c2ba281b78e0a003c39317b5eb34e44be5fa8b3c9dce78b4555b0463bd5",
  "enforcer_name": "allinone",
  "ether_type": 2048,
  "group": "nv.iperfclient",
  "host_id": "NV-Ubuntu1604-Automation:32JS:JUQ6:CVBG:66ZA:O67X:3PBY:DLR2:K7MP:NLFJ:6L7C:6EQ6:NU3P",
  "host_name": "NV-Ubuntu1604-Automation",
  "id": "ac034635-1801-40f5-a62f-c9d2bc726180",
  "ip_proto": 6,
  "level": "Warning",
  "message": "Tunnel detected: reverse shell",
  "name": "Container.Tunnel.Detected",
  "proc_cmd": "sleep 20",
  "proc_effective_user": "root",
  "proc_name": "sleep",
  "proc_parent_name": "sh",
  "proc_parent_path": "/bin/dash",
  "proc_path": "/bin/sleep",
  "remote_workload_id": "1ac21b26f5255efeab642b784a0f8412d74c8f0ccb6af42c7a6e7d2765ea0526",
  "remote_workload_image": "iperfserver",
  "remote_workload_name": "iperfserver",
  "remote_workload_service": "iperfserver",
  "reported_at": "2022-06-15T19:09:09Z",
  "reported_timestamp": 1655320149,
  "rule_id": "00000000-0000-0000-0000-000000000002",
  "server_conn_port": 6068,
  "server_ip": "172.17.0.4",
  "server_port": 6068,
  "workload_id": "b56ae1241bfa6031cb3836265fbf11dbdd03f16bf9f811ffcb934391e7674586",
  "workload_image": "iperfclient",
  "workload_name": "iperfclient",
  "workload_service": "iperfclient"
}
```


## Known Malicious Kubernetes pod

This protection is done through admission control. The follow log is triggered when the image that has high severity vulnerability is being deployed.

```
{
  "aggregation_from": 1655340791,
  "base_os": "alpine:3.7.0",
  "cluster_name": "cluster.local",
  "count": 1,
  "enforcer_id": "",
  "enforcer_name": "",
  "high_vul_cnt": 111,
  "host_id": "",
  "host_name": "",
  "image_id": "e0adb7924bc1cb0a22c568890beba74c096d9414a6308a48b2ac5f8ad0142e47",
  "level": "Critical",
  "medium_vul_cnt": 35,
  "message": "Creation of Kubernetes Deployment resource (alpinehttp) is denied because of deny rule id 1000 with criteria: (count of high severity CVE >= 1)",
  "name": "Admission.Control.Denied",
  "registry": "https://quay.io/",
  "reported_at": "2022-06-16T00:53:11Z",
  "reported_timestamp": 1655340791,
  "repository": "nvlab/alpine_http",
  "tag": "latest",
  "user": "kubernetes-admin",
  "workload_domain": "default",
  "workload_image": "quay.io/nvlab/alpine_http"
}
```

## Potentially dangerous container command execution
```
{
  "action": "violate",
  "aggregation_from": 1655330627,
  "client_ip": "10.1.7.61",
  "client_port": 51158,
  "cluster_name": "cluster.local",
  "count": 5,
  "enforcer_id": "3c858668e090e281b5497411296abcaabdc95ffdd6fa4b8f1a94700973f11f6d",
  "enforcer_name": "allinone",
  "ether_type": 2048,
  "group": "nodes",
  "host_id": "NV-Ubuntu1604-Automation:32JS:JUQ6:CVBG:66ZA:O67X:3PBY:DLR2:K7MP:NLFJ:6L7C:6EQ6:NU3P",
  "host_name": "NV-Ubuntu1604-Automation",
  "id": "606fa9c5-0ce8-48bc-b647-26a449dc5e58",
  "ip_proto": 6,
  "level": "Warning",
  "message": "Risky application: ssh to remote",
  "name": "Host.Suspicious.Process",
  "proc_cmd": "ssh -o StrictHostKeyChecking no 10.1.7.61 hostname",
  "proc_effective_user": "root",
  "proc_name": "ssh",
  "proc_parent_name": "auto.sh",
  "proc_parent_path": "/bin/bash",
  "proc_path": "/usr/bin/ssh",
  "remote_workload_id": "10.1.7.61",
  "remote_workload_name": "10.1.7.61",
  "reported_at": "2022-06-15T22:04:18Z",
  "reported_timestamp": 1655330658,
  "rule_id": "00000000-0000-0000-0000-000000000001",
  "server_conn_port": 22,
  "server_ip": "10.1.7.61",
  "server_port": 22
}

{
  "action": "violate",
  "aggregation_from": 1655320130,
  "client_ip": "172.17.0.5",
  "client_port": 57228,
  "cluster_name": "cluster.local",
  "count": 1,
  "enforcer_id": "86330c2ba281b78e0a003c39317b5eb34e44be5fa8b3c9dce78b4555b0463bd5",
  "enforcer_name": "allinone",
  "ether_type": 2048,
  "group": "nv.iperfclient",
  "host_id": "NV-Ubuntu1604-Automation:32JS:JUQ6:CVBG:66ZA:O67X:3PBY:DLR2:K7MP:NLFJ:6L7C:6EQ6:NU3P",
  "host_name": "NV-Ubuntu1604-Automation",
  "id": "e54406a8-2683-447d-ac0b-6000b7979446",
  "ip_proto": 6,
  "level": "Warning",
  "message": "Risky application: netcat process",
  "name": "Container.Suspicious.Process",
  "proc_cmd": "sleep 20",
  "proc_effective_user": "root",
  "proc_name": "sleep",
  "proc_parent_name": "sh",
  "proc_parent_path": "/bin/dash",
  "proc_path": "/bin/sleep",
  "remote_workload_id": "1ac21b26f5255efeab642b784a0f8412d74c8f0ccb6af42c7a6e7d2765ea0526",
  "remote_workload_image": "iperfserver",
  "remote_workload_name": "iperfserver",
  "remote_workload_service": "iperfserver",
  "reported_at": "2022-06-15T19:08:50Z",
  "reported_timestamp": 1655320130,
  "rule_id": "00000000-0000-0000-0000-000000000001",
  "server_conn_port": 6068,
  "server_ip": "172.17.0.4",
  "server_port": 6068,
  "workload_id": "b56ae1241bfa6031cb3836265fbf11dbdd03f16bf9f811ffcb934391e7674586",
  "workload_image": "iperfclient",
  "workload_name": "iperfclient",
  "workload_service": "iperfclient"
}
```

## New cluster role with exec permissions

We are working on the feature that monitor and audit various of kubernetes resources, including risking RBAC setting. We target releasing the feature in 5.1.

## Unauthenticated command execution in a Pod
```
{
  "action": "violate",
  "aggregation_from": 1655320647,
  "cluster_name": "cluster.local",
  "count": 1,
  "enforcer_id": "9646e7f46d1821ff7a1b57eea76720bd0fd786a2ff169386fc321bde82ed054a",
  "enforcer_name": "allinone",
  "group": "nv.iperfclient",
  "host_id": "NV-Ubuntu1604-Automation:32JS:JUQ6:CVBG:66ZA:O67X:3PBY:DLR2:K7MP:NLFJ:6L7C:6EQ6:NU3P",
  "host_name": "NV-Ubuntu1604-Automation",
  "id": "97a843df-49ca-44e2-b02c-0b35a47585af",
  "level": "Warning",
  "message": "Process profile violation, not from an image file",
  "name": "Process.Profile.Violation",
  "proc_cmd": "route -n",
  "proc_effective_user": "root",
  "proc_name": "route",
  "proc_parent_name": "sh",
  "proc_parent_path": "/bin/dash",
  "proc_path": "/sbin/route",
  "reported_at": "2022-06-15T19:17:27Z",
  "reported_timestamp": 1655320647,
  "rule_id": "00000000-0000-0000-0000-000000000005",
  "workload_id": "128aa2bae513a480e1ac135ba29ac8b6886546ccc2948e8eb0cd3f2b8233b130",
  "workload_image": "iperfclient",
  "workload_name": "iperfclient",
  "workload_service": "iperfclient"
}

{
  "action": "violate",
  "aggregation_from": 1655320601,
  "cluster_name": "cluster.local",
  "enforcer_id": "9646e7f46d1821ff7a1b57eea76720bd0fd786a2ff169386fc321bde82ed054a",
  "enforcer_name": "allinone",
  "file_path": "/sbin/getcap, /sbin/sysctl, /usr/bin/uptime, /bin/ss, /sbin/setcap, /sbin/plipconfig, /usr/bin/peekfd, /sbin/rtmon, /sbin/getpcaps, /usr/bin/skill, /usr/bin/vmstat, /sbin/ipmaddr, /usr/bin/routel, /usr/sbin/arpd, /usr/bin/killall, /bin/fuser, /usr/bin/tload, /usr/bin/top, /sbin/devlink, /sbin/nameif, /usr/bin/lnstat, /bin/ps, /usr/bin/w.procps, /usr/bin/pmap, /usr/bin/watch, /sbin/ifconfig, /sbin/rtacct, /sbin/mii-tool, /var/lib/dpkg/status, /usr/bin/pstree, /sbin/tipc, /usr/bin/prtstat, /sbin/route, /sbin/tc, /sbin/iptunnel, /bin/netstat, /sbin/bridge, /usr/sbin/genl, /usr/bin/slabtop, /sbin/capsh, /bin/ip, /usr/bin/rdma, /usr/bin/pgrep, /usr/bin/pwdx, /sbin/rarp, /sbin/slattach, /usr/bin/pslog, /usr/sbin/tcpdump, /usr/bin/free, /usr/bin/nstat, /usr/bin/routef",
  "group": "nv.iperfclient",
  "host_id": "NV-Ubuntu1604-Automation:32JS:JUQ6:CVBG:66ZA:O67X:3PBY:DLR2:K7MP:NLFJ:6L7C:6EQ6:NU3P",
  "host_name": "NV-Ubuntu1604-Automation",
  "id": "4917f1c6-2ef8-4dc4-9976-1a3ee3b6bc62",
  "level": "Warning",
  "message": "Software packages were updated.",
  "name": "Container.Package.Updated",
  "proc_cmd": "/usr/bin/dpkg --status-fd 15 --no-triggers --unpack --auto-deconfigure --recursive /tmp/apt-dpkg-install-SRIMAq",
  "proc_effective_user": "root",
  "proc_name": "dpkg",
  "proc_path": "/usr/bin/dpkg",
  "reported_at": "2022-06-15T19:17:38Z",
  "reported_timestamp": 1655320658,
  "rule_id": "",
  "workload_id": "128aa2bae513a480e1ac135ba29ac8b6886546ccc2948e8eb0cd3f2b8233b130",
  "workload_name": "128aa2bae513a480e1ac135ba29ac8b6886546ccc2948e8eb0cd3f2b8233b130"
}
```

## Any other scenarios that you think are relevant

```
{
  "action": "alert",
  "application": "HTTP",
  "cap_len": 167,
  "client_ip": "172.17.0.5",
  "client_port": 9999,
  "client_workload_id": "7a761d713a99e52123d2a949aaf6758f11d7db75c9392a1d2959d330003ea906",
  "client_workload_image": "iperfclient",
  "client_workload_name": "iperfclient",
  "client_workload_service": "iperfclient",
  "cluster_name": "cluster.local",
  "count": 1,
  "enforcer_id": "d2df6a5bf0154e91a01a7c691ac035f91924869786366c00b7d657305defb5a8",
  "enforcer_name": "allinone",
  "ether_type": 2048,
  "group": "",
  "host_id": "NV-Ubuntu1604-Automation:32JS:JUQ6:CVBG:66ZA:O67X:3PBY:DLR2:K7MP:NLFJ:6L7C:6EQ6:NU3P",
  "host_name": "NV-Ubuntu1604-Automation",
  "icmp_code": 0,
  "icmp_type": 0,
  "id": "05e3c891-ece1-11ec-8634-6089c2a6ab86",
  "ip_proto": 6,
  "level": "Error",
  "message": "Content-Length header has negative value",
  "monitor": true,
  "name": "HTTP.Negative.Body.Length",
  "reported_at": "2022-06-15T19:26:13Z",
  "reported_timestamp": 1655321173,
  "sensor": "",
  "server_conn_port": 6068,
  "server_ip": "172.17.0.4",
  "server_port": 6068,
  "server_workload_id": "5f1f1d6ca9a3d9d2d5792768ef4b00066f49a095fe0bc8a6c15ecad15585eef3",
  "server_workload_image": "iperfserver",
  "server_workload_name": "iperfserver",
  "server_workload_service": "iperfserver",
  "severity": "High",
  "target": "server",
  "threat_id": 2013
}

{
  "action": "violate",
  "aggregation_from": 1655320601,
  "cluster_name": "cluster.local",
  "enforcer_id": "9646e7f46d1821ff7a1b57eea76720bd0fd786a2ff169386fc321bde82ed054a",
  "enforcer_name": "allinone",
  "file_path": "/sbin/getcap, /sbin/sysctl, /usr/bin/uptime, /bin/ss, /sbin/setcap, /sbin/plipconfig, /usr/bin/peekfd, /sbin/rtmon, /sbin/getpcaps, /usr/bin/skill, /usr/bin/vmstat, /sbin/ipmaddr, /usr/bin/routel, /usr/sbin/arpd, /usr/bin/killall, /bin/fuser, /usr/bin/tload, /usr/bin/top, /sbin/devlink, /sbin/nameif, /usr/bin/lnstat, /bin/ps, /usr/bin/w.procps, /usr/bin/pmap, /usr/bin/watch, /sbin/ifconfig, /sbin/rtacct, /sbin/mii-tool, /var/lib/dpkg/status, /usr/bin/pstree, /sbin/tipc, /usr/bin/prtstat, /sbin/route, /sbin/tc, /sbin/iptunnel, /bin/netstat, /sbin/bridge, /usr/sbin/genl, /usr/bin/slabtop, /sbin/capsh, /bin/ip, /usr/bin/rdma, /usr/bin/pgrep, /usr/bin/pwdx, /sbin/rarp, /sbin/slattach, /usr/bin/pslog, /usr/sbin/tcpdump, /usr/bin/free, /usr/bin/nstat, /usr/bin/routef",
  "group": "nv.iperfclient",
  "host_id": "NV-Ubuntu1604-Automation:32JS:JUQ6:CVBG:66ZA:O67X:3PBY:DLR2:K7MP:NLFJ:6L7C:6EQ6:NU3P",
  "host_name": "NV-Ubuntu1604-Automation",
  "id": "4917f1c6-2ef8-4dc4-9976-1a3ee3b6bc62",
  "level": "Warning",
  "message": "Software packages were updated.",
  "name": "Container.Package.Updated",
  "proc_cmd": "/usr/bin/dpkg --status-fd 15 --no-triggers --unpack --auto-deconfigure --recursive /tmp/apt-dpkg-install-SRIMAq",
  "proc_effective_user": "root",
  "proc_name": "dpkg",
  "proc_path": "/usr/bin/dpkg",
  "reported_at": "2022-06-15T19:17:38Z",
  "reported_timestamp": 1655320658,
  "rule_id": "",
  "workload_id": "128aa2bae513a480e1ac135ba29ac8b6886546ccc2948e8eb0cd3f2b8233b130",
  "workload_name": "128aa2bae513a480e1ac135ba29ac8b6886546ccc2948e8eb0cd3f2b8233b130"
}

{
  "action": "violate",
  "aggregation_from": 1655321551,
  "cluster_name": "cluster.local",
  "count": 1,
  "enforcer_id": "d6e07f1faf075d009fbbc79612363c81205d42f45310d172049d022401b9f8ed",
  "enforcer_name": "allinone",
  "file_path": "/etc/shadow",
  "group": "nv.nvlab:ubuntu",
  "host_id": "NV-Ubuntu1604-Automation:32JS:JUQ6:CVBG:66ZA:O67X:3PBY:DLR2:K7MP:NLFJ:6L7C:6EQ6:NU3P",
  "host_name": "NV-Ubuntu1604-Automation",
  "id": "9a228aa1-13c9-4bde-bf1a-9f0b0c005c88",
  "level": "Warning",
  "message": "File was modified.",
  "name": "Container.FileAccess.Violation",
  "proc_cmd": "/usr/sbin/useradd -d /home/test -g root -s /bin/bash -u 1000 test",
  "proc_effective_user": "root",
  "proc_name": "useradd",
  "proc_path": "/usr/sbin/useradd",
  "reported_at": "2022-06-15T19:32:53Z",
  "reported_timestamp": 1655321573,
  "rule_id": "",
  "workload_id": "4f065f605bbd92432f7546793662bda5060c6b4fe87d90b5c6a959adbc8230fe",
  "workload_image": "quay.io/nvlab/ubuntu:14.04",
  "workload_name": "ubuntu",
  "workload_service": "nvlab:ubuntu"
}
```