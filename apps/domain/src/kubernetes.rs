#[derive(serde::Deserialize,Debug)]
pub struct DeploymentStatus {
    #[serde(rename="availableReplicas")]
    pub available_replicas: Option<u8>,
}

#[derive(serde::Deserialize,Debug)]
pub struct LabelSelector {
    #[serde(rename="matchLabels")]
    pub match_labels: std::collections::BTreeMap<String, String>,
}

#[derive(serde::Deserialize,Debug)]
pub struct DeploymentSpec {
    pub replicas: u8,
    pub selector: LabelSelector,
}

#[derive(serde::Deserialize,Debug)]
pub struct Deployment {
    pub metadata: Metadata,
    pub spec: DeploymentSpec,
    pub status: DeploymentStatus,
}

#[derive(serde::Deserialize,Debug)]
pub struct OwnerReference {
    pub kind: String,
    pub name: String,
}

#[derive(serde::Deserialize,Debug)]
pub struct Metadata {
    pub namespace: String,
    pub labels: Option<std::collections::BTreeMap<String, String>>,
    #[serde(rename="ownerReferences")]
    pub owner_references: Option<Vec<OwnerReference>>,
}

#[derive(serde::Deserialize,Debug)]
pub struct ReplicaSetSpec {
    pub replicas: u8,
    pub selector: LabelSelector,
}

#[derive(serde::Deserialize,Debug)]
pub struct ReplicaSet {
    pub metadata: Metadata,
    pub spec: ReplicaSetSpec,
}

#[derive(serde::Deserialize,Debug)]
pub struct PodSpec {
    #[serde(rename="nodeName")]
    pub node_name: String,
}

#[derive(serde::Deserialize,Debug)]
pub struct Pod {
    pub spec: PodSpec,
}

#[derive(serde::Deserialize,Debug)]
pub struct NodeAddress {
    pub address: String,
    #[serde(rename="type")]
    pub type_: String,
}

#[derive(serde::Deserialize,Debug)]
pub struct NodeStatus {
    pub addresses: Vec<NodeAddress>,
}

#[derive(serde::Deserialize,Debug)]
pub struct Node {
    pub status: NodeStatus,
}

#[derive(serde::Deserialize,Debug)]
pub struct ObjectList<T> {
    pub items: Vec<T>,
}
