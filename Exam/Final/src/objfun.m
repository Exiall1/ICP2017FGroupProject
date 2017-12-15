function out = objfun(v,tdata,cellsdata)
    out = -sum(log(((1)./(cellsdata*v(3)*sqrt(2*pi))).*exp((-(log(cellsdata)-log(physModel(tdata,100000,v(1),v(2)))).^2)./(2*v(3)^2))));
end