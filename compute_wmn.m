function wmn = compute_wmn(lead)
n = size(lead, 2);
for i = 1:n
    v(i) = (lead(:,i)')*(lead(:,i));
end
wmn = diag(v);
end