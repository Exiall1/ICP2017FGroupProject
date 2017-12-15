function numCells = physModel(t,N0,lambda,c)
    numCells = N0*exp(lambda*(1 - exp(-c*t)));
end