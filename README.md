## README

## Test deployment

### Contract code

Contract TxMesh.sol compiled to txmeshdemo.go:

```shell
abigen -sol . /TxMesh.sol -pkg contract -out . /txmeshdemo.go
```

### Use **Ganache** to build test chain

! [ganache](. /ganache.jpg)

```shell
Key data
chainid default 1337
rpcserver http://192.168.0.104:7545
```

## Compile environment and modify configuration

### Compile environment

```shell
git clone
cd txmeshdemo
. /buildall.sh
```

Generate three node folders

```shell
$HOME/node1
$HOME/node2
$HOME/node3
```

### Modify the configuration

1. Modify txmeshdemo/conf/gateway.yaml

```yaml
addr: :8752
LogLevel: ErrorLevel
Mode: release
contracts:
  privkey: 26db4dea5a9d37de2df60d4a5feec49f438a87928b14e15cc71523409ed413e0 ##Consistent with index0 account's private key in ganache
  endpoint: http://192.168.0.104:7545 ##consistent with the RPC SERVER in ganache
  chainid: 1337 ##ganache default chainid=1337
```

2. Modify $HOME/node1/conf/clients.yaml

```shell
addr: :8753
Mode: release
GatewayPath: localhost:8752
LogLevel: ErrorLevel
contracts:
  privkey: 985741ab0e9057eb54405716421ad211b8715d0fda87dc8f2af53c6efdba21f7 ## consistent with index1 account's private key in ganache
  endpoint: http://192.168.0.104:7545
  chainid: 1337
```

3. Modify $HOME/node2/conf/clients.yaml

```shell
addr: :8754
Mode: release
GatewayPath: localhost:8752
LogLevel: ErrorLevel
contracts:
  privkey: 5dc85cb2f753d93913396f538c4bfda30b059c2268f416c2a3bff4c15e542da2 ## consistent with index2 account's private key in ganache
  endpoint: http://192.168.0.104:7545
  chainid: 1337
```

4. Modify $HOME/node3/conf/clients.yaml

```shell
addr: :8755
Mode: release
GatewayPath: localhost:8752
LogLevel: ErrorLevel
contracts:
  privkey: b089cfacd1687110d0db143837d0113429e50389d5bf862f8fe84a2b78fd844a ## consistent with index3 account's private key in ganache
  endpoint: http://192.168.0.104:7545
  chainid: 1337
```

## Execute and test

### Start gateway and clients

```shell
### Start a new terminal
cd txmeshdemo
. /gateway

#start a new terminal
cd $HOME/node1
. /clients

#start a new terminal
cd $HOME/node2
. /clients

#start a new terminal
cd $HOME/node3
. /clients
```

### test

```shell
## Deploy the api for txmeshdemo
http://192.168.204.152:8752/contract/deploy/3/2
Return the contract address, e.g. 0fb07F0A075c175Db3866B55Ab98F7e01d287972

##each node executes inputNumber
http://192.168.204.152:8753/contract/input/0fb07F0A075c175Db3866B55Ab98F7e01d287972/123 ##node1 input 123
http://192.168.204.152:8754/contract/input/0fb07F0A075c175Db3866B55Ab98F7e01d287972/124 ##node2 input 124
http://192.168.204.152:8755/contract/input/0fb07F0A075c175Db3866B55Ab98F7e01d287972/125 ##node3 Enter 125

##gateway node gets results (after collection)
http://192.168.204.152:8752/contract/avg/0fb07F0A075c175Db3866B55Ab98F7e01d287972
The result is 12400. To solve the decimal problem, the result needs to be divided by 10**2

```
