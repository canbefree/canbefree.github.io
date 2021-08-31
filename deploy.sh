# 删除所有文件(除了public)
ls |grep -vE 'publis|deploy.sh' |xargs rm -r


mv public/* .

rm -rf public

git add .

git commit -m "sh commit" 

git push 