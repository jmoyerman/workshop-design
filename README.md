# workshop-design



![workshop image](image.png)


## Generate Image
```sh
cat .git/hooks/pre-commit
#!/bin/sh

exec openscad -o image.png workshop.scad
git add image.png
```
