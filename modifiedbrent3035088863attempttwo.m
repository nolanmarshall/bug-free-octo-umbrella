

function [root,info,callCount] = modifiedbrent3035088863attempttwo(fun, Int, params)
callCount = 0;
fa = fun(Int.a);
fb = fun(Int.b);
c = Int.b - (Int.b - Int.a)/(fb - fa) * fb;
fc = fun(c);
callCount = callCount + 2;
fta = 0;
ftb = 0;
if fc*fa<0
    
    newInt.a = min([Int.a,c]);
    if(newInt.a == Int.a)
        fta = fa;
        ftb = fc;
    else
        fta = fc;
        ftb = fb;
    end
    
    newInt.b = max([Int.a,c]);
    
elseif fc*fa>0
    
    newInt.a = min([Int.b,c]);
     
    newInt.b = max([Int.b,c]);
    if(newInt.b == Int.b)
        ftb = fb;
        fta = fc;
    else
        ftb = fc;
        fta = fa;
    end
else
    info.flag = 0;
    root = c;
    
    return
end
x0 = Int.a;
x1 = Int.b;
x2 = c;
dell0 = fa;
dell1 = fb;
dell2 = fc;
J = 0;

while J < 5 && J + 1 <= params.maxit
    x3 = (dell1*dell2*x0)/((dell0-dell1)*(dell0-dell2))+(dell0*dell2*x1)/((dell1-dell0)*(dell1-dell2))+(dell0*dell1*x2)/((dell2-dell0)*(dell2-dell1));
   
    callCount = callCount + 1;
    
    J = J + 1;
    Fx3 = fun(x3);
    
    if Fx3*fta<0
        newInt.a = min([newInt.a,x3]);
        if(newInt.a == x3)
            ftb = fta;
            fta = Fx3;
        else
            ftb = Fx3;
        end
        newInt.b = max([newInt.a,x3]);
        
    elseif Fx3*ftb<0
        newInt.a = min([newInt.b,x3]);
        if newInt.a == x3
            fta = Fx3;
        else
            fta = ftb;
            ftb = Fx3;
        end
        newInt.b = max([newInt.b,x3]);
        
    else
        if abs(Fx3)<=params.func_tol 
            root = x3;
            info.flag = 0;
        
        else
            root = x3;
            info.flag =1;
        end
        return
    end
    
    if J == 5 && (newInt.b - newInt.a) >=(Int.b - Int.a)/2
        replacex3 = (Int.a + Int.b)/2;
        fReplace = fun(replacex3);
        callCount = callCount + 1;
        if fReplace*fa<0
            Int.a = min([Int.a,replacex3]);
            Int.b = max([Int.a,replacex3]);
            if(Int.a == replacex3)
                fb = fa;
                fa = fReplace;
            else
                fb = fReplace;
            end
        elseif fReplace*fa>0
            Int.a = min([Int.b,replacex3]);
            Int.b = max([Int.b,replacex3]);
            if Int.a == replacex3
                fa = fReplace;
            else
                fa = fb;
                fb = fReplace;
            end
        else
            
            if fReplace<=params.func_tol
                root = replacex3;
                info.flag = 0;
                return
            end
            
        end
         params.maxit = params.maxit - callCount - 1;
        [root, info,diffcount] = modifiedbrent3035088863attempttwo(fun, Int, params);
        callCount = callCount + diffcount;
        return
        
    end
    
    if abs(Fx3) >= 1/2 * abs(dell2) 
        replacex3 = (Int.a + Int.b)/2;
        fReplace = fun(replacex3);
        callCount = callCount + 1;
        if fReplace*fa<0
            Int.a = min([Int.a,replacex3]);
            Int.b = max([Int.a,replacex3]);
            if(Int.a == replacex3)
                fb = fa;
                fa = fReplace;
            else
                fb = fReplace;
            end
        elseif fReplace*fa>0
            Int.a = min([Int.b,replacex3]);
            Int.b = max([Int.b,replacex3]);
            if Int.a == replacex3
                fa = fReplace;
            else
                fa = fb;
                fb = fReplace;
            end
        else
            if fReplace<=params.func_tol
                root = replacex3;
                info.flag = 0;
                return
            end
                
            
        end
        params.maxit = params.maxit - callCount - 1;
        [root, info,diffcount] = modifiedbrent3035088863attempttwo(fun, Int, params);
        callCount = callCount + diffcount;
        return
    end
    
    if newInt.b - newInt.a < params.root_tol
        root = x3;
        info.flag = 0;
        

        return
    end
    if abs(Fx3) < params.func_tol
        root = x3;
        info.flag = 0;
        
        return
    end
        
    if J == 5
        
        J = 0;
    end
    x0 = x1;
    x1 = x2;
    x2 = x3;
    dell0 = dell1;
    dell1 = dell2;
    dell2 = Fx3;
    
end
root = x3;
info.flag = 1;
return
end