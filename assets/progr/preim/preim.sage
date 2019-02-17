def pairs(w):
    inv  = []
    ninv = []
    for i,u in enumerate(w):
        for v in w[i+1:]:
            if u > v:
                inv.append((u,v))
            else:
                ninv.append((u,v))
    return inv, ninv

def candS(d,w):
    if d == 1:
        return [w]
    if w:
        w = w[:]
        n = max(w)
        i = w.index(n)
        w.pop(i)			
        return [ x + [n] + y for j in range(i+1) for x in candS(d,w[:j]) for y in candS(d-1,w[j:]) ]
    else:
        return [[]]

def element_in_region(perm, region):
    for i,u in enumerate(perm):
        if (i,u) in region and (i,u-1) in region and (i+1,u) in region and (i+1,u-1) in region:
            return True
    return False
	
def dstack_preim(d, patt, cand):
    res = [ (cand,Set([]),Set([]),Set([]),Set([])) ]
    n = len(cand)
    patt_inversions, _ = pairs(patt)
    inv_cand = Permutation(cand).inverse()
    
    for (i,j) in pairs(cand)[0]:
        region1 = Set( [ (a,b) for a in [inv_cand(i) .. inv_cand(j) - 1] for b in [i .. n] ] )
        region2 = Set( [ (a,b) for a in [0 .. inv_cand(i) - 1] for b in [i .. n] ] )
        
        new_res = []
        for r in res:
            _,shadings,markings,avoiders,containers = r
            if (i,j) in patt_inversions:
                if not region1.issubset(shadings):
                    if element_in_region(cand,region1):
                        new_res.append(r)
                    else:
                        new_res.append( (
                            cand,
                            shadings,
                            markings.union( Set( [(region1.difference(shadings),1)] ) ), 
                            avoiders, 
                            containers) 
                        )
                    if not element_in_region(cand,region1) \
                       and all( not region2.issubset(d) for d,_ in avoiders ) \
                       and all( not m.issubset(shadings.union(region1)) for m,_ in markings) \
                       and all( not c.issubset(shadings.union(region1)) for c,_ in containers):
                        new_res.append( (
                            cand,
                            shadings.union(region1),
                            markings,
                            avoiders,
                            containers.union(Set([(region2,d-1)]))) 
                        )
            elif not element_in_region(cand,region1) \
                 and all( not c.issubset(region2) for c,_ in containers ) \
                 and all( not m.issubset(shadings.union(region1)) for m,_ in markings) \
                 and all( not c.issubset(shadings.union(region1)) for c,_ in containers):
                new_res.append( (
                    cand,
                    shadings.union(region1),
                    markings,
                    avoiders.union(Set([(region2,d-1)])),
                    containers) 
                )
        res = new_res
    return res

def q_split(p):
    m = -Infinity
    lmax = []
    rest = []
    for i in p:
        if i > m:
            lmax.append(i)
            m = i
        else:
            rest.append(i)
    return lmax,rest

def candQ(word):
    cands = []
    lmax, rest = q_split(word)
    lmax_set = Set(lmax)
    for p in Permutations(len(word)):
        lm, r = q_split(p)
        if Set(lm).issubset(lmax_set) and r == [w for w in word if w not in lm]:
            cands.append(p)
    return cands
	
	
def queue_preim(patt, cand):
    res = [ (cand,Set([]),Set([]),Set([]),Set([])) ]
    n = len(cand)
    patt_inversions, _ = pairs(patt)
    inv_cand = Permutation(cand).inverse()
    
    for (i,j) in pairs(cand)[0]:
        region1 = Set( [ (a,b) for a in [inv_cand(i) .. inv_cand(j) - 1] for b in [i .. n] ] )
        region2 = Set( [ (a,b) for a in [0 .. inv_cand(i) - 1] for b in [i .. n] ] )
        
        new_res = []
        for r in res:
            _,shadings,markings,avoiders,containers = r
            if (i,j) in patt_inversions:
                if not region2.issubset(shadings):
                    if element_in_region(cand,region2) \
                       or any( m.issubset(region2) for m,_ in markings ):
                        new_res.append(r)
                    else:
                        new_res.append( (
                            cand,
                            shadings,
                            markings.union( Set( [(region2.difference(shadings),1)] ) ), 
                            avoiders, 
                            containers) 
                        )
                    if not element_in_region(cand,region2) \
                       and all( not region1.issubset(d) for d,_ in avoiders ) \
                       and all( not m.issubset(shadings.union(region2)) for m,_ in markings) \
                       and all( not c.issubset(shadings.union(region2)) for c,_ in containers):
                        new_res.append( (
                            cand,
                            shadings.union(region2),
                            markings,
                            avoiders,
                            containers.union(Set([(region1,Permutation([2,1]))]))) 
                        )
            elif not element_in_region(cand,region2) \
                 and all( not c.issubset(region1) for c,_ in containers ) \
                 and all( not m.issubset(shadings.union(region2)) for m,_ in markings) \
                 and all( not c.issubset(shadings.union(region2)) for c,_ in containers):
                new_res.append( (
                    cand,
                    shadings.union(region2),
                    markings,
                    avoiders.union(Set([(region1,Permutation([2,1]))])),
                    containers) 
                )
        res = new_res
    return res