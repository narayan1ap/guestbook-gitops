items=$(aws ec2 describe-volumes --filters Name=tag-key,Values=$1 | jq -r .Volumes | jq -c -r '.[]')
for item in ${items[@]}; do
    volumeid=$(echo $item | jq -r .VolumeId)
    sudo -E elastio ebs backup --volume-id $volumeid
done
elastio rp list --ebs
