all:
  hosts:
%{ for node in nodes ~}
    "${node.name}":
      ansible_host: "${node.public_ip}"
      ip: "${node.ip}"
      access_ip: "${node.ip}"
%{ endfor ~}
  children:
    kube_control_plane:
      hosts:
%{ for index, node in nodes ~}
%{ if index < 2 ~}
        "${node.name}":
%{ endif ~}
%{ endfor ~}
    kube_node:
      hosts:
%{ for node in nodes ~}
        "${node.name}":
%{ endfor ~}
    etcd:
      hosts:
%{ for index, node in nodes ~}
%{ if index < 3 ~}
        "${node.name}":
%{ endif ~}
%{ endfor ~}
    k8s_cluster:
      children:
        kube_control_plane:
        kube_node:
    calico_rr:
      hosts: {}