# 删除所有文件(除了public)
d=`pwd`
echo $d

if [ $d != "/data/go/canbefree.github.io" ]; then 
    echo "err: please cd $d first"
    exit
fi

ls |grep -vE 'public|deploy.sh' |xargs rm -r

mv public/* .

rm -rf public

git add .

git commit -m "sh commit" 

git push 