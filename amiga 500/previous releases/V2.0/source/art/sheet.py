import sys, importlib, time
sys.path.insert(0,'/home/claude/adv')
from paint import finish
from PIL import Image
mod=importlib.import_module(sys.argv[1])
names=sys.argv[2:] or list(mod.SCENES)
ims=[]
for n in names:
    t=time.time(); cv=mod.SCENES[n](); r=finish(cv,name=n); ims.append((n,r['preview']))
    print(n, f'{time.time()-t:.1f}s', flush=True)
cols=3
Wd=Image.new('RGB',(cols*330,((len(ims)+cols-1)//cols)*200),(40,40,40))
for i,(n,im) in enumerate(ims): Wd.paste(im,((i%cols)*330,(i//cols)*200))
Wd.save(f'/tmp/claude-0/sheet_{sys.argv[1]}.png')
