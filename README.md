
# ☆☆☆ “MrLjhPhotos” ☆☆☆

### 支持pod导入

* pod 'MrLjhPhotos','~> 3.0.2'

* 执行pod search MrLjhPhotos提示搜索不到，可以执行以下命令更新本地search_index.json文件
  
```objc 
rm ~/Library/Caches/CocoaPods/search_index.json
```
* 如果pod search还是搜索不到，执行pod setup命令更新本地spec缓存（可能需要几分钟），然后再搜索就可以了
