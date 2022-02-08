rm -rf clients gateway log/
rm -rf ~/node1 ~/node2 ~/node3
mkdir -p ~/node1/conf  ~/node2/conf ~/node3/conf

go build -mod=mod ./cmd/clients/
go build -mod=mod ./cmd/gateway/

cp ./conf/clients.yaml ~/node1/conf/clients.yaml
cp ./conf/clients.yaml ~/node2/conf/clients.yaml
cp ./conf/clients.yaml ~/node3/conf/clients.yaml

sed -i 's/addr: :8753/addr: :8754/g' ~/node2/conf/clients.yaml
sed -i 's#node1#node2#g' ~/node2/conf/clients.yaml

sed -i 's/addr: :8753/addr: :8755/g' ~/node3/conf/clients.yaml
sed -i 's#node1#node3#g' ~/node3/conf/clients.yaml

cp clients ~/node1/clients
cp clients ~/node2/clients
cp clients ~/node3/clients