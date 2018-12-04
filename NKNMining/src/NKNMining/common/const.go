package common

const NS_VERSION  = "NKNMining v0.0.4"
const API_VERSION  = "NKNMining.v1"

const (
	NKN_NODE_RUNNING = iota
	NKN_NODE_EXITED
)

const (
	NS_STATUS_CTEATE_ACCOUNT = 0
	NS_STATUS_GEN_WALLET = 1
	NS_STATUS_NODE_RUNNING = 2
	NS_STATUS_NODE_EXITED = 3
	NS_STATUS_NODE_UPDATE = 4
	NS_STATUS_INITIALIZATION = 5
)

const (
	NS_MUTEX_PORT = "127.0.0.1:8180"
)